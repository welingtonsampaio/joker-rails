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
    @accessor('createBottomMinimizeContainer')() if @accessor('useMinimize')
    @create()
    @setEvents()
    @accessor("addToCollection")(@)
    @defineToActive()
    @accessor('rebuildMaxSizes')()
    @accessor("refreshIndexes" )()
    @setCenter()
    @

  ###
  Cria a janela atribuindo o conteudo
  Requer titulo e conteudo
  ###
  create: ->
    title     = @accessor('patterns').title.assign
      title: @data.title
      maximize: ( if @accessor('useMaximize') then @accessor('patterns').controlMaximize else '' )
      minimize: ( if @accessor('useMinimize') then @accessor('patterns').controlMinimize else '' )
    content   = @accessor('patterns').content.assign content: @data.content
    @container = @libSupport @accessor('patterns').container.assign {title: title}, {content: content}, {id: @objectId}
    @container.appendTo "body"
    @accessor('minimizeContainer').append @accessor('patterns').bottomMinimizeSpan.assign {title: @data.title}, {id: @objectId}

  ###
  Metodo responsavel por remover a janela
  seguindo o padrao de remover primeiramento
  os eventos e depois o DOMObject, depois ele
  executa o metodo pai
  ###
  destroy: ->
    @container.off ".widget"
    @container.remove()
    @accessor("removeFromId")( @objectId )
    @accessor("refreshIndexes")( )
    @accessor("minimizeContainer").find("[data-target=#{@objectId}]").remove()
    super

  ###
  Define a janela para ativo, automaticamente todas
  as outras janelas serão desativadas
  Faz o gerenciamento de até 1000 janelas
  @returns Boolean true
  ###
  defineToActive: ->
    if @container.data 'minimized'
      new Joker.Animation
        target: @container
        enterEffect: Joker.Animation.FX_FADEINUP
        autoLeave: false
      @container.removeClass("#{Joker.Animation.FX_FADEOUTDOWN} hide").data 'minimized', false
    @libSupport('.jwindow').not(@container).removeClass 'active'
    @container.addClass 'active'
    @accessor("defineToBiggerIndex")( @ )
    @accessor("minimizeContainer").find('span').removeClass 'active'
    @accessor("minimizeContainer").find("[data-target=#{@objectId}]").addClass 'active'
    true

  ###
  Responsavel por maximizar e restaurar
  Quando maximizado define o top e left para
    as margens padrao
  Quando restaurado define o container para
    o centro da area disponivel
  ###
  maximize: ->
    icon = @container.find('.jwindow-title .maximize i')
    if icon.hasClass('iconset1-expand-3')
      @container.css
        minWidth : window.innerWidth - Window.margin.left - Window.margin.right
        minHeight: window.innerHeight - Window.margin.top - Window.margin.bottom
        top: @accessor('margin').top
        left:@accessor('margin').left
    else
      @container.css minWidth: 'initial', minHeight: 'initial'
      @setCenter()
    icon.toggleClass('iconset1-expand-3').toggleClass('iconset1-contract')

  ###
  Adiciona efeito de transicão para
  esconder a janela
  ###
  minimize: ->
    new Joker.Animation
      target: @container
      enterEffect: Joker.Animation.FX_FADEOUTDOWN
      autoLeave: false
      callbacks:
        finishEnter: =>
          @container.data 'minimized', true
          @container.addClass 'hide'
          @accessor("minimizeContainer").find("[data-target=#{@objectId}]").removeClass 'active'



  ###
  Faz as modificacoes de posicionamento da janela
  @param Object e | e.clientX
                  | e.clientY
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
  Coloca a janela no centro da area livre
  ###
  setCenter: ->
    width  = @container[0].offsetWidth
    height = @container[0].offsetHeight
    @container.css
      top: window.innerHeight/2-height/2+(@accessor('margin').top-@accessor('margin').bottom)/2
      left: window.innerWidth/2-width/2+(@accessor('margin').left-@accessor('margin').right)/2

  ###
  Seta os eventos direcionados aos  objetos
  ###
  setEvents: ->
    @libSupport(@container).on "mousedown.jwindow", "div.jwindow-title",  @libSupport.proxy( @startDrag, @ )
    @libSupport(@container).on "mouseup.jwindow",   "div.jwindow-title",  @libSupport.proxy( @stopDrag, @ )
    @libSupport( document ).on "mousemove.jwindow",                       @libSupport.proxy( @moveContainer, @ )
    @libSupport(@container).on "click.jwindow",     "span.close",         @libSupport.proxy( @destroy, @ )
    @libSupport(@container).on "click.jwindow",                           @libSupport.proxy( @defineToActive, @ )

    @libSupport(@container).on "click.jwindow",     "span.maximize",      @libSupport.proxy( @maximize, @ )
    @libSupport(@container).on "click.jwindow",     "span.minimize",      @libSupport.proxy( @minimize, @ )
    @windowEventResize()


  ###
  Inicia o evento de movimentacao
  @param DOMEvent e | e.clientX
                    | e.clientY
  @returns Boolean true
  ###
  startDrag: (e)->
    @drag = true
    @mouseX = e.clientX
    @mouseY = e.clientY
    @containerX = @container[0].getBoundingClientRect().left
    @containerY = @container[0].getBoundingClientRect().top
    body = @libSupport("body")
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
  Para o evento de movimentacao
  @returns Boolean true
  ###
  stopDrag: ->
    @drag = false
    @libSupport('body').css({
      '-moz-user-select' : 'inherit',
      '-khtml-user-select' : 'inherit',
      '-webkit-user-select' : 'inherit',
      '-o-user-select' : 'inherit',
      'user-select' : 'inherit'
    });
    @container.removeClass 'alpha'
    true

  ###
  Define evento de resize na janela do browser
  apenas uma unica vez
  ###
  windowEventResize: ->
    @libSupport(window).on "resize.jwindow", @libSupport.proxy( @accessor('rebuildMaxSizes'), @ ) unless window.jwindowEvent?
    window.jwindowEvent = true


  @debugPrefix: "Joker_Window"
  @className  : "Joker_Window"
  @defaultIndex: 1009
  @indexes: new Array()
  @minimizeContainer: undefined

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
    top   : 0
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
               <div id="{id}" class="jwindow" style="position: absolute">
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
           <div class="jwindow-title">
             <h3>{title}</h3>
             <div class="controls">
               <span class="close"><i class="iconset1-close-2"></i></span>
               {minimize}
               {maximize}
             </div>
           </div>
           """
    ###
    Padrao do box de conteudo da janela
    @type String
    ###
    content: """
             <div class="jwindow-content">
             {content}
             </div>
             """
    ###
    Padrao do icone de maximizar a janela
    @type String
    ###
    controlMaximize: """
                     <span class="maximize"><i class="iconset1-expand-3"></i></span>
                     """
    ###
    Padrao do icone de minimizar a janela
    @type String
    ###
    controlMinimize: """
                     <span class="minimize"><i class="iconset1-minus"></i></span>
                     """
    bottomMinimizeContainer: """
                             <div class="minimize-display"></div>
                             """
    bottomMinimizeSpan: """
                        <span data-target="{id}">{title}</span>
                        """

  ###
  Define se deve adicionado o icone
  de maximizar a janela
  @type Boolean
  ###
  @useMaximize: true

  ###
  Define se deve adicionado o icone
  de minimizar a janela
  @type Boolean
  ###
  @useMinimize: true

  ###
  Adiciona uma nova janela a colecao de
  janelas do sistema
  @param Joker.Window win
  ###
  @addToCollection: (win)->
    Window.indexes.push
      id: win.objectId
      object: win

  ###
  Cria o container que recebe os itens de
  referencia das janelas abertas no sistema
  Incrementa o valor padrao da barra na
    margin do rodape
  ###
  @createBottomMinimizeContainer: ->
    unless document.getElementById('bottom-minimize-container')
      Window.margin.bottom += 37;
      Window.minimizeContainer = Joker.Core.libSupport Window.patterns.bottomMinimizeContainer
      Window.minimizeContainer.attr 'id', 'bottom-minimize-container'
      Window.minimizeContainer.appendTo 'body'
      Window.createEventMinimizeClick()

  ###
  Adiciona o evento de clica na barra de
  itens de referencia, quando clicado em
  algum filho da barra é acionado o metodo
  que define a janela para ativo
  ###
  @createEventMinimizeClick: ->
    Joker.Core.libSupport(Window.minimizeContainer).on 'click', 'span', (e)->
      win = JokerUtils.getObject e.currentTarget.dataset.target
      win.defineToActive()

  ###
  Define o objeto informado para ultimo
  @param Joker.Window win
  ###
  @defineToBiggerIndex: (win)->
    Window.removeFromId win.objectId
    Window.addToCollection win
    Window.refreshIndexes()

  @maximizeLastIndex: ->
    Window.indexes[Window.indexes.length-1].object.maximize()

  @minimizeLastIndex: ->
    Window.indexes[Window.indexes.length-1].object.minimize()

  ###
  Define o width e height maximo para o
  Window conforme o tamanho atual da
  janela do browser, descontando as margens
  ###
  @rebuildMaxSizes: ->
    Window.indexes.each (n)->
      n.object.container.css
        maxWidth : window.innerWidth - Window.margin.left - Window.margin.right
        maxHeight: window.innerHeight - Window.margin.top - Window.margin.bottom

  ###
  Atualiza a lista de janelas, recolocando o
  index conforme a ordem da lista
  ###
  @refreshIndexes: ->
    Window.indexes.each (n,i)->
      n.object.container.css "z-index", Window.defaultIndex + i

  ###
  Remove a ultima janela da colecao de elemento
  o elemento com o z-index maior
  ###
  @removeLastIndex: ->
    Window.indexes[Window.indexes.length-1].object.destroy() if Window.indexes.length > 0

  ###
  Remove da colecao de elemento o elemento
  com o ID passado por parametro
  @param String id
  ###
  @removeFromId: (id)->
    Window.indexes=Window.indexes.exclude (n)-> n.id == id
    Window.indexes.compact()
