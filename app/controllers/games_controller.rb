require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letters = ("A".."Z").to_a
    @grid = []
    10.times { @grid << letters.sample }
    return @grid
    @total_score = cookies[:total_score]
  end


  def score
    @grid = params[:grid]
    @option = params[:option]
    @score = 0
    @message = "Not an english word"

    if JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@guess}").read)['found'].to_s == 'true'
      @message = "well done"
    end

    @option.upcase.split(" ").each do |letter|
      unless @grid.include?(letter) && @option.upcase.count(letter) <= @grid.count(letter)
        @message = "not in the grid"
        @score = 0
      end
    end
    @total_score = @total_score.to_i
    @total_score += @score
    cookies[:total_score] = @total_score
  end
end
