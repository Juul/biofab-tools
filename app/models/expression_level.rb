class ExpressionLevel < ActiveRecord::Base

  belongs_to :promoter, :class_name => 'Part', :foreign_key => 'promoter_part_id'
  belongs_to :utr, :class_name => 'Part', :foreign_key => 'fiveprime_part_id'

  # within how many percent of target
  def diff(target)
    diff = (target.to_f - self.normalized.to_f * 100).abs.ceil
    return diff
  end

  def self.calc_score(s1, s2)

    f1 = Tempfile.new('s1')
    f1.write(s1)
    f1.close

    f2 = Tempfile.new('s2')
    f2.write(s2)
    f2.close
    
    out_path = '/tmp/water_out'

    output = `water -gapopen 10.0 -gapextend 0.5 #{f1.path} #{f2.path} #{out_path}`
    
    res = File.new(out_path)
    lines = res.readlines
    res.close
    
    longline = ''

    lines.each do |line|
      next if line[0..0] == '#'
      matches = line.scan(/(\|+)/)
      next if !matches || !matches[0]
      longline += line
    end

    longline = longline.gsub(/\s+/, '')
    score = 0

    matches = longline.scan(/(\|+)/)
    if !matches || (matches.length == 0)
      return 0
    end

    matches.each do |match|
      next if match.length == 0
      if match[0].length > score
        score = match[0].length
      end
    end

    f1.unlink
    f2.unlink

    return score

  end

  def foo
    sleep 15
    ResultMailer.foo.deliver
  end


end
