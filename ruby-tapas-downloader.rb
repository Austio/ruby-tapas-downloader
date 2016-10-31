require 'watir-webdriver'
require 'fileutils'
require 'open-uri'
require_relative './constants'
require_relative './lib/pages/login_page'
require_relative './lib/pages/episode_page'
require_relative './lib/pages/episodes_page'
require_relative './lib/extractors/save_content_html'
require_relative './lib/extractors/save_page_source'
require_relative './lib/extractors/save_video'

class RubyTapasDownloader
  def call
    create_save_dir { log_status_update('SETUP DIRECTORY') }
    login { log_status_update('LOGGING IN')}
    get_episode_links { log_status_update('LISTING ALL EPISODES IN CATALOG') }
    download_missing_episodes { log_status_update('DOWNLOADING MISSING EPISODES') }

  ensure
    browser.close
  end

  private

  def browser
    @browser ||= Watir::Browser.new
  end

  def create_save_dir
    FileUtils::mkdir_p SAVE_DIRECTORY
  end

  def login
    yield if block_given?

    LoginPage.new(browser).login
  end

  def get_episode_links
    yield if block_given?

    @get_episode_links ||= EpisodesPage.new(browser).get_episode_links
  end

  def download_missing_episodes
    yield if block_given?

    get_episode_links.each do |link_obj|
      EpisodePage.new(browser, link_obj).download_episode
    end
  end
end

def log_status_update(update)
  puts "--- #{update} ---"
end

RubyTapasDownloader.new.call
