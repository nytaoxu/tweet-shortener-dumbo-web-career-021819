# Write your code here.

def dictionary
  {
    "hello" => "hi",
    "to" => "2",
    "two" => "2",
    "too" => "2",
    "for" => "4",
    "four" => "4",
    "be" => "b",
    "you" => "u",
    "at" => "@",
    "and" => "&"
  }
end

def isLetter(character)
  if ('a'..'z').to_a.include?(character.downcase)
    return true
  else
    return false
  end
end

def word_processing(word)
  word_array = word.split("")
  index = word_array.length - 1
  current_status = :suffix # :suffix, :letter, :prefix
  hash = {
    :prefix => "",
    :letter => "",
    :suffix => ""
  }
  while index >= 0
    if current_status == :suffix
      if isLetter(word_array[index])
        current_status = :letter
      end
      
    elsif current_status == :letter
      if !isLetter(word_array[index])
        current_status = :prefix
      end
    
    else # current_status == :prefix
      
    end
    hash[current_status] = word_array[index] + hash[current_status]
    index -= 1
  end
  hash
end

def word_substituter(twitter)
  dictionary.each do |key, value|
    # twitter.gsub!(key, value)
    result = []
    twitter.split(" ").each do |word|
      word_hash = word_processing(word) # we got prefix, letters, and suffix here through a hash
      if word_hash[:letter].downcase == key
        word_hash[:letter] = value
      end
      result.push(word_hash[:prefix] + word_hash[:letter] + word_hash[:suffix])
    end
    twitter = result.join(" ")
  end
  twitter
end

def bulk_tweet_shortener(tweets)
  tweets.each do |tweet|
    puts word_substituter(tweet)
  end
end

def selective_tweet_shortener(tweet)
  if tweet.length <= 140
    return tweet
  end
  word_substituter(tweet)
end

def shortened_tweet_truncator(tweet)
  shortened_string = selective_tweet_shortener(tweet)
  if shortened_string.length > 140
    return shortened_string[0..136] + "..."
  else
    return shortened_string
  end
end
