# Description:
#   天気
#
# Environments:
#   WEATHER_CITY          都市を指定
#   WEATHER_CRON_ROOMS    定期通知先 room を指定
#   WEATHER_CRON_SCHEDULE 定期通知時間を指定
#
# Commands:
#   hubot [今日の|明日の|明後日の]天気 - 天気を教えてくれます
#   hubot tenki [0|1|2] 今日の天気を教えてくれます

cron = require('cron').CronJob

rooms = process.env.HUBOT_IRC_ROOMS
if process.env.WEATHER_CRON_ROOMS
  rooms = process.env.WEATHER_CRON_ROOMS

# 平日18時にお知らせします
tenki_cron_schedule = '0 0 18 * * 1-5'
if process.env.WEATHER_CRON_SCHEDULE
  tenki_cron_schedule = process.env.WEATHER_CRON_SCHEDULE

city = 270000
if process.env.WEATHER_CITY
  city = process.env.WEATHER_CITY

get_weather = (robot, day, callback) ->
  r = robot.http('http://weather.livedoor.com/forecast/webservice/json/v1?city='+city).get()
  forecast = null
  r (err, res, body) ->
    json = JSON.parse body
    forecast = json['forecasts'][day]['telop']
    callback(forecast)

weather = (msg) ->
    day = 0
    if msg.match[1].length != 0
      switch msg.match[1]
        when '今日の'
          day = 0
        when '明日の'
          day = 1
        when '明後日の'
          day = 2
        else
          day = 3
          break
    if msg.match[2] && msg.match[2].length != 0
      day = parseInt(msg.match[2])
    if day >= 3
      msg.send "んーわかんない"
    else if day < 0 || isNaN(day)
      msg.reply "んん？"
    else
      forecast = get_weather(msg, day, (forecast) ->
        msg.send forecast
      )

cron_task = (robot) ->
    get_weather(robot, 1, (forecast) ->
      for name in rooms.split(",")
        robot.send {room: name}, "明日の天気は" + forecast + "です。"
    )

module.exports = (robot) ->

  robot.respond /(.*)天気/i, (msg) ->
    weather(msg)

  robot.respond /(.*)\s*tenki\s*([0-9]*)/i, (msg) ->
    weather(msg)

  new cron tenki_cron_schedule, () ->
    cron_task(robot)
  , null, true, "Asia/Tokyo"

