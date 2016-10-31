class EpisodesPage < Struct.new(:browser)

  def get_episode_links
    @episode_links or browser.goto(page_url)

    episode_links
  end

  def episode_links
    @episode_links ||= links.each_with_object([]) do |l, obj|
      link = LinkHref.new(l.href)
      next unless link.is_episode?

      obj << link.to_hash
    end
  end

  def links
    @links ||= browser.links
  end

  def page_url
    "#{TAPAS_BASE_URL}/episode-list"
  end

  # link format is episode-DDD-episode-title
  class LinkHref < Struct.new(:href)
    def is_episode?
      episode_regex
    end

    def episode_regex
      @episode_regex ||= href.match(/(episode-)(?<episode_number>\d{3})(-)(?<episode_name>.*)/)
    end

    def to_hash
      @to_hash ||= {
        href: href,
        episode_number: episode_regex[:episode_number],
        episode_name: episode_regex[:episode_name]
      }
    end
  end

end
