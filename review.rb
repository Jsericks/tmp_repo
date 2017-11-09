# frozen_string_literal: true
require "nokogiri"
require "sentimentalizer"

class Review
  ##### ATTR ACCESSORS #####
  attr_accessor :title, :star_count, :review_content, :disposition, :disposition_score

  ##### INIT #### 
  def initialize(nodes)
    set_title(nodes)
    set_star_count(nodes)
    set_review_content(nodes)
  end

  ##### INSTANCE METHODS #####
  def set_title(nodes)
    @title = nodes.css("h3").first.content
  end

  def set_star_count(nodes)
    star_rating_class = nodes.css("div.dealership-rating>div").first["class"]&.scan(/rating-[0-5]+/)&.first
    @star_count = star_rating_class.gsub("rating-", "")
  end

  def set_review_content(nodes)
    @review_content = nodes.css("div.review-wrapper>p.review-content")&.first.content
  end
end
