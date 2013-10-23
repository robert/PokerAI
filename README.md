PokerAI
=======
Build a poker AI and play it off against your friends' in CRAZY HEADS UP MAYHEM.

To define your AI, define a class that inherits from `Poker::Player` and overrides the `decide` method. `decide` accepts an instance of a `HandState` that contains all the info your pokerbot will need to make a decision.

See `example.rb` for an example of running a match.

Coming maybe: full gem-ification, improvements to the AI definition API. Maybe even a DSL for simple/common operations.

Extracted from a super-ambitious weekend project to build a UI for pokerbot battling - https://github.com/pitchinvasion/poker
