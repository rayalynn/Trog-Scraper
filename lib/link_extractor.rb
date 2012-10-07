require 'nokogiri'
require 'open-uri'

class LinkExtractor 
  # Scrapes a website and stores the links to its posts in an array 

  attr_reader :link_list

  def initialize(page_url, max_entries=10, post_matcher, next_page_matcher,
                 starting_page, starting_page_incrementor)
    @page_url = page_url
    @max_entries =  max_entries 
    @post_matcher = post_matcher
    @next_page_matcher = next_page_matcher
    @starting_page = starting_page
    @starting_page_incrementor = starting_page_incrementor
    @link_list = []
  end

  def get_next_page_url(current_page=@page_url)
    if search_via_css? 
      "Puts Searching CSS"
      page = Nokogiri::HTML(open(current_page))
      next_page = page.css(@next_page_matcher)[0]['href']
    else
      puts "Searching URL"
      @starting_page += @starting_page_incrementor
      next_page = @page_url + "/" + @next_page_matcher + @starting_page.to_s
    end
  end

  def get_posts
    current_url = @page_url
    while post_limit_not_hit?
      puts "Opening: " + current_url 
      process_page(current_url)
      current_url = get_next_page_url(current_url)
    end
  end

  def search_via_css?
    @starting_page_incrementor == -1
  end

  #Put links to main posts in array link_list
  def process_page(current_url)
    current_page = Nokogiri::HTML(open(current_url))
    current_page.css(@post_matcher).each do |link|
      link_list << link['href']
      break if link_list.length >= @max_entries
    end
    puts "Current link_list: "
    puts link_list
  end

  def post_limit_not_hit?
    link_list.length < @max_entries
  end
end