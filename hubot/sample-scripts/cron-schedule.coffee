# Description:
#   定期連絡予約
#
# Commands:

cron = require('cron').CronJob
random = require('hubot').Response::random

module.exports = (robot) ->
  new cron '0 * 10 * * 1-5', () =>
    robot.send {room: "#IS@2011"}, random ["あ～", "う～", "お～" ]
  , null, true, "Asia/Tokyo"
