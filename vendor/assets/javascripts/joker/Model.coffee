###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Model.js
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
class Joker.Model extends Joker.Core

  @HAS_MANY               : 'has_many'
  @HAS_ONE                : 'has_one'
  @HAS_AND_BELONGS_TO_MANY: 'has_and_belongs_to_many'

  @primaryKey   : "id"
  @resourceName : undefined
  @fields       : []
  @associations : []

  @encode: (names...)->
    @fields.push {name: name} for name in names


  @association: (model, type)->
    @associations.push
      model: model
      type : type

  @timestamp: ->
    @encode "created_at", "updated_at"



  debugPrefix : "Joker_Model"
  name        : "Model"


  constructor: (settings)->
    super
    @settings = $.extend true, {}, @settings, settings
    @debug "Construindo o modelo com as configuracoes: ", @settings


  destroy: ->

  is_new: ->

  save: ->

  serializer: ->

  # Callbacks

  ###
  Metodo executado antes de disparar o destroy
  @return {Boolean}
  ###
  before_destroy: ->
    true
  ###
  Metodo executado apos o destroy do elemento
  ###
  after_destroy : ->
  ###
  Metodo executado antes de disparar o save
  @return {Boolean}
  ###
  before_save: ->
    true
  ###
  Metodo executado apos disparado o save do elemento
  ###
  after_save: ->
