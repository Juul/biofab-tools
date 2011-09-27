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

    @exps = ExpressionLevel.find(:all,
                                 :conditions => ["normalized <= ? AND normalized >= ?", max, min],
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
