# solo-jeopardy


enter `bundle install` before your first game to install the necessary ruby gems.

once the gems are installed and you're ready to play. enter `###` to start a new game of solo jeopardy

mvp:






stretch goals:


    do not ask questions that reference music, pictures, or videos


    define method to validate that a category is populated with questions that have point values and that have answers
    (if invalid, could make a method based on Fetcher.fetch_six_categories that only gets one new category)


    validate user answers to (closely) match actual answers


    allow user to decline set of categories based on year given
    OR
    allow user to select a year to play from


    get six random categories by setting 18400 to rand number between 0 and 18400
    http://jservice.io/api/categories?offset=18400&count=6

 
    make a board to populate with the six categories


    keep track of score throughout game


    include daily double questions


    have game run for two rounds, doubling point values for second round


    allow user to choose number of categories per round


    allow user to choose number of questions per category


    allow user to choose which year the questions come from


    add a timer to questions that counts down, waiting for an entry of any character to "buzz in" before timer expires. if timer expires, the question is lost and play continues


    add a game timer that will end play on expiration and go to commercial break