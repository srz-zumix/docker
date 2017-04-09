# Description:
#   電車の運行情報
#
# Commands:
#   hubot 電車 - 電車の運行情報(京都)を教えてくれます

cheerio = require 'cheerio-httpcli'

module.exports = (robot) ->

  robot.respond /電車/i, (msg) ->
    # send HTTP request
    baseUrl = 'http://transit.loco.yahoo.co.jp/traininfo/gc/26/'

    cheerio.fetch baseUrl, (err, $, res) ->
      if $('.elmTblLstLine.trouble').find('a').length == 0
        msg.send "事故や遅延情報はありません"
        return
      $('.elmTblLstLine.trouble a').each ->
        url = $(this).attr('href')
        cheerio.fetch url, (err, $, res) ->
          title = "◎ #{$('h1').text()} #{$('.subText').text()}"
          result = ""
          $('.trouble').each ->
            trouble = $(this).text().trim()
            result += "- " + trouble + "\r\n"
          msg.send "#{title}\r\n#{result}"
