require 'watir'
require 'fileutils'
require 'open-uri'
require_relative './constants'
require_relative './lib/login_page'
require_relative './lib/home_page'
require_relative './lib/episode_page'


class RubyTapasDownloader
  def call
    login
    download_latest_episode

  ensure
    browser.close
  end

  private

  def browser
    @browser ||= Watir::Browser.new
  end

  def login
    log_status_update('LOGGING IN')
    LoginPage.new(browser).login
  end

  def latest_episode_url
    log_status_update('GETTING LATEST EPISODE URL')
    HomePage.new(browser).get_featured_url
  end

  def download_latest_episode
    log_status_update('DOWNLOADING LATEST EPISODE')
    EpisodePage.new(browser, latest_episode_url).download_episode
  end
end

def log_status_update(update)
  puts "--- #{update} ---"
end

RubyTapasDownloader.new.call
