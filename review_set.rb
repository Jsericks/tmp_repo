# frozen_string_literal: true

require "sentimentalizer"
require_relative "./review"

class ReviewSet
  ##### CONSTANTS #####
  SENTIMENT_MAP = {
    ":)" => "positive",
    ":(" => "negative",
    ":|" => "neutral"
  }.freeze

  ##### ATTR ACCESSORS #####
  attr_accessor :reviews

  def self.merge_review_sets(review_sets)
    rs = self.new()
    review_sets.each do |r|
      rs.reviews.push(r.reviews).flatten!
    end
    return rs
  end

  ##### INIT #####
  def initialize
    Sentimentalizer.setup
    @reviews = []
  end

  ##### INSTANCE METHODS #####
  def add_review(review)
    @reviews.push(analyze_and_set_dispostion(review))
  end

  def analyze_and_set_dispostion(review)
    analysis = analyze(review.review_content)
    review.disposition = SENTIMENT_MAP[analysis.sentiment]
    review.disposition_score = analysis.overall_probability.to_f
    review
  end

  def analyze(text)
    Sentimentalizer.analyze(text)
  end

  def top_n_reviews(n)
    @reviews.sort_by{ |a| a&.disposition_score }.take(n)
  end

  def bottom_n_reviews(n)
    @reviews.sort_by{ |a| a&.disposition_score }.reverse.take(n)
  end

  def score_reviews
    @reviews.each do |review|
      analyze_and_set_dispostion(review)
    end
  end
end
