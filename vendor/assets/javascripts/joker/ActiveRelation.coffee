###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        ActiveRelation.js
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

###

###
class Joker.ActiveRelation extends Joker.Core

  debugPrefix : "Joker_ActiveRelation"
  name        : "ActiveRelation"


  constructor: (@model, @uri, settings={})->
    super
    @settings = $.extend true, {}, @settings, settings
    @debug "Construindo o modelo com as configuracoes: ", @settings

  get: ->


  toString: ->

