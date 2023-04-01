# CLI Jeopardy!

## Setup and startup

Enter `bundle install` before your first game to install the necessary ruby gems.

Once the gems are installed and you're ready to play. Enter `ruby bin/run` to start a new game of Solo Jeopardy.


## Flatiron Assessment blog and video

[Video demonstration](https://vimeo.com/472039062)

[dev.to Blog](https://dev.to/spenser6131/adding-flavor-to-a-ruby-cli-application-4jae)




## Stretch goals:
    
    
  Expand on instructions and short-comings in the game's startup


  Do not ask questions that reference music, pictures, or videos (this has been implemented to the best of my ability. The API data
  has a value to check if clues depend on extra media, but not all clues have this value defined properly.)


  Validate user's answers to (closely) match actual answers


  Have game run for two rounds, doubling point values for second round


  Implement a timer to questions that counts down, waiting for an entry of any character to "buzz in" before timer expires. if timer expires, the question is lost and play continues


  Implement a game timer that will end play on expiration and go to commercial break


  Add sound/music (Jeopardy Think Music.mp3 available in asset file)
