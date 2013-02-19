Wire          = require '../../main'

# BlinkM http://thingm.com/products/blinkm
# firmware http://code.google.com/p/codalyze/wiki/CyzRgb

TO_RGB        = 0x6e
GET_RGB       = 0x67
FADE_TO_RGB   = 0x63
FADE_TO_HSB   = 0x68
GET_ADDRESS   = 0x61
SET_ADDRESS   = 0x41
SET_FADE      = 0x66
GET_VERSION   = 0x5a
WRITE_SCRIPT  = 0x57
READ_SCRIPT   = 0x52
PLAY_SCRIPT   = 0x70
STOP_SCRIPT   = 0x0f

class Pixel

  address: 0x01

  constructor: (@address) ->
    @wire = new Wire('/dev/i2c-0');

  off: ->
    @setRGB(0, 0, 0)

  getAddress: (callback) ->
    @_send [GET_ADDRESS]
    @_read 1, callback

  setFadeSpeed: (speed) ->
    @_send [SET_FADE, speed]

  setRGB: (r, g, b) ->
    @_send [TO_RGB, r, g, b]

  getRGB: (callback) ->
    @_send [GET_RGB]
    @_read 3, callback

  fadeToRGB: (r, g, b) ->
    @_send [FADE_TO_RGB, r, g, b]

  fadeToHSB: (h, s, b) ->
    @_send [FADE_TO_HSB, h, s, b]

  _send: (cmds) ->
    @wire.write @address, cmds

  _read: (length, callback) ->
    @wire.read @address, length, callback

module.exports = Pixel