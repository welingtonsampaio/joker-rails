###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Window.js
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
class Joker.Window extends Joker.Core

  ###
  Contem a posicao atual da janela no
  eixo X no momento da movimentacao
  @type Float
  ###
  containerX: undefined

  ###
  Contem a posicao atual da janela no
  eixo Y no momento da movimentacao
  @type Float
  ###
  containerY: undefined

  ###
  Configuracoes de entrada do objeto
  @type Object
  ###
  data: undefined

  ###
  Define a janela esta liberada para
  modificacao de lugar
  @type Boolean
  ###
  drag: undefined

  ###
  Contem a posicao atual do mouse no
  eixo X no dispatch do evento
  @type Float
  ###
  mouseX: undefined

  ###
  Contem a posicao atual do mouse no
  eixo Y no dispatch do evento
  @type Float
  ###
  mouseY: undefined

  ###
  Objeto responsavel por guardar as classes
  do corpo do html, durante o evento de move
  @type CSSStyleDeclaration
  ###
  originBodyCss: undefined

  constructor: (params={})->
    super
    @data = @libSupport.extend true, {}, @accessor('defaultParams'), params
    @createWidget()

  ###
  ###
  destroy: ->
    @container.off ".widget"
    @container.remove()
    super

  ###
  ###
  createWidget: ->
    title     = @accessor('patterns').title.assign title: @data.title
    content   = @accessor('patterns').content.assign content: @data.content
    @container = $ @accessor('patterns').container.assign {title: title}, {content: content}, {id: @objectId}
    @container.appendTo "body"
    @setEvents()

  ###
  ###
  defineToActive: ->
    $('.widget').not(@container).removeClass 'active'
    @container.addClass 'active'
    true

  ###
  ###
  moveContainer: (e)->
    return true unless @drag
    newX = @containerX + (e.clientX - @mouseX)
    newY = @containerY + (e.clientY - @mouseY)

    newX = window.innerWidth - @container[0].offsetWidth - @accessor('margin').right if @container[0].offsetWidth + newX + @accessor('margin').right > window.innerWidth
    newX = @accessor('margin').left if newX - @accessor('margin').left < 0

    newY = window.innerHeight - @container[0].offsetHeight - @accessor('margin').bottom if @container[0].offsetHeight + newY + @accessor('margin').bottom > window.innerHeight
    newY = @accessor('margin').top if newY - @accessor('margin').top < 0

    @container.addClass('alpha').css
      left: newX
      top : newY

  ###
  ###
  setEvents: ->
    $(@container).on "mousedown.widget", "div.title",  $.proxy( @startDrag, @ )
    $(@container).on "mouseup.widget",   "div.title",  $.proxy( @stopDrag, @ )
    $( document ).on "mousemove.widget",               $.proxy( @moveContainer, @ )
    $(@container).on "click.widget",     "span.close", $.proxy( @destroy, @ )
    $(@container).on "click.widget",                   $.proxy( @defineToActive, @ )

  ###
  ###
  startDrag: (e)->
    @drag = true
    @mouseX = e.clientX
    @mouseY = e.clientY
    @containerX = @container[0].getBoundingClientRect().left
    @containerY = @container[0].getBoundingClientRect().top
    body = $("body")
    @originBodyCss = body[0].style
    body.css({
      '-moz-user-select' : 'none',
      '-khtml-user-select' : 'none',
      '-webkit-user-select' : 'none',
      '-o-user-select' : 'none',
      'user-select' : 'none'
    });
    @defineToActive()
    true

  ###
  ###
  stopDrag: ->
    @drag = false
    document.getElementsByTagName("body")[0].style = @originBodyCss
    @container.removeClass 'alpha'
    true


  @debugPrefix: "Joker_Window"
  @className  : "Joker_Window"

  ###
  parametros default que todas as janelas devem
  conter. Alguns dos elementos devem ser sobeescrito
  no metodo construtor para seu uso correto.
  @static
  @type Object
  ###
  @defaultParams:
    ###
    Conteudo HTML a ser adicionado ao window
    Requer sobreescrita
    @type String
    ###
    content: null
    ###
    Define qual o titulo da janela a ser renderizada
    Requer sobreescrita
    @type String
    ###
    title: null
    ###
    Informa se esta janela deve ser uma instância unica
    ou se poderá ser criado várias instancias da mesma
    janela
    @default FALSE
    @type Boolean
    ###
    uniqObject: false


  ###
  Margens padroes que limitao a janela de chegar
  proximo da borda do navegador
  @static
  @type Object
  ###
  @margin:
    ###
    Define a borda do topo
    @type Integer
    ###
    top   : 48
    ###
    Define a borda da direita
    @type Integer
    ###
    right : 0
    ###
    Define a borda do rodape
    @type Integer
    ###
    bottom: 0
    ###
    Define a borda da esquerda
    @type Integer
    ###
    left  : 0

  ###
  Padroes de criacao do box
  estes padroes contem dados de como deve ser criado
  o elemento da janela
  @static
  @type Object
  ###
  @patterns:
    ###
    Padrao do container pai dos elementos
    @type String
    ###
    container: """
               <div id="{id}" class="widget" style="position: absolute">
               {title}
               {content}
               </div>
               """
    ###
    Padrao para o titulo das janelas a serem
    renderizadas
    @type String
    ###
    title: """
           <div class="title">
           <h3>{title}</h3>
           <span class="close">&times;</span>
           </div>
           """
    ###
    Padrao do box de conteudo da janela
    @type String
    ###
    content: """
             <div class="content">
             {content}
             </div>
             """