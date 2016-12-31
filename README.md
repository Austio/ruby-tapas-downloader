# Updates
Make sure your selinum-webdriver is at version 3
https://github.com/mozilla/geckodriver/releases download this and put it somewhere in your path

# ruby-tapas-downloader
RubyTapas 2.0 download

Web scraper for gathering and arranging new rubytapas content

Steps

1. gem install 'watir'
2. Fill out constants.rb with your
  a. your username and password
  b. optional: a different directory if you don't want the default RubyTapas
3. in terminal run `ruby ruby-tapas-downloader`

The downloader will put your episodes in this format

````
  /RubyTapas (as defined in your constants.rb file)
   /EPISODE_TITLE_FROM_RUBYTAPAS
     /episode.mp4       #video episode
     /full_page.html    #page html with all links
     /page_content.hrml #page_content div from page
