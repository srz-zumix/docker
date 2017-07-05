# Description:
#   exit
#
# Commands:
#   hubot exit - process exit

module.exports = (robot) ->
  robot.respond /exit/i, (msg) ->
    process.exit()
