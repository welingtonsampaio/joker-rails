###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        RestDelete.js
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
class Joker.RestDelete extends Joker.Core

  modal:   undefined
  overlay: undefined
  params:  undefined

  constructor: ->
    super
    @setEvents()

  ###
  Faz a requisição para excluir um
  registro do Banco de dados
  @param jQueryEvent event
  @param Joker.Modal modal
  ###
  ajaxDelete: (event, modal)->
    el = event.currentTarget
    new Joker.Ajax
      url: el.href
      method: "DELETE"
      callbacks:
        error: (error)->
          modal.destroy()
          console.log error
          new Joker.Alert
            type: Joker.Alert.TYPE_ERROR
            message: Joker.I18n.t('joker.restDelete.error.ajax_delete')
        success: =>
          modal.destroy()
          @libSupport(document.getElementById el.dataset.reference ).remove()
          new Joker.Alert
            type: Joker.Alert.TYPE_SUCCESS
            message: Joker.I18n.t('joker.restDelete.successf.ajax_delete')

  ###
  Responsavel por criar os elementos do
  modal, sendo que cada um tem sua funcao
  ###
  createModal: (e)->
    new Joker.Ajax
      url: e.currentTarget.href
      callbacks: 
        error: (error)->
          console.log error
          new Joker.Alert
            type: Joker.Alert.TYPE_ERROR
            message: Joker.I18n.t('joker.restDelete.error.create_modal')
        success: (data)=>
          @debug 'Gerando o Modal de confirmação, com a configuração: ', data
          modal = new Joker.Modal
            title:   e.currentTarget.dataset.title
            content: @generateContent(data)
            callbacks:
              beforeCreate: (modal)=>
                modal.modal.find('.btn-danger').on 'click', =>
                  @ajaxDelete(e, modal)
                modal.modal.find('.btn-info').on 'click', @libSupport.proxy(modal.destroy, modal)
    false

  generateContent: (data)->
    itens = []
    for key, value of data
      if Object.isString(value) or Object.isNumber(value)
        itens.add @accessor('patternDestroyItens').assign
          name: key.capitalize()
          value: value
    itensString = ''
    itens.forEach (item)-> itensString += item
    @debug itensString
    @accessor('patternDestroyContainer').assign itens: itensString


  ###
  Sets all events from the elements
  ###
  setEvents: ->
    @debug "Setando os eventos"
    @libSupport(document).on 'click.modal', @accessor('defaultSelector'), @libSupport.proxy(@createModal, @)

  ###
  Removendo todos os eventos do RestDelete
  ###
  unsetEvents: ->
    @debug 'Removendo os eventos'
    @libSupport(document).off '.restdelete'

  @debugPrefix: "Joker_RestDelete"
  @className  : "Joker_RestDelete"
  @defaultSelector: "[data-destroy]"
  @patternDestroyContainer: """
                            <dl>
                            {itens}
                            </dl>
                            <div class="row-fluid">
                              <div class="span6">
                                <button class="btn btn-danger btn-block">excluir</button>
                              </div>
                              <div class="span6">
                                <button class="btn btn-info btn-block">cancelar</button>
                              </div>
                            </div>
                            """
  @patternDestroyItens: """
                        <dt>{name}:</dt>
                        <dd>{value}</dd>
                        """


  ###
  @type [Joker.RestDelete]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @returns [Joker.RestDelete]
  ###
  @getInstance: ->
    Joker.RestDelete.instance =  new Joker.RestDelete() unless Joker.RestDelete.instance?
    Joker.RestDelete.instance