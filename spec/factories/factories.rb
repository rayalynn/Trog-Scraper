FactoryGirl.define do
  factory :bad_site, class: LinkExtractor do
    ignore do
      page_url       "htt://randomgib.com"
      max_entries    -5
      post_matcher   "h1 a.subject"
      next_page_matcher           "page/"
      starting_page               1
      starting_page_incrementor   3
    end
    initialize_with { new(page_url, max_entries, post_matcher, next_page_matcher,
                          starting_page, starting_page_incrementor) }
  end

  factory :css_search, class: LinkExtractor do
    ignore do
      page_url                   "http://just-eat-your-cupcake.blogspot.com/"
      max_entries                20 
      post_matcher              "h3.post-title.entry-title a"
      next_page_matcher         "a.blog-pager-older-link"
      starting_page              -1
      starting_page_incrementor  -1
    end
    initialize_with { new(page_url, max_entries, post_matcher, next_page_matcher,
                          starting_page, starting_page_incrementor) }
  end

  factory :url_search, class: LinkExtractor do
    ignore do
      page_url                   "http://squid314.livejournal.com"
      max_entries                20
      next_page_matcher          "?skip="
      post_matcher              "td.caption a.subj-link"
      starting_page              0 
      starting_page_incrementor  10
    end
    initialize_with { new(page_url, max_entries, post_matcher, next_page_matcher,
                          starting_page, starting_page_incrementor) }
  end
end
