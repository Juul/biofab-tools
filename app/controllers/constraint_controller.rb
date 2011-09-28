class ConstraintController < ApplicationController

  def query
    @target = params['expression_level'].to_f

    @limit = (params['limit']) ? params['limit'].to_i : 10
    if params['show_all']
      @limit = nil
    end

    tolerance = params['tolerance'].to_f

    max = (@target + tolerance) / 100.0
    min = (@target - tolerance) / 100.0

    # -- build conditions based on input parameters

    conds = []

    if params['promoter_contains'] && (params['promoter_contains'] != '')
      str = '%' + params['promoter_contains'] + '%'
      conds << ["parts.sequence like ? AND part_types.name = ?", str, 'promoter']
    end

    if params['promoter_not_contains'] && (params['promoter_not_contains'] != '')
      str = '%' + params['promoter_not_contains'] + '%'
      conds << ["parts.sequence NOT like ? AND part_types.name = ?", str, 'promoter']
    end

    if params['utr_contains'] && (params['utr_contains'] != '')
      str = '%' + params['utr_contains'] + '%'
      conds << ["parts.sequence like ? AND part_types.name = ?", str, 'five_prime_utr']
    end

    if params['utr_not_contains'] && (params['utr_not_contains'] != '')
      str = '%' + params['utr_not_contains'] + '%'
      conds << ["parts.sequence NOT like ? AND part_types.name = ?", str, 'five_prime_utr']
    end

    conds << ["normalized <= ? AND normalized >= ?", max, min]
    
    # -- turn conitions into nice array

    sqls = []
    args = []
    conds.each do |cond|
      sqls << '('+cond[0]+')'
      args += cond[1..-1]
    end

    conditions = [sqls.join(' AND ')] + args

    # -- do the query

    @exps = ExpressionLevel.find(:all,
                                 :conditions => conditions,
                                 :joins => [{:promoter => :part_type}, {:utr => :part_type}],
                                 :order => "ABS(normalized - #{@target}/100) asc",
                                 :limit => @limit)

    render :partial => 'results'
  end

  def search
    
  end

  def search2
    render :layout => 'constraint'    
  end


  def renormalize

    max = 0
    exps = ExpressionLevel.find(:all)
    exps.each do |exp|
      if exp.average > max
        max = exp.average
      end
    end

    exps.each do |exp|
      exp.normalized = exp.average / max
      exp.save!
    end

    render :text => "updated #{exps.length} records"

  end

  def mailfoo
    
    exp = ExpressionLevel.find(:first)
    exp.delay.foo
    render :text => "done: #{Time.now}"
  end



end
