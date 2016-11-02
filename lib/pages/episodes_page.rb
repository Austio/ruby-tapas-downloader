require_relative '../classes/episode_link'

class EpisodesPage < Struct.new(:browser)
  def get_episode_links
    @links or browser.goto(page_url)

    links
  end

  def links
    @links ||= browser.links
  end

  def page_url
    "#{TAPAS_BASE_URL}/episode-list"
  end
end
