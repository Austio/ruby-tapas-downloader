# Abstract
class SaveFile < Struct.new(:browser, :episode_directory)
  def call
    create_save_directory

    File.open(file_path, 'w') do |f|
      f << file
    end
  end

  private

  def file
    raise 'implement a way to get the file we want'
  end

  def file_name
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
    "#{save_directory}/#{file_name}"
  end
end