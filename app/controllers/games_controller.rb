require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do 
      @letters << [*'a'..'z'].sample
    end
  end

  def score
    word = params[:word]
    letters = JSON.parse(params[:letters])
    guess_letters = word.chars
    @count = guess_letters.all? {|letter| word.count(letter) <= letters.count(letter)}
    if @count
      #check if it's a valid english word
      valid_word_check =  URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
      is_valid = JSON.parse(valid_word_check)["found"]
      if is_valid
        @result = "Hooray, you guessed a valid word"
      else
        @result = "Sorry, #{word} is not an English word :( "
      end
    else
      @result = "Sorry, you can't build #{word} with these letters"
    end
  end
end
