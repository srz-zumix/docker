# Description:
#   天気
#
# Commands:
#   hubot [今日の|明日の|明後日の]天気 - 天気を教えてくれます
#   hubot tenki 今日の天気を教えてくれます

weather = (msg) ->
    day = 0
    switch msg.match[1]
      when ''
        day = 0
      when '今日の'
        day = 0
      when '明日の'
        day = 1
      when '明後日の'
        day = 2
      else
        day = 3
        break
    r = msg.http('http://weather.livedoor.com/forecast/webservice/json/v1?city=270000').get()
    if day >= 3
      msg.reply "んん？"
    else
      r (err, res, body) ->
        json = JSON.parse body
        forecast = json['forecasts'][day]['telop']
        msg.send forecast

module.exports = (robot) ->

  robot.respond /(.*)天気/i, (msg) ->
    weather(msg)

  robot.respond /(.*)tenki/i, (msg) ->
    weather(msg)
