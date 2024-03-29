
class DataFile < ActiveRecord::Base

  attr_accessor :filename
  
  after_save :write_file
  after_destroy :delete_file

  def self.from_data(data, filename)
    @filename = sanitize_filename(filename)
    if !File.exists?(File.dirname(path_to_file))
      Dir.mkdir(File.dirname(path_to_file))
    end    
    File.open(self.path_to_file, "wb") { |f| f.write(data) }
  end

  def file=(uploaded_file)  
    @uploaded_file = uploaded_file
    @filename = sanitize_filename(@uploaded_file.original_filename)
    self.content_type = @uploaded_file.content_type
  end
  
  def write_file
    if File.exists?(path_to_file)
      return
    end
#    if !File.exists?(File.dirname(path_to_file))
#      Dir.mkdir(File.dirname(path_to_file))
#    end
    if @uploaded_file.instance_of?(Tempfile)
      FileUtils.copy(@uploaded_file.local_path, path_to_file)
    else
      File.open(self.path_to_file, "wb") { |f| f.write(@uploaded_file.read) }
    end
  end

  def delete_file
    if File.exists?(self.file)
      File.delete(self.file)
      Dir.rmdir(File.dirname(self.file))
    end
  end
  
  def path_to_file
#    File.expand_path("#{Rails.root}/upload/#{self.id}/#{@filename}")
    File.expand_path("#{Rails.root}/app/python/seq_checker/traces/#{@filename}")
  end
  
  private
  
  def sanitize_filename(filename)
    filename = File.basename(filename) 
    filename.gsub(/[^\w\.\_]/,'_') 
  end
  
end
