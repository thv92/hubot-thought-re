# Hubot Thought Re
A hubot script that retreives random thoughts from subreddits. Based off of [original hubot thought script](https://github.com/github/hubot-scripts/blob/master/src/scripts/thought.coffee) and [original reddit-jokes script by tombell and ericjsilva](https://github.com/github/hubot-scripts/blob/master/src/scripts/reddit-jokes.coffee)


## Installation

In hubot project repo, run:

`npm install hubot-thought-re --save`


Then add **hubot-thought-re** to your `external-scripts.json`:

```json
[
  "hubot-thought-re"
]
```

## Commands

### thought

Retrieve a random thought from 'http://andymatthews.net/thought/'

### shower thought
Retrieve random shower thought

### deep thought
Retrieve random deep thought (VERY LONG)

### intrusive thought
Retrieve random intrusive thought

### random thought
Retrieve random thought


### Allowed Thought types and Corresponding subreddit
* shower - r/ShowerThoughts
* deep - r/DeepThoughts
* intrusive - r/IntrusiveThoughts
* random - r/RandomThoughts


## Sample Interaction

```
user: hubot thought
hubot: <random thought from 'http://andymatthews.net/thought/' >
```

```
user: hubot intrusive thought
hubot: <random thought from r/IntrusiveThoughts >
```

```
user: hubot shower thought
hubot: <random thought from r/ShowerThoughts >
```


