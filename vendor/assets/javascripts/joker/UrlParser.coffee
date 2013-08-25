###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        UrlParser.js
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
class Joker.UrlParser extends Joker.Core
  debugPrefix: "Joker_UrlParser"
  ###
  @type [Joker.UrlParser]
  ###
  @instance  : undefined

  regex: /\/?([\w]*)/g


  get_url: ->


  parser: (url)->

    {
      controller: "controller"
      id: 123456
      children :
        controller: "c"
        id: 21315
        action: "asd"

    }

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.UrlParser]
  ###
  @get_instance: ->
    Joker.UrlParser.instance = Joker.UrlParser.instance || new Joker.UrlParser
    Joker.UrlParser.instance