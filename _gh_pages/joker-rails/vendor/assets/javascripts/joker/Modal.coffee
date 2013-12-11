###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Modal.js
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
class Joker.Modal extends Joker.Core

  modal:   undefined
  overlay: undefined
  params:  undefined

  ###
  Constructor method
  ###
  constructor: (config={})->
    super
    @settings = @libSupport.extend true, new Object, @accessor('defaultSettings'), config
    @debug "Inicializando o Modal", @objectId
    if @validateParams()
      @debug 'Todos os valores são válidos para a criação'
      @createModal()
      @setEvents()
      if @settings.callbacks.beforeCreate(@)
        @debug 'Permitido a inserção do Modal no HTML pelo callback', @settings.callbacks.beforeCreate
        @addToBody()
        @show() if @settings.autoShow
        @settings.callbacks.afterCreate(@)
    else
      @debug "Valores invalidos para criar o Modal", @settings

  ###
  Adiciona o modal no corpo do HTML
  ###
  addToBody: ->
    @debug 'Adicionando o Modal no HTML'
    @modal.appendTo 'body'
    @overlay.appendTo 'body'

  ###
  Responsavel por criar os elementos do
  modal, sendo que cada um tem sua funcao
  ###
  createModal: ->
    @debug 'Gerando os elementos do Modal'
    @modal = @libSupport Object.clone(@accessor 'patternModal').assign
      effect:  @settings.effect
      id:      @objectId
      title:   @settings.title
      content: @settings.content
    @overlay = @libSupport '<div class="md-overlay"></div>'

  ###
  Responsavel por remover o modal da tela 
  e executar os callbacks
  ###
  destroy: ->
    @debug 'Executando o metodo de remover'
    if @settings.callbacks.beforeDestroy(@)
      @debug 'Permitido a remoção pelo callback', @settings.callbacks.beforeDestroy
      @unsetEvents()
      @modal.removeClass 'md-show'
      setTimeout =>
        @settings.callbacks.afterDestroy(@)
        @modal.remove()
        @overlay.remove()
      , 350
      super


  ###
  Sets all events from the elements
  ###
  setEvents: ->
    @debug "Setando os eventos"
    @overlay.on 'click.modal', @libSupport.proxy(@destroy, @)


  ###
  ###
  show: ->
    @debug 'Configurando a apresentação do modal através do css ".md-show"'
    setTimeout =>
      @modal.addClass 'md-show'
      @debug 'CSS .md-show adicionado'
    , 10

  ###
  Removendo todos os eventos do Modal
  ###
  unsetEvents: ->
    @debug 'Removendo os eventos'
    @modal.off '.modal'
    @overlay.off '.modal'

  ###
  Valida se os valores contidos dentro de Params
  estao corretos e são validos
  @returns Boolean
  ###
  validateParams: ->
    @settings.title? and 
    @settings.content? and 
    @settings.effect?

  @debugPrefix: "Joker_Modal"
  @className  : "Joker_Modal"

  @defaultSettings:
    ###
    Define se o modal deve ser mostrado apos sua inicialização
    @type Boolean
    ###
    autoShow: true
    ###
    Callback disparados em determinadas ações
    do usuário
    @type Object
    ###
    callbacks:
      ###
      Metodo disparado logo após a
      criação do modal
      @type Function
      @param {Joker.Modal} modal
      @returns Void
      ###
      afterCreate: (modal)->
      ###
      Metodo disparado logo após a
      remoção do modal da tela
      @type Function
      @param {Joker.Modal} modal
      @returns Void
      ###
      afterDestroy: (modal)->
      ###
      Metodo disparado antes de ser permitido a
      criação do modal
      @type Function
      @param {Joker.Modal} modal
      @returns Boolean
      ###
      beforeCreate: (modal)->
        true
      ###
      Metodo disparado antes de ser permitido a
      remoção do modal da tela
      @type Function
      @param {Joker.Modal} modal
      @returns Boolean
      ###
      beforeDestroy: (modal)->
        true
    ###
    Conteudo que deverá ser inserido no corpo do modal
    @type String | DOMElement
    ###
    content: undefined
    ###
    Define qual o efeito padrão do sistema de modal
    @type String
    ###
    effect: 'md-effect-5'
    ###
    Titulo que será apresentado no modal
    @type String
    ###
    title: undefined

  ###
  +-> Efeitos de animação de entrada e saída dos modals
  ###
  @FX_FADE_IN_AND_SCALE: 'md-effect-1'
  @FX_SLIDE_IN_RIGHT: 'md-effect-2'
  @FX_SLIDE_IN_BOTTOM: 'md-effect-3'
  @FX_NEWSPAPPER: 'md-effect-4'
  @FX_FALL: 'md-effect-5'
  @FX_SIDE_FALL: 'md-effect-6'
  @FX_STICKY_UP: 'md-effect-7'
  @FX_3D_FLIP_HORIZONTAL: 'md-effect-8'
  @FX_3D_FLIP_VERTICAL: 'md-effect-9'
  @FX_3D_SIGN: 'md-effect-10'
  @FX_SUPER_SCALED: 'md-effect-11'
  @FX_JUST_ME: 'md-effect-12'
  @FX_3D_SLIT: 'md-effect-13'
  @FX_3D_ROTATE_BOTTOM: 'md-effect-14'
  @FX_3D_ROTATE_IN_LEFT: 'md-effect-15'
  @FX_BLUR: 'md-effect-16'
  @FX_LET_ME: 'md-effect-17'
  @FX_MAKE_WAY: 'md-effect-18'
  @FX_SLIP_FROM_TOP: 'md-effect-19'
  ###
  <-+ 
  ###
  
  ###
  Modelo padrao de criação do modal
  @type String
  ###
  @patternModal : """
                  <div class="md-modal {effect}" id="{id}">
                    <div class="md-content">
                      <h3>{title}</h3>
                      <div>
                        {content}
                      </div>
                    </div>
                  </div>
                  """
