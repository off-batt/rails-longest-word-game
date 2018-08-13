require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    chars = ('a'..'z').to_a
    @letters = Array.new(10) { chars[rand(chars.length)] }.join
  end

  def score
    @score = 0
    @letters = params[:letters]
    @answer = params[:answer]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    item = open(url).read
    @result = JSON.parse(item)
    if @result["found"]
      comparing = @answer.upcase.chars - @letters.upcase.chars
      if comparing.size == 0
        @win_or_loose = "Congratulation! '#{@answer}' is a good answer!"
        @score += @answer.size
      else
        @win_or_loose = "Not matching with the grid"
      end
    else
      @win_or_loose = "Not an english word"
    end
  end
end
