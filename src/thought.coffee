# Description
#   A hubot script that retreives random thoughts from multiple subreddits
#
# Configuration:
#   None
#
# Commands:
#   hubot thought - Replies with random thought from original thought script api
#   hubot shower thought - random thought from /r/ShowerThoughts
#   hubot deep thought - random thought from /r/DeepThoughts
#   hubot intrusive thought - random thought from /r/IntrusiveThoughts
#   hubot random thought - random thought from /r/RandomThoughts
#
# Notes:
#   Allowed types:
#     thought - original api
#     shower - r/ShowerThoughts
#     deep - r/DeepThoughts
#     intrusive - r/IntrusiveThoughts
#     random - r/RandomThoughts
#
# Author:
#   thv92

module.exports = (robot) ->

  decode = (text) -> 
    text.replace(/&amp;/g, "&").replace(/&lt;/g, "<").
    replace(/&quot;/g, "\"").replace(/&#039;/g, "\'").replace(/&nbsp;/g, " ")

  sendThoughtFrom = (msg, url) ->
    msg.http(url).get() (err, res, body) ->
      try
        parsedBody = JSON.parse body
        if('data' of parsedBody)
          children = parsedBody.data.children
          randomThought = msg.random(children).data
          thought = randomThought.title.replace(/\*\.\.\.$/,'') +
          ' ' + randomThought.selftext.replace(/^\.\.\.\s*/, '')
        else
          thought = parsedBody.thought

        msg.send decode(thought.trim())

      catch ex
        msg.send "I can't tell you a thought :'( - #{ex}"

  robot.respond /(.*)thought$/i, (msg) ->
    type = msg.match[1].trim()

    type_to_link = {
      'shower': 'ShowerThoughts',
      'deep': 'DeepThoughts',
      'intrusive': 'IntrusiveThoughts',
      'random': 'RandomThoughts'
    }

    if(type of type_to_link)
      if(type == 'random')
        typeOfPosts = ['hot', 'new']
      else
        typeOfPosts = ['hot', 'new', 'rising']

      url = "https://www.reddit.com/r/#{type_to_link[type]}/#{msg.random(typeOfPosts)}.json"
    else
      url = 'http://andymatthews.net/thought/'
    sendThoughtFrom(msg, url)
