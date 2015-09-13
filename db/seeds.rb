board_games = [
  { title: 'Rococo', creator: 'Michael Menzel',
    description:'Rokoko is a Eurostyle board game with an interesting take on deck-building. Each turn you play one of your employee cards and let that employee perform a task: hire a new employee, buy resources, manufacture a coat or dress, or invest in the ball\'s decorations.',
    min_players: 2, max_players: 5, min_time: 60, max_time: 120, my_score: 8.75, bgg_score: 7.143, expansion: false },
  { title: 'Marrying Mr. Darcy', creator: 'Erika Svanoe',
    description:'Marrying Mr. Darcy is a role-playing game where players are one of the female characters from Jane Austen’s novel Pride and Prejudice. Players work to improve themselves and become more desirable as potential wives for the available Suitors. The ladies do this by attending Events and improving their Characters, but advantage can be gained by the use of Cunning. All of their efforts are in hopes of securing the husband that will make them the most satisfied character at the end of the game',
    min_players: 2, max_players: 6, min_time: 60, max_time: 60, my_score: 9, bgg_score: 5.762, expansion: false },
  { title: 'Dominion', creator: 'Donald X. Vaccarino',
    description: 'You are a monarch, like your parents before you, a ruler of a small pleasant kingdom of rivers and evergreens. Unlike your parents, however, you have hopes and dreams! You want a bigger and more pleasant kingdom, with more rivers and a wider variety of trees. You want a Dominion! In all directions lie fiefs, freeholds, and feodums. All are small bits of land, controlled by petty lords and verging on anarchy. You will bring civilization to these people, uniting them under your banner.',
    min_players: 2, max_players: 4, min_time: 30, max_time: 45,
    bgg_score: 7.69, my_score: 9, expansion: false },
    { title: 'Alchemy', creator: 'Donald X. Vaccarino',
    description:'There are strange things going on in your basement laboratories. They keep calling up for more barrels of quicksilver, or bits of your hair. Well it\'s all in the name of progress. They\'re looking for a way to turn lead into gold, or at least into something better than lead. That lead had just been too good of a bargain to pass up; you didn\'t think, where will I put all this lead, what am I going to do with this lead anyway. Well that will all be sorted out. They\'re also looking for a universal solvent. If they manage that one, you will take whatever they use to hold it in and build a castle out of it. A castle that can\'t be dissolved! Now that\'s progress.',
    min_players: 2, max_players: 4, min_time: 20, max_time: 45, my_score: 8.5, bgg_score: 7.04, expansion: true, expansion_to: "Dominion" },
  { title: 'Star Realms', creator: 'Robert Dougherty and Darwin
    Kastle',
    description:'Star Realms is a fast paced deck-building card game of outer space combat. It combines the fun of a deck-building game with the interactivity of Trading Card Game style combat. As you play, you make use of Trade to acquire new Ships and Bases from the cards being turned face up in the Trade Row from the Trade Deck. You use the Ships and Bases you acquire to either generate more Trade or to generate Combat to attack your opponent and their bases. When you reduce your opponent’s score (called Authority) to zero, you win!',
    min_players: 2, max_players: 2, min_time: 20, max_time: 20,
    bgg_score: 7.541, my_score: 9.5, expansion: false },
  { title: 'Poo', creator: 'Matthew Grau',
    description:'It’s been a tough day in the monkey cage and something in the food tonight wasn’t quite right. In monkey world, there’s only one thing that can be done about it - fling poo! Poo is a fast-paced card game for two to eight players, requiring anywhere from five to fifteen minutes to play. It’s fast and furious - something you can play while waiting in line or on lunch break.',
    min_players: 2, max_players: 8, min_time: 10, max_time: 20, my_score: 8, bgg_score: 5.621, expansion: false }
]

board_games.each do |game|
  BoardGame.create(game)
end
