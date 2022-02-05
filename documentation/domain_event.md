# Domain Events
Domain Events are things that happened in the domain. 
They should be named in past tense
Because they are the persisted state of our application they must be serializable / deserializable.
I recommend using the json_serializable package