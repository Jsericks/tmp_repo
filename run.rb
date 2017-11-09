# frozen_string_literal: true

##### BUNDLER / RUBYGEMS SETUP ####
require "rubygems"
require "bundler/setup"

##### EXTERNAL GEM LOAD #####
require "table_print"
require "mechanize"

##### REQUIRE RELATIVES #####
require_relative "./review_set"
require_relative "./review_page"

def get_n_pages(n)
  pages = (1..n).map do |page_num|
    page = ReviewPage.new(page_num)
  end
  full_review_set = ReviewSet.merge_review_sets(pages.map{|rp| rp.generate_review_set })
  puts "REVIEW COUNT #{full_review_set.reviews.size}"
  top_three = full_review_set.bottom_n_reviews(30)
  display_reviews(top_three)
end

def display_reviews(reviews)
  tp reviews
  puts
end

# get_n_pages(1)

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

page = a.get("http://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=ALL_REVIEWS#link")

pp page.search(".review-entry").first.class
