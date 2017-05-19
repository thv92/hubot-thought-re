require('es6-promise').polyfill()
Helper = require('hubot-test-helper')
chai = require('chai')
nock = require('nock')

expect = chai.expect

helper = new Helper('../src/thought.coffee')

tests = [
  ['shower', 'r/ShowerThoughts'],
  ['deep', 'r/DeepThoughts'],
  ['intrusive', 'r/IntrusiveThoughts'],
  ['random', 'r/RandomThoughts']
]

describe 'thought', ->
  beforeEach ->
    @room = helper.createRoom()
    do nock.disableNetConnect
    
    nock('https://www.reddit.com')
      .get('/'+test[1]+'.json')
      .reply( 200, {data:{children: [{
        data:{
          title: 'This is not a thought',
          selftext: 'its a test for '+test[1]+'!'
        }
      }]}}) for test in tests

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  context 'user asks \"hubot thought\"', ->
    beforeEach (done) ->
      @room.user.say('alice', '@hubot thought')
      setTimeout done, 100

    it( 'responds with a thought from http://andymatthews.net/thought/', ->
      expect(@room.messages).to.eql [
        ['alice', '@hubot thought']
        ['hubot', 'This is not a thought its a test for http://andymatthews.net/thought/']
      ])

  for test in tests
    do (test) ->
      context 'user asks \"' + test[0]+ ' thought\"', ->
        beforeEach (done) ->
          @room.user.say('alice', '@hubot '+test[0]+' thought')
          setTimeout done, 100

        it( 'responds with a thought from '+test[1], ->
          expect(@room.messages).to.eql [
            ['alice', '@hubot '+test[0]+' thought']
            ['hubot', 'This is not a thought its a test for '+test[1]+'!']
          ])
