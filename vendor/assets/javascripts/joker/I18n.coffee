###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        I18n.js
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
class Joker.I18n extends Joker.Core

  @debugPrefix: "Joker_I18n"
  @className  : "Joker_I18n"

  @translations: new Object

  ###
  Configura o objeto
  ###
  @getInstance: ->
    Joker.I18n.t = Joker.I18n.translate
    Joker.t      = Joker.I18n.translate


  @translate: (key, assigns={})->
