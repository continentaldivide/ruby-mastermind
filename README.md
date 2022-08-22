# ruby-mastermind

This project is a terminal-based version of the classic board game Mastermind. I created this to complete [this assignment](https://www.theodinproject.com/lessons/ruby-mastermind) from The Odin Project. This is my second project in Ruby (following [this one](https://github.com/continentaldivide/ruby-tic-tac-toe)).

## Successes

Having completed this project, I am finally feeling quite comfortable programming in Ruby. There are still a few pieces of syntax that trip me up, but by and large I can express my ideas without having to visit google every few minutes.

I had an idea early on that, since color is a central element of this game, I'd like to learn to adjust the color of my program's text. I didn't take this to the fullest extent I first imagined, but I'm glad that the research I did equipped me to use colored output for the guess feedback.

While my code still leaves a lot to be desired, I'm very pleased with the improvements I'm noticing in my own practice -- while writing this, I solved some trickier bugs than I'd faced before, came up with novel solutions to fresh problems, and frequently changed the code I'd already written to keep it maintainable as the program grew in size and complexity.

## Challenges

This is the first project I've done while studying programming that became truly tedious. There are some features listed in the assignment that I left out because I recognized that I needed to move on in the curriculum in the interest of maintaining my motivation. This was a great opportunity to develop some strategies for continuing to make myself put in the work even when I wasn't particularly enthusiastic about it.

Modest as it is, this may be the most complicated project I've done yet, so it was not easy to keep my code organized and legible as I added more and more pieces to it. Regular refactors were a big help here, as was staying intentional about going back over my code to look for methods that had side effects or that did a poor job describing their purposes.

This project included my first time getting frustrated that a new language doesn't have 'the thing I need' from a language I'm more familiar with. I've written some JS previously where I've sliced elements out of an array while iterating over it in a for loop -- in that case, I decremented my index variable to ensure I evaluated the data that 'fell' into that index location in the array. I expected to be able to use this strategy in my count_black_pegs method when using array.each_with_index. Frustratingly, this didn't work and I had to fall back to a while loop instead. But it was a great opportunity to get really noodly about exactly what does and doesn't work in different kinds of Ruby loops!

## Things I chewed on while working on this project:

- how small should a method be? is a one-line method worth including if it makes my code more semantic?
- what's the best UX for a text-oriented CLI application that solicits user input? Should I validate input, and if so, how?
