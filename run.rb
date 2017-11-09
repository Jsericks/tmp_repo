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

def get_n_pages_take_top_n(page_total, return_total)
  pages = (1..page_total).map do |page_num|
    page = ReviewPage.new(page_num)
  end
  full_review_set = ReviewSet.merge_review_sets(pages.map{|rp| rp.generate_review_set })
  top_n = full_review_set.top_n_reviews(return_total)
  display_reviews(top_n)
end

def display_reviews(reviews)
  tp reviews
  puts
end

get_n_pages_take_top_n(5, 500)
