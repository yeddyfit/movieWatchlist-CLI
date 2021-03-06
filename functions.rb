require_relative './classes.rb'

### Object marshaling for saving across terminal sessions
def loadFile()
    if File.file?('movies.dump')
        ### loads movies array if it exists
        $moviesWatchlist = Marshal.load(File.read('movies.dump'))
    else 
        ### else creates a new array
        $moviesWatchlist = [
            Movie.new("The Shawshank Redemption", "Drama"), Movie.new("The Godfather", "Drama"), 
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
    puts "The movie you should watch is: #{$moviesWatchlist[rand(0..$moviesWatchlist.length)].title}"
end

def genreList()
    prompt = TTY::Prompt.new
    genreArray = []
    $moviesWatchlist.each do |movie|
        if !genreArray.include?(movie.genre)
            genreArray.push(movie.genre)
        end
    end
    
    genreChoice = prompt.select("Choose a genre", genreArray)
    tempList = []
    $moviesWatchlist.each do |movie|
        if movie.genre == genreChoice
            tempList.push(movie.title)
        end
    end

    puts `clear`
    puts "Here's ya list mate: \n "
    puts tempList
end