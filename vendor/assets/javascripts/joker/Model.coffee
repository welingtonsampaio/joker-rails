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

  ###
  Name of primary key to comunication with database
  @type {String}
  ###
  @primaryKey   : "id"
  ###
  Nome do recurso
  @example:
    +------------+---------------+
    | Table Name | Resource Name |
    +------------+---------------+
    | users      | user          |
    +------------+---------------+
    | addresses  | address       |
    +------------+---------------+
  @type {String}
  ###
  @resourceName : undefined
  ###
  URI of access root list
  @example:
    // for users table
    this.uri: "/users"
  @type {String}
  ###
  @uri          : undefined
  ###
  Prefix to default uri
  @example:
    this.prefixUri: "/api/v1"
  @type {String}
  ###
  @prefixUri    : ""
  ###
  Collection of attributes of the current model
  @type {Array}
  ###
  @fields       : new Object()
  ###
  Collection of associations of the current model
  @type {Array}
  ###
  @associations : new Object()

  ###
  Adiciona os atributos do objeto
  @param {Mixin ... } todos os nomes dos campos
  ###
  @encode: (names...)->
    for name in names
      @attr_accesor name,
        container: "attributes"
      @fields[name] =
        name: name

  ###
  Adiciona uma associacao ao modelo
  ###
  @association: (model, type)->
    @associations[model.name] =
      model: model
      type : type

  ###
  Adiciona os campos de created_at e
  updated_at a colecao de campos
  ###
  @timestamp: ->
    @encode "created_at", "updated_at"

  ###
  Prepara para buscar registros
  @see Joker.ActiveRelation
  @return {Joker.ActiveRelation}
  ###
  @all: ->
    new Joker.ActiveRelation @, @prefixUri+@uri

  ###
  Cria o modelo a partir de um json enviado
  @param {Object} data, json format
  @return {Joker.Model} this model
  ###
  @from_json: (data)->
    throw "É necessario passar um objeto no formato json para funcionar corretamente" unless data?
    model = new @()
    model.debug "Configurando o modelo a partir de um objet json: ", data
    for key, value of data
      if model.has_attribute(key) or key == @primaryKey
        model[key](value)
      else if model.has_association key

      else
        throw "A chave '{key}' não é um atributo existente no modelo <{model}:{object_id}>".assign(key:key,model:model.constructor.name, object_id:model.objectId)
    model

  ###
  Modificador da referencia para a chave
  primaria
  @param {String} key
  ###
  @primary_key: (key)->
    delete @prototype[@primaryKey]
    delete @prototype.attributes["_id"]
    @primaryKey = key
    @attr_accesor key,
      container: "attributes"




  debugPrefix : "Joker_Model"
  name        : "Model"

  constructor: (settings={})->
    super
    @settings = $.extend true, {}, @settings, settings
    @debug "Construindo o modelo com as configuracoes: ", @settings

  ###
  Metodo responsavel por deletar do banco de
  dados o registro contido dentro do modelo.
  A funcao dispara uma requisicao REST para
  o servidor para solicitar a remocao.
  @not_implemented
  ###
  destroy: ->
    @debug "removendo..."

  ###
  Verifica se existe um atributo com o nome
  informado na colecao de atributos
  @param {String} name of attribute
  @return {Boolean}
  ###
  has_attribute: (name)->
    Object.has @accessor("fields"), name

  ###
  Verifica se existe uma associacao com o nome
  informado na colecao de assiciacoes
  @param {String} name of association
  @return {Boolean}
  ###
  has_association: (name)->
    Object.has @accessor("associations"), name

  ###
  Verifica se o modelo esta persistido
  no banco de dados ou nao
  @return {Boolean}
  ###
  is_new: ->
    not Object.has @attributes, "_"+@accessor("primaryKey")

  ###
  Metodo padrao para recuperacao da primaryKey
  passando um valor por parametro setara o valor
  para o atributo, se a chamada for sem parametro
  a funcao retornara o valor atual
  @param {String|Number} value
  @return {String|Number}
  ###
  id: (value)->
    @attributes["_id"] = value if value?
    @attributes["_id"]

  ###
  Metodo responsavel por salvar o conteudo
  do modelo no banco de dados atraves de
  requisicao ajax
  @not_implemented
  ###
  save: ->
    @debug "salvando..."

  ###
  Este metodo é responsavel por realizar o parser
  do formulario que contem campos com o prefixo
  "resourceName" definido no modelo
  @implemented to static
  @return {Object} form serializado
  ###
  from_form: ->

  ###
  Converte o objeto em json puro
  @see {Joker.Model.to_object}
  @return {String}
  ###
  to_json: ->
    JSON.stringify(@to_object())

  ###
  Converte as informacoes do modelo em objeto
  @return {Object}
  ###
  to_object: ->
    obj = new Object()
    obj[@accessor("primaryKey")] = @[@accessor("primaryKey")]() if Object.has(@attributes, "_"+@accessor("primaryKey"))
    Object.keys(@accessor("fields")).each (indice)=>
      obj[indice] = @[indice]() if Object.has(@attributes, "_"+indice)
    Object.keys(@accessor("associations")).each (indice)=>
      # desenvolver each para associacao composta, has_many e has_and_belongs_to_many
      # associacao simples has_one
      obj[indice.model.resourceName] = @[indice.model.resourceName]().to_obj() if Object.has(@attributes, indice)
    obj

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
