window.Joker.bootstrap = ->

  # Joker.debug = false

  # Joker.Alert.TYPE_ERROR   = "alert-error"
  # Joker.Alert.TYPE_INFO    = "alert-info"
  # Joker.Alert.TYPE_SUCCESS = "alert-success"
  # Joker.Alert.TYPE_WARNING = ""
  # Joker.Alert.alertContainer = undefined
  # Joker.Alert.target         = "body"

  # Joker.Animation.defaultData.enterEffect= Joker.Animation.FX_FADEIN
  # Joker.Animation.defaultData.autoLeave  = false
  # Joker.Animation.defaultData.delayTime  = 7000
  # Joker.Animation.defaultData.leaveEffect= Joker.Animation.FX_FADEOUT
  # Joker.Animation.defaultData.callbacks.finishEnter= (animation)->
  # Joker.Animation.defaultData.callbacks.finishLeave= (animation)->

  # Joker.Core.libSupport = window.jQuery

  # Joker.Debug.console: window.console

  # Joker.Modal.defaultSettings.autoShow = true
  # Joker.Modal.defaultSettings.effect   = Joker.Modal.FX_FALL
  # Joker.Modal.defaultSettings.callbacks.afterCreate   = (modal)->
  # Joker.Modal.defaultSettings.callbacks.afterDestroy  = (modal)->
  # Joker.Modal.defaultSettings.callbacks.beforeCreate  = (modal)-> true
  # Joker.Modal.defaultSettings.callbacks.beforeDestroy = (modal)-> true
  # Joker.Modal.patternModal = '' # see documentation

  # Joker.RestDelete.defaultSelector         = "[data-destroy]"
  # Joker.RestDelete.patternDestroyContainer = '' # see documentation
  # Joker.RestDelete.patternDestroyItens     = '' # see documentation

  # Joker.Window.defaultIndex  = 1009
  # Joker.Window.margin.top    = 0
  # Joker.Window.margin.right  = 0
  # Joker.Window.margin.left   = 0
  # Joker.Window.margin.bottom = 0

  Joker.Render.getInstance()
  Joker.Form.getInstance()
  #Joker.RestDelete.getInstance()
  #Joker.Typeahead.getInstance()
  #Joker.KeyboardShortcut.getInstance()
  #Joker.Filter.getInstance()
  Joker.Navigation.init()