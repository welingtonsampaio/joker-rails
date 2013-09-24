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

  ###
  ###
  source: []

  ###
  ###
  xhrResult:
    count      : undefined
    offset     : undefined
    totalCount : undefined
    totalPages : undefined
    currentPage: undefined

  constructor: (@model, @uri, conditions={})->
    super
    @conditions = @libSupport.extend true, {}, @accessor("defaultConditions"), conditions
    @debug "Construindo o modelo com as configuracoes: ", @conditions

  ###
  Retorna a quantidade de registros
  da apgina
  @returns Integer
  ###
  count: ->
    @xhrResult.count

  ###
  Retorna o numero da pagina atual
  @returns Integer
  ###
  currentPage: ->
    @xhrResult.currentPage

  ###
  Executa a requisicao dos dados
  @returns Joker.ActiveResource
  ###
  exec: ->
    data = @prepareDataToUrl()
    new Joker.Ajax
      url      : @toUrl()
      useLoader: false
      async    : false
      callbacks:
        error     : (jqXHR, textStatus, errorThrown)=>
          @debug "Ocorreu um erro ao requisitar os registros", data
        success   : (response, textStatus, jqXHR)=>
          @xhrResult.count      = response[@model.resourceName.pluralize()].length
          @xhrResult.offset     = response.offset
          @xhrResult.totalCount = response.total_count
          @xhrResult.totalPages = parseInt (response.total_count / data.limit + .49999999999999).toFixed() unless @conditions.limit.isBlank()
          @xhrResult.currentPage= parseInt( (response.offset / data.limit ).toFixed() ) + 1
          delete @source
          @source = []
          for value, key in response[@model.resourceName.pluralize()]
            @source.push @model.fromJSON value
    @

  ###
  Metodo para interar sobre os resultados
  da requisicao solicitada
  @param Function para a interacão
  @returns Joker.ActiveResource

  @example

    each( function( obj ){
      alert( obj.get('name') );
    })

  ###
  each: (func)->
    throw "Deve ser passado uma funcão como parametro para este metodo" unless Object.isFunction func
    for value in @source
      func(value)
    @

  ###
  ###
  get: (field, value)->
    throw "Deve ser passado dois valores para o metodo 'field' e 'value'" if field? or value?

  ###
  Retorna o numero de offset do inicio do contador
  da requisicao solicitada
  @returns Integer
  ###
  offset: ->
    @xhrResult.offset

  ###
  Modifica a ordem de recepcao dos registros
  @param String... | Array
  @returns Joker.ActiveResource

  @example

    orderBy( "lastname DESC, name ASC" )
    orderBy( "lastname DESC", "name ASC" )
    orderBy( [ "lastname DESC", "name ASC"] )

  ###
  orderBy: (item, order...)->
    # Validar os valores se
    # batem com os valores reais
    if Object.isString item
      @conditions.orderBy.push item
    else if Object.isArray item
      for value in item
        @orderBy value
    else
      throw "O objeto enviado deve ser uma String ou Array, tipo: {type}".assign type: typeof item
    for value in order
      @orderBy value
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
    throw "O valor '{number}' não é um tipo valido, deve ser do tipo Integer".assign number: number  unless Object.isNumber(number)
    @conditions.page = number.toString()
    @

  ###
  Faz verificacões de atraves de consultas
  condicionais
  @param String | Object
  @param Object assigns to modify values
  @returns Joker.ActiveResource

  @example

    where("name = 'John'")
    where("name = '{name}'", {name: 'John'})
    where( { name: 'John' } )

  ###
  where: (condition, assigns={})->
    if Object.isString condition
      @conditions.where.push condition.assign assigns
    else if Object.isObject condition
      for key, value of condition
        @where "#{key} = '{key}'", key: value
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
  group: (item, order...)->
    if Object.isString item
      @conditions.group.push item
    else if Object.isArray item
      for value in item
        @group value
    else
      throw "O objeto enviado deve ser uma String ou Array, tipo: {type}".assign type: typeof group
    for value in order
      @group value
    @

  ###
  Define o limite de registro solicitado
  a aplicacão
  @param Integer numero de registros
  @returns Joker.ActiveResource
  ###
  limit: (limit)->
    limit = parseInt limit
    throw "O valor '{limit}' não é um tipo valido, deve ser do tipo Integer".assign limit: limit unless Object.isNumber(limit)
    @conditions.limit = limit.toString()
    @

  ###
  Atraves das informacoes selecionadas o sistema
  monta as configuracoes de envio de solicitacao
  @returns Object
  ###
  prepareDataToUrl: ->
    data = {}
    # Configurando as informacoes de agrupamentos
    if @conditions.group.length > 0
      data.group = ""
      for value in @conditions.group
        data.group += if data.group then ", #{value}" else value
      data.group = data.group.encodeBase64()

    # Configurando as ordenacoes dos registros
    if @conditions.orderBy.length > 0
      for key, value of @conditions.orderBy
        data.orderBy = if data.orderBy? then "#{data.orderBy}, #{value}" else value
      data.orderBy = data.orderBy.encodeBase64()

    # Configurando as regras de condicoes
    if @conditions.where.length > 0
      data.where = ""
      for value in @conditions.where
        data.where += if data.where then "and (#{value})" else value
      data.where = data.where.encodeBase64()

    # configura o limite do returno solicitado
    data.limit = @conditions.limit unless @conditions.limit.isBlank()

    # configura a pagina de solicitacao
    data.page = @conditions.page unless @conditions.page.isBlank()
    data

  ###
  Converte o objeto em string
  @returns String
  ###
  toString: ->
    @toUrl()

  ###
  Numero total de registros
  @returns Integer
  ###
  totalCount: ->
    @xhrResult.totalCount

  ###
  Numero total de paginas disponiveis
  conforme o numero de registros por
  pagina
  @returns Integer
  ###
  totalPages: ->
    @xhrResult.totalPages

  ###
  Conevrte os dados enviados e configurados
  na url a ser solicitada
  @returns String
  ###
  toUrl: ->
    data = @prepareDataToUrl()
    "#{@model.prefixUri}#{@model.uri}.json?#{Object.toQueryString(data)}"

