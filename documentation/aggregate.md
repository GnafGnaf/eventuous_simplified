#Aggregate
## What is an Aggregate

## The Aggregate Base Class
## The Aggregate With State Base Class
### How to Build Aggregate State
Since Aggregate State is immutable I recommend using freezed for State classes
### How to work with the Event Handler Registry
I usually put the state transitions into the state file itself. So the state reacts to
the event and returns an updated state. For that the class needs a private constructor.
## The Aggregate With State and ID Base Class
### How can I build a State with ID with Freezed?
Add the interface as a mixin