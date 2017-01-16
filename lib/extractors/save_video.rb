require_relative './save_file'

class SaveVideo < SaveFile
  def call
    create_save_directory

    File.open(file_path, 'wb') do |f|
      f << open(data).read
    end
  end

  private

  def data
    links = browser.links
    video_link = links.find{|a| a.html.match video_link_regex}
    video_link.href
  end

  def data_name
    "#{episode_directory}.mp4"
  end

  def video_link_regex
    /.*(download).*(episode)/i
  end
end
