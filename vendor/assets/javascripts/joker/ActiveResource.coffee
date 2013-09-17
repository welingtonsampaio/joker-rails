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
class Joker.ActiveResource extends Joker.Core

  @debugPrefix : "Joker_ActiveResource"
  @className   : "Joker_ActiveResource"
  @defaultConditions:
    group  : new Array()
    limit  : ""
    orderBy: new Array()
    page   : ""
    where  : new Array()

  ###
  ###
  conditions: undefined

  constructor: (@model, @uri, conditions={})->
    super
    @conditions = @libSupport.extend true, {}, @accessor("defaultConditions"), conditions
    @debug "Construindo o modelo com as configuracoes: ", @conditions

  ###
  ###
  exec: ->
    @

  ###
  ###
  get: (field, value)->
    throw "Deve ser passado dois valores para o metodo 'field' e 'value'" if field? or value?

  ###
  Modifica a ordem de recepcao dos registros
  @param String... | Array
  @returns Joker.ActiveResource

  @example

    orderBy( "lastname DESC, name ASC" )
    orderBy( "lastname DESC", "name ASC" )
    orderBy( [ "lastname DESC", "name ASC"] )

  ###
  orderBy: (order...)->
    # Validar os valores se
    # batem com os valores reais
    if Object.isString order
      @conditions.orderBy.push order
    else if Object.isArray order
      for value in order
        @orderBy value
    else
      throw "O objeto enviado deve ser uma String ou Array, tipo: {type}".assign type: typeof order
    @

  ###
  Informa o numero atual da pagina a ser
  requisitada, deve ser utilizada junto
  com a opcao limit
  @param Integer number of page
  @returns Joker.ActiveResource

  @example

    page( 32 )
    page( "32" )

  ###
  page: (number)->
    number = parseInt number
    throw "O valor '{number}' não é um tipo valido, deve ser do tipo Integer".assign number: number
    @conditions.page = number
    @

  ###
  Faz verificacões de atraves de consultas
  condicionais
  @param String | Object
  @param Object assigns to modify values
  @returns Joker.ActiveResource


  @example

    where("name = 'John'")
    where("name = {name}", {name: 'John'})
    where( { name: 'John' } )

  ###
  where: (condition, assigns={})->
    if Object.isString condition
      @conditions.where.push condition.assign assigns
    else if Object.isObject condition
      for value, key in condition
        @where "#{key} = {key}", key: value
    else
      throw "O objeto enviado deve ser uma String ou Object, tipo: {type}".assign type: typeof condition
    @

  ###
  Define o agrupamento a ser solicitado
  @param String... | Array
  @returns Joker.ActiveResource

  @example

    group( "lastname, age" )
    group( "lastname", "age" )
    group( [ "lastname", "age" ] )

  ###
  group: (group...)->
    if Object.isString group
      @conditions.group.push group
    else if Object.isArray group
      for value in group
        @group value
    else
      throw "O objeto enviado deve ser uma String ou Array, tipo: {type}".assign type: typeof group
    @

  ###
  Define o limite de registro solicitado
  a aplicacão
  @param Integer numero de registros
  @returns Joker.ActiveResource
  ###
  limit: (limit)->
    limit = parseInt limit
    throw "O valor '{limit}' não é um tipo valido, deve ser do tipo Integer".assign limit: limit
    @conditions.limit = limit
    @

  ###
  Converte o objeto em string
  @returns String
  ###
  toString: ->
    @toUrl()

  ###
  Conevrte os dados enviados e configurados
  na url a ser solicitada
  @returns String
  ###
  toUrl: ->
    throw "A implementar"

