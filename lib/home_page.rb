class HomePage < Struct.new(:browser)
  def get_featured_url
    browser.goto homepage_url
    header = browser.header class: header_class
    links = header.links
    episode_anchor = links.find{ |a| a.href.match episode_regex }

    episode_anchor.href
  end

  private

  def homepage_url
    'rubytapas.com/login'
  end

  def header_class
    'entry-header'
  end

  def episode_regex
    /.*(episode).*/i
  end
end
