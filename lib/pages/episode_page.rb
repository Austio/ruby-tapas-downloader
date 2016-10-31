class EpisodePage < Struct.new(:browser, :link_obj)

  def download_episode
    return if episode_exists?
    browser.goto episode_url

    save_full_html
    save_content_html
    save_video
  end

  def episode_exists?
    Dir.entries("#{SAVE_DIRECTORY}").detect{|e| e.include?(link_obj[:episode_number])}
  end

  def save_directory
    "#{SAVE_DIRECTORY}/#{episode_title}"
  end

  def episode_url
    link_obj[:href]
  end

  def episode_title
    [link_obj[:episode_number], link_obj[:episode_name]].join('-').gsub('/', '')
  end

  def save_full_html
    SavePageSource.new(browser, episode_title).call
  end

  def save_content_html
    SaveContentHtml.new(browser, episode_title).call
  end

  def save_video
    SaveVideo.new(browser, episode_title).call
  end
end
