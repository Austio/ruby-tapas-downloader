require_relative '../pages/login_page'
require_relative '../classes/logged_browser'

class EpisodePage < Struct.new(:link_obj)
  def browser
    BROWSER
  end

  def download_episode
    return if episode_exists?
    browser.goto episode_url
    login_if_needed

    save_full_html
    save_content_html
    save_video
  end

  def login_if_needed
    if browser.forms.any? { |f| f.text && f.text.downcase.include?('password') }
      LoginPage.new(browser).submit_login
      sleep 10 #TODO(use Watir::Wait)
    end
  end

  def episode_exists?
    return false unless Dir.exists?(save_directory)
    return true if all_episode_files_have_data?

    false
  end

  def save_directory
    @save_directory = File.join(SAVE_DIRECTORY, episode_title)
  end

  def all_episode_files_have_data?

    Dir.entries(save_directory).all? do |f|
      path = File.join(save_directory, f)

      # skip . and ..
      return true unless File.file?(path)

      File.stat(path).size > 0
    end
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
