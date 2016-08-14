# ruby-tapas-downloader
RubyTapas 2.0 download

Web scraper for gathering and arranging new rubytapas content

Steps

1. gem install 'watir'
2. Fill out constants.rb with your username and password and a directory if you don't want the default RubyTapas
3. in terminal run `ruby ruby-tapas-downloader`

The downloader will put your episodes in this format
 /RubyTapas
   /EPISODE_TITLE_FROM_RUBYTAPAS
     /episode.mp4       #ideo episode
     /full_page.html    #page html with all links
     /page_content.hrml #page_content div from page