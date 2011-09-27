class BarController < ApplicationController

  def rubypython
    RubyPython.start
    
    cPickle = RubyPython.import("cPickle")
    out = cPickle.dumps("Testing RubyPython.").rubify
    
    RubyPython.stop

    render :text => out
  end

  def foo
    RubyPython.start

    sys = RubyPython.import('sys')
    sys.path.append(Rails.root.to_s+'/app/python/foo')
    
    bar = RubyPython.import('bar')

    out = bar.baz().rubify

    RubyPython.stop

    render :text => out
  end

  def seq_check

  end

  def seq_check_start
    RubyPython.start

    out = 'no output'

    begin
      sys = RubyPython.import('sys')
      sys.path.append(Rails.root.to_s+'/app/python/seq_checker')
      checkseq = RubyPython.import('checkseq')
      
      out = checkseq.run_checker.rubify
    ensure
      RubyPython.stop
    end

    redirect_to '/seq_checker/summary.html'
  end


  def seq_check_reset
    dir = "#{Rails.root}/app/python/seq_checker/traces"
    Dir.foreach(dir) do |filename|
      if File.file?(filename)
        File.delete(filename)
      end
    end
#    Dir.rmdir(dir)
    flash[:notice] = "Reset complete!"
    redirect_to :action => :seq_check
  end

  def seq_check_upload

    if !params['file']
      render :text => params.inspect, :status => 404
      return
    end

    d = DataFile.new(params['file'])
    d.write_file

    render :text => 'upload complete'
  end


  def features

    features = Feature.find(:all)

    render :text => features.collect {|f| f.dna_sequence}.join(', ')

  end

  def upload

    if !params['file']
      render :text => params.inspect, :status => 404
      return
    end

    d = DataFile.new(params['file'])
    d.save!

    render :text => 'upload complete'

  end

end
