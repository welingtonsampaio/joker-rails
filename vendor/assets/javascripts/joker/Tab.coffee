###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Tab.js
@author      Elison de Campos
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
class Joker.Tab extends Joker.Core

  constructor: ->
    super
    @setEvents()

  changeTab: (e) ->
    ref = e.currentTarget.dataset.tabReference
    tabmenu = @libSupport ".tabs-menu[rel=#{ref}]"
    container = @libSupport ".tabs-container[data-tab=#{ref}]"
    tabmenu.find("a.active").removeClass "active"
    container.find(".tab.active").removeClass "active"
    @libSupport(e.currentTarget).addClass "active"
    @libSupport("##{e.currentTarget.dataset.tabTarget}").addClass "active"

  createTab: (el) ->
    el.dataset.tab = JokerUtils.uniqid()
    el = @libSupport el
    tabs = el.find '.tab'
    tabmenu = @libSupport @createTabMenu(tabs, el.data("tab"))
    tabmenu.insertBefore "##{el.data 'parent'}"
    tabmenu.find("a").on 'click.tab', @libSupport.proxy(@changeTab, @)
    tabmenu.find("a").first().trigger 'click'

  createTabMenu: (elements, id) ->
    string_content = ""
    elements.each (index, el) =>
      width = Math.round(100/elements.length)
      width = width+100-width*elements.length if (index+1) == elements.length
      el.id = JokerUtils.uniqid()
      string_content += Object.clone(@accessor("patterns").link).assign
        target: el.id
        ref: id
        icon: el.dataset.tabIcon
        text: el.dataset.tabText
        width: width
    Object.clone(@accessor("patterns").container).assign
      ref: id
      content: string_content



  setEvents: ->
    @libSupport(document).on "ajaxComplete", @libSupport.proxy(@verifyNewTab, @)

  verifyNewTab: (e) ->
    @libSupport(".tabs-container:not([data-tab])").each (index, el) => @createTab el

  @debugPrefix: "Joker_Tab"
  @className  : "Joker_Tab"

  ###
  @type [Joker.Tab]
  ###
  @instance  : undefined
  @patterns:
    container: """
    <div class="row-fluid">
      <ul class="tabs-menu" rel="{ref}">
        {content}
      </ul>
    </div>
    """
    link: """
    <li style="width:{width}%;"><a href="#" data-tab-target="{target}" data-tab-reference="{ref}"><i class="{icon}"></i>{text}</a></li>
    """

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.Tab]
  ###
  @getInstance: ->
    Joker.Tab.instance =  new Joker.Tab() unless Joker.Tab.instance?
    Joker.Tab.instance