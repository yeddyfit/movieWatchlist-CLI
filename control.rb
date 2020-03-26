require 'tty-prompt'
require_relative './classes.rb'


### Object marshaling for saving across terminal sessions
if File.file?('movies.dump')
    ### loads movies array if it exists
    $moviesWatchlist = Marshal.load(File.read('movies.dump'))
    puts `clear`
else 
    ### else creates a new array
    $moviesWatchlist = [Movie.new("The Shawshank Redemption", "Drama"), Movie.new("The Godfather", "Drama"), 
                        Movie.new("The Dark Knight", "Action"), Movie.new("The Godfather: Part II", "Drama"),
                        Movie.new("The Lord of the Rings: The Return of the King", "Adventure"),
                        Movie.new("Pulp Fiction", "Crime"), Movie.new("Schindler's List", "Biography"),
                        Movie.new("12 Angry Men", "Drama"), Movie.new("Inception", "Action"),
                        Movie.new("Fight Club", "Drama"), Movie.new("The Lord of the Rings: The Fellowship of the Ring", "Adventure"),
                        Movie.new("Forrest Gump", "Drama"),  Movie.new("The Good, the Bad and the Ugly", "Western"),
                        Movie.new("The Lord of the Rings: The Two Towers", "Adventure"), Movie.new("The Matrix", "Action"),
                        Movie.new("Goodfellas", "Biography"), Movie.new("Star Wars: Episode V - The Empire Strikes Back", "Adventure"),
                        Movie.new("One Flew Over the Cuckoo's Nest", "Drama"), Movie.new("Harakiri", "Action"),
                        Movie.new("Parasite", "Comedy"), Movie.new("Interstellar", "Sci-Fi"), Movie.new("City of God", "Crime"),
                        Movie.new("Spirited Away", "Animation"), Movie.new("Saving Private Ryan", "Drama"), Movie.new("The Green Mile", "Crime"),
                        Movie.new("Life Is Beautiful", "Drama"), Movie.new("Se7en", "Crime"), Movie.new("The Silence of the Lambs", "Crime"),
                        Movie.new("Star Wars", "Adventure"), Movie.new("Seven Samurai", "Adventure"), Movie.new("Its a Wonderful Life", "Drama"),
                        Movie.new("Joker", "Drama"), Movie.new("Avengers: Infinity War", "Adventure"), Movie.new("Whiplash", "Drama"),
                        Movie.new("The Intouchables", "Biography"), Movie.new("The Prestige", "Drama"), Movie.new("The Departed", "Drama"),
                        Movie.new("The Pianist", "Biography"), Movie.new("Gladiator", "Action"), Movie.new("American History X", "Drama"),
                        Movie.new("The Usual Suspects", "Crime")
                    ]
    puts `clear`
end



def newMovie(title, genre)
    $moviesWatchlist.push(Movie.new(title, genre))
end

def showMovies()
    $moviesWatchlist.each do |movie|
        puts movie.title
    end
end

def showRandomMovie()
    puts $moviesWatchlist[rand(0..$moviesWatchlist.length)].title
end

# Initialise 'TTY-Prompt'
prompt = TTY::Prompt.new
keep_program_running = true
user_options = ["Show all movies", "Add movie to list", "Choose random movie", "Show movies of genre type",
                "Show movies of rating equal or greater than your rating choice"]




# Control loop - program keeps asking us what function we'd like to use until we decide to exit
while keep_program_running == true
    user_choice = prompt.select("Please choose which function you'd like to use:", user_options)
    # Show all movies in the list
    if user_choice == "Show all movies"
        showMovies()
    # The user can add a new movie that isn't already on the movie list
    elsif user_choice == "Add movie to list"
        title = prompt.ask("What movie do you want to add? ")
        genre = prompt.ask("What genre is it? ")
        newMovie(title, genre)
    # The user is given a random movie from the list of movies
    elsif user_choice == "Choose random movie"
        puts "The movie you should watch is:"
        showRandomMovie()
    elsif user_choice == "Show movies of genre type"
        puts "Please enter which genre of movies you'd like to choose from:"
        # show movies of genre code
    elsif user_choice == "Show movies of rating equal or greater than your rating choice"
        puts "Please enter the rating to search from (0-10):"
        # show movies categorised by rating code
    end

    # prompts user, if response is not yes, set keep_program_running boolean to false so while loop exits
    if prompt.yes?('Keep using movie helper?') == false
        ### saves the array of movies to "movies.dump"
        File.open('movies.dump', 'w') { |f| f.write(Marshal.dump($moviesWatchlist)) }
        keep_program_running = false
    end

end


