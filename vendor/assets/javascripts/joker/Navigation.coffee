(global ? window).Joker.Navigation =
  ###
  Referencia aos links do menu
  @type DOMElement
  ###
  menuLinks: undefined
  ###
  Define se o menu esta com status active
  @default true
  @type Boolean
  ###
  isOpen: false

  ###
  Metodo responsável por fechar os menus
  @param jQueryEvent
  ###
  closeMenu: (e) ->
    return true if not @isOpen or ($('nav.main-nav *').toArray().count(e.target) > 0 and not @menuLinksTarget.toArray().count(e.target) > 0)
    @isOpen = false
    $("ul").removeClass "show"
    $('nav.main-nav').removeClass 'active'

  ###
  Metodo de inicializacao do sistema de menu
  ###
  init: ->
    @setElements()
    @setEvents()

  ###
  Metodo responsavel por abrir o menu
  @param jQueryEvent
  ###
  openMenu: (e) ->
    return true if e.type == 'click' and $(e.target).parent().find('ul').length == 0
    return false if e.type == "mouseover" and @isOpen == false
    $('nav.main-nav').addClass 'active'
    if @isOpen
      $("ul").removeClass "show"
      el = $ e.currentTarget
      el.find("+ul.sub-menu").addClass "show"
    else
      # Abre o Menu
      el = $ e.currentTarget
      el.find("+ul.sub-menu").addClass "show"
      @isOpen = true
      false


  ###
  Configura e seta os elementos
  ###
  setElements: ->
    @menuLinks = $ "ul.main-menu > li > a"
    @menuLinksTarget = $ "ul.main-menu > li > ul a"

  ###
  Configura os eventos de controle do menu
  ###
  setEvents: ->
    @menuLinks.on  "click mouseover",                                  $.proxy(@openMenu, @)
    @menuLinksTarget.on "click",                                       $.proxy(@closeMenu, @)
    $(document).on "click",           "body:has(nav.main-nav.active)", $.proxy(@closeMenu, @)

