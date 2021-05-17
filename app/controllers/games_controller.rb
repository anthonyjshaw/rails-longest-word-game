# frozen_string_literal: true

require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @sample1 = ('a'..'z').to_a.sample(10)
    @sample2 = ('a'..'z').to_a.sample(10)
    @sample3 = @sample1.concat(@sample2).sample(10)
  end

  def in_grid?(attempt, grid)
    attempt.all? { |l| attempt.count(l) <= grid.count(l) }
  end

  def score
    @new_parse = parse
    @attempt = params[:word].chars
    @sample = params[:word_grid].split(' ')
    @score = if in_grid?(@attempt, @sample) && @new_parse['found']
               good_message
             elsif in_grid?(@attempt, @sample) && @new_parse['found'] == false
               bad_message
             elsif !in_grid?(@attempt, @sample)
               no_word_message
             end
    session[:score] = 0 if session[:score].nil?
    session[:score] += @score
  end

  def reset
    @reset = reset_session
    redirect_to new_path
  end

  private

  def parse
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @parse = JSON.parse(URI.open(url).read)
  end

  def good_message
    @message1 = 'Well done!'
    @message2 = 'is in the grid and is a word!'
    @new_parse['length'].to_i
  end

  def bad_message
    @message1 = 'Sorry!'
    @message2 = 'is not a word! Try again!'
    0
  end

  def no_word_message
    @message1 = 'Sorry!'
    @message2 = "can't be built out of #{@sample.join(', ').upcase}"
    0
  end
end
