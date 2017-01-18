require 'watir'
require 'fileutils'
require 'open-uri'
require_relative './constants'
require_relative './lib/pages/login_page'
require_relative './lib/pages/episode_page'
require_relative './lib/pages/episodes_page'
require_relative './lib/extractors/save_content_html'
require_relative './lib/extractors/save_page_source'
require_relative './lib/extractors/save_video'
require 'pry'
require 'net/https'

BROWSER = LoggedBrowser.new.call

class RubyTapasDownloader
  def call
    create_save_dir { log_status_update('SETUP DIRECTORY') }
    get_episode_links { log_status_update('LISTING ALL EPISODES IN CATALOG') }
    download_missing_episodes { log_status_update('DOWNLOADING MISSING EPISODES') }
  ensure
    BROWSER.close
  end

  private

  def create_save_dir
    FileUtils::mkdir_p SAVE_DIRECTORY
  end

  def get_episode_links
    yield if block_given?

    @get_episode_links ||= EpisodesPage.new(BROWSER).get_episode_links
  end

  def download_missing_episodes
    yield if block_given?

    get_episode_links.map(&:href).each do |href|
      log_status_update(href)
      EpisodeLink.new(href).call
    end
  end
end

def log_status_update(update)
  puts "--- #{update} ---"
end

unless (CA_FILE.nil? || CA_FILE.empty?) then
  module Net
    class HTTP
      alias_method :original_use_ssl=, :use_ssl=

      def use_ssl=(flag)
        self.ca_file = CA_FILE
        self.verify_mode = OpenSSL::SSL::VERIFY_PEER
        self.original_use_ssl = flag
      end
    end
  end
end

RubyTapasDownloader.new.call
