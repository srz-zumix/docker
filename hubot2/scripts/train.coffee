# Description:
#   電車の運行情報
#
# Commands:
#   hubot 電車 - 電車の運行情報を教えてくれます

cron = require('cron').CronJob
cheerio = require 'cheerio-httpcli'
prev_delayed = false

rooms = process.env.HUBOT_IRC_ROOMS
if process.env.TRAIN_CRON_ROOMS
  rooms = process.env.TRAIN_CRON_ROOMS

# 平日17-22時に30分間隔でお知らせします
train_cron_schedule = '0 */30 17-22 * * 1-5'
if process.env.TRAIN_CRON_SCHEDULE
  train_cron_schedule = process.env.TRAIN_CRON_SCHEDULE

train_gc = 26
if process.env.TRAIN_AREA
  train_gc = process.env.TRAIN_AREA

train_check = (callback) ->
  # send HTTP request
  baseUrl = 'http://transit.loco.yahoo.co.jp/traininfo/gc/' + train_gc + '/'

  cheerio.fetch baseUrl, (err, $, res) ->
    send = false
    if $('.elmTblLstLine.trouble').find('a').length != 0
      $('.elmTblLstLine.trouble a').each ->
        url = $(this).attr('href')
        fetch_result = cheerio.fetchSync url
        check = (err, $, res) ->
          title = "◎ #{$('h1').text()} #{$('.subText').text()}"
          result = ""
          $('.trouble').each ->
            trouble = $(this).text().trim()
            result += "- " + trouble + "\r\n"
          if callback("#{title}\r\n#{result}", true)
            send = true
        check(fetch_result.error, fetch_result.$, fetch_result.response)
    if not send
      callback("事故や遅延情報はありません", false)

check_route = (comment) ->
  if /新幹線/.test(comment)
    return false
  return true

cron_task = (robot) ->
    train_check((comment, delayed) -> 
      if not check_route(comment)
        return false
      for name in rooms.split(",")
        if delayed
          robot.send {room: name}, comment
        else if prev_delayed
          robot.send {room: name}, comment
        prev_delayed = delayed
      return true
    )
    
respond_task = (msg) ->
  train_check((comment, delayed) ->
    if not check_route(comment)
      return false
    msg.send comment
    return true
  )

module.exports = (robot) ->

  robot.respond /電車/i, (msg) ->
    respond_task(msg)

  robot.respond /train/i, (msg) ->
    respond_task(msg)

  new cron train_cron_schedule, () ->
    cron_task(robot)
  , null, true, "Asia/Tokyo"

  new cron "0 0 0 * * 1-5", () ->
    prev_delayed = false
  , null, true, "Asia/Tokyo"

