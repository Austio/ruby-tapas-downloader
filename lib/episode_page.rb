class EpisodePage < Struct.new(:browser, :episode_url)

  def download_episode
    browser.goto episode_url

    return if episode_exists?

    create_save_directory

    save_full_html
    save_content_html
    save_video
  end

  private

  def episode_exists?
    File.exists?(save_directory)
  end

  def save_directory
    "#{SAVE_DIRECTORY}/#{episode_title}"
  end

  def episode_title
    browser.title
  end

  def save_full_html
    File.open(file_directory('full_page.html'), 'w+') do |f|
      f.write browser.driver.page_source
    end
  end

  def save_content_html
    File.open(file_directory('page_content.html'), 'w') do |f|
      div = browser.div class: 'entry-content'
      html = div.html

      f.write html
    end
  end

  def save_video
    video_link_regex = /.*(download).*(episode)/i

    File.open(file_directory('episode.mp4'), 'w') do |f|
      links = browser.links
      video_link = links.find{|a| a.html.match video_link_regex}
      video_href = video_link.href

      f << open(video_href).read
    end
  end

  def file_directory(file_name)
    "#{save_directory}/#{file_name}"
  end

  def create_save_directory
    FileUtils.mkdir_p(save_directory)
  end
end
