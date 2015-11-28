# This file contains all the necessary code for the program to interact
# With ThePirateBay.
# Written by @Netuoso

require_relative 'constants'

class ApiBase

  attr_reader :categories, :ordering

  def initialize
    @categories = Constants::CATEGORIES
    @ordering = Constants::ORDERING
  end

end