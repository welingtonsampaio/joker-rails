###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Joker.js
@author      Welington Sampaio (http://welington.zaez.net/)
@contact     http://jokerjs.zaez.net/contato

@copyright Copyright 2013 Zaez Solucoes em Tecnologia, all rights reserved.

This source file is free software, under the license MIT, available at:
http://jokerjs.zaez.net/license

This source file is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.

For details please refer to: http://jokerjs.zaez.net
###

(global ? window).Joker = (global ? window).Joker || {}

###
Create a new instance of Core.

@classDescription This class creates a new Core.
@return {Core}    Returns a new Core.
@type   {Object}
###
Joker.Core = Class ->

  ###
  Atual Index of prints Debuging
  @type {Integer}
  ###
  debugIndex  = 1
  ###
  Prefix debug message
  @type {String}
  ###
  debugPrefix = "Joker_Core"
  ###
  All settings
  @type {Object}
  ###
  settings =
    debug: false

  {
    $statics:
      ###
      The reference pattern help, default: jQuery
      @static
      @type {Object)
      ###
      libSupport: window.jQuery
      ###
      Sets the class name
      @type {String}
      ###
      className: "Joker_Core"


    ###
    ID of identification of object
    @see JokerUtils.uniqid
    @type {String}
    ###
    objectId: null

    ###
    Dados de configurancao do objeto
    @type Object
    ###
    data: new Object

    constructor: ->
      @verifyLibSupport()
      @generateId()

    ###
    Checks if there is library of support,
    returns false if there
    @exception If there LibSupport
    @return {Boolean}
    ###
    verifyLibSupport: ->
      throw 'Required support library (jQuery or Zepto)' unless @libSupport?
      true
    ###
    Responsible for generating a unique
    id for the object in question
    @return {String} Id generated
    ###
    generateId: ->
      @objectId = JokerUtils.uniqid()
      JokerUtils.addObject @
      @objectId
    ###
    Destroy the object and cleaning of Utils
    @see JokerUtils.remove_object()
    @return {Boolean}
    ###
    destroy: ->
      JokerUtils.removeObject @objectId
      delete @
    ###
    Updatings and return atual settings
    @param Object to merge with settings
    @return Object atual settings
    ###
    settings: (params={}, atualSettings = settings)->
      @data = @libSupport.extend true, {}, atualSettings, @data, params
      @data
    ###
    Print messages of debug
    @param {Mixin} ... All params are printed
    @return {Integer} Next index of message
    ###
    debug: ->
      Joker.Debug.print
        debug    : @data.debug
        prefix   : debugPrefix
        objectId : @objectId
        index    : debugIndex
        messages : arguments
      debugIndex += 1
  }
