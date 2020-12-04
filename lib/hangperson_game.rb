class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(letter)
    
    raise ArgumentError if letter.nil? || letter.empty?
    raise ArgumentError if letter =~ /[^a-zA-Z]/
    
    letter = letter.downcase
    
    if word.include?(letter) && !guesses.include?(letter)
      guesses << letter
      
    elsif !word.include?(letter) && !wrong_guesses.include?(letter)
      wrong_guesses << letter
      
    elsif guesses.include?(letter) || wrong_guesses.include?(letter)
      return false
      
    end
    
  end
  
  def word_with_guesses()
    check = @word.split('')
    result = ''
    
    for letter in check do
      
      if guesses.include?(letter)
        result.concat(letter)
        
      else
        result.concat('-')
        
      end
      
    end
    
    return result
    
  end
  
  def check_win_or_lose()
    if @word == word_with_guesses
      return :win
      
    elsif @wrong_guesses.length == 7
      return :lose
      
    else
      return :play
      
    end
  end

end
