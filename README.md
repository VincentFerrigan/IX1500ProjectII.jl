# Project II
This project is based on an assignment for a course in 'Discrete Mathematics' 
given at KTH Royal Institute of Technology in Stockholm.

Instead of Mathematica, the Pluto Notebook was used to create 
an interactive notebook.
All code is written in Julia, however, som interacting parts had 
some JavaScrips and CSS in them.

## Task A
### Summary
#### Task
In the Texas hold 'em poker game every player gets just two cards (hole cards),
while the best hand is determined by the combination of any five cards chosen
from your two face down \"hole\" cards and the five face up \"community\" cards
(shared by all players). 

The problem consists of determining the exact probability of the hands below
(best hand possible), using the census method (2.4 above), when a player has two
specific \"hole\" cards and the community cards are unknown. This is the situation
in the first pre-flop (before dealing the community cards) betting round in
Texas hold 'em. Choose the specific \"hole\" cards at random. 

After this choose three of the five \"community cards\" at random and redo the
calculation of the probabilities. Keep the specific \"hole cards\" you had.
This is the situation of the second betting round. Compare the pre-flop
possibilities with the situation where three of the \"community cards\" are
known and discuss the results.

The deck is a normal 52-card deck without any jokers.

* one pair
* two pairs
* three of a kind
* straight
* flush
* full house
* four of a kind
* straight flush
* royal straight flush
 
## Task B
### Summary
#### Task
The birthday paradox is that the probability of two persons sharing the same
birthday in a
group, exceeds 50%, when the group consists of only 23 people.

* If there are $N$ people in the room, what is the probability that at least
  two of them have the same birthday?
* What is the probability for $N = 40$?

* Suppose you are in the room, then what is the probability that one of them
  has the same birthday as yours? Is this the same probability as above?
* Draw graphs of the probabilities as a function of $N$ .
* Simulate the birthday paradox repeatedly and calculate the average
  probability for different values of $N$ . Draw graphs and compare to the
  calculated versions above. Conclusions?
