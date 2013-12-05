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
class Joker.I18n

  ###
  Guarda todas as variaveis e objetos de
  traducao, vindos do rails
  @type Object
  ###
  @translations: new Object

  ###
  Configura o objeto
  ###
  @getInstance: ->
    Joker.I18n.t = Joker.I18n.translate
    Joker.t      = Joker.I18n.translate

  ###
  Metodo que dispara as traducoes e
  preenche as variaveis.
  @example
    # objeto de traducao
    {
      controller: { name: "I'm {variable}" }
    }

    Joker.I18n.translate('controller.name', { variable: "Joker" }) # I'm Joker

  @throws Caso nao exista a chave de traducao solicitada

  @param key String
    chave a ser traduzida, encadear chaves com ponto '.'

  @param assigns Object
    objetos a serem assinados na string de traducao

  @return String
  ###
  @translate: (key, assigns={})->
    _t9n = Joker.I18n.translations
    key.split('.').each (value)->
      _t9n = _t9n[value] if Object.has(_t9n, value)
    throw "Key not found in translations: #{key}" unless Object.isString(_t9n)
    _t9n.assign assigns
