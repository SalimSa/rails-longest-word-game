require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    #The new action will be used to display a new random grid and a form.
    #The form will be submitted (with POST) to the score action.
    @letters = 10.times.map { ('a'..'z').to_a.sample }.join
  end

  def score
    @user_input = params[:user_input]
    @letters = params[:letters]
    @response = english_word?(@user_input) ? "Well done Bro" : "Sorry #{@user_input} does not seem to be a valid English word"
    included?(@user_input, @letters)
  end

  private

  def english_word?(user_input)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{user_input}").read
    output = JSON.parse(response)
    output["found"]
  end

  def included?(user_input, letters)
    user_input.chars.all? { |letter| user_input.count(letter) <= letters.count(letter) }
    # letters.includeall? user_input
    raise
  end
end
