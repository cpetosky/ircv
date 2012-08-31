exports = window

class EventEmitter
  constructor: ->
    @_listeners = {}

  on: (ev, cb) ->
    (@_listeners[ev] ?= []).push cb

  emit: (ev, args...) ->
    l(args...) for l in (@_listeners[ev] ? [])

  once: (ev, cb) ->
    @on ev, f = (args...) =>
      @removeListener ev, f
      cb(args...)
    f.listener = cb

  removeListener: (ev, cb) ->
    return unless @_listeners and @_listeners[ev] and cb?
    @_listeners[ev] = (c for c in @_listeners[ev] when c != cb and c.listener != cb)

exports.EventEmitter = EventEmitter