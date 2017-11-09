# frozen_string_literal: true

require "httparty"

require_relative "./review_set"
require_relative "./review"

class ReviewPage
  ##### ATTR ACCESSOR #####
  attr_accessor :page_num, :parsed_page
  attr_reader :page_link, :review_set

  ##### INIT #####
  def initialize(page_num)
    @page_number = page_num
    @review_set = ReviewSet.new()
    @page_link = "http://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-review-23685/page#{@page_number}/?filter=ALL_REVIEWS#link"
  end

  ##### INSTANCE METHODS #####
  def retrieve_page
    puts "Fetching Page ##{@page_number}"
    HTTParty.get(@page_link)
  end

  def parsed_page
    @parsed_page ||= Nokogiri::HTML.parse(retrieve_page())
  end

  def extract_top_level_nodes
    parsed_page.css(top_level_node_path)
  end

  def generate_review_set
    extract_top_level_nodes.each do |nodes|
      @review_set.add_review(Review.new(nodes))
    end
    @review_set
  end

  private
  def top_level_node_path
    ".review-entry"
  end
end