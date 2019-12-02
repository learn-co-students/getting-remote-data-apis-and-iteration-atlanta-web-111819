require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  character_data = nil
  response_hash["results"].each do |character|
    if character["name"].downcase == character_name
      character_data = character
      break
    end
  end

  # binding.pry
  character_data["films"].map do |link|
    film_json = RestClient.get(link)
    film_data = JSON.parse(film_json)

    film_data
  end
end

def print_movies(films)
  # binding.pry
  films.each do |film|
    puts "TITLE: #{film['title']}"
    puts "EPISODE: #{film['episode_id']}"
    puts "DIRECTOR: #{film['director']}"
    puts "PRODUCER: #{film['producer']}"
    puts "RELEASE DATE: #{film['release_date']}"
    puts "OPENING CRAWL: #{film['opening_crawl']}"
    puts "==============="
  end
end

def show_character_movies(character)
  # binding.pry
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
