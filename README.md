# Updates
Make sure your selinum-webdriver is at version 3
https://github.com/mozilla/geckodriver/releases download this and put it somewhere in your path

# ruby-tapas-downloader
RubyTapas 2.0 download

Web scraper for gathering and arranging new rubytapas content

Steps

1. gem install 'watir'
2. Copy the `constants.rb.example` file to `constants.rb`
3. Fill out constants.rb with your:
   - your username and password
   - optional: a different directory if you don't want the default RubyTapas
   - if your encounter certificate failure, download the ca-bundrle.crt from below and
   change the CA_FILE to eg.'lib/ca-bundle.crt'
4. In a terminal run `ruby ruby-tapas-downloader`

The downloader will put your episodes in this format

````
  /RubyTapas (as defined in your constants.rb file)
   /EPISODE_TITLE_FROM_RUBYTAPAS
     /episode.mp4       #video episode
     /full_page.html    #page html with all links
     /page_content.hrml #page_content div from page
````

##### Windows users
You may encounter the `ruby SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (OpenSSL::SSL::SSLError)`
This error is due to Ruby not being able to find the certification authority 
certificates (CA Certs) used to verify the authenticity of secured web servers. 
The solution is to download the this [ca-bundle.crt](http://curl.haxx.se/ca/ca-bundle.crt) and 
add it to lib/ directory.