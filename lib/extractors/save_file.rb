# Abstract
class SaveFile < Struct.new(:browser, :episode_directory)
  def call
    create_save_directory

    File.open(file_path, 'wb') do |f|
      f.write data
    end
  end

  private

  def data
    raise 'implement a way to get the file we want'
  end

  def data_name
    raise 'implement a name for the file'
  end

  def create_save_directory
    return if File.exists?(save_directory)

    FileUtils.mkdir_p(save_directory)
  end

  def save_directory
    "#{SAVE_DIRECTORY}/#{episode_directory}"
  end

  def file_path
    "#{save_directory}/#{data_name}"
  end
end