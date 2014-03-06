###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Typeahead.js
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
class Joker.Typeahead extends Joker.Core

  ###
  Constructor method
  ###
  constructor: ->
    super
    @debug "Inicializando o Typeahead"
    @setEvents()

  ###
  Configura o elemento do typeahead
  @param jQueryEvent ev
  ###
  configure: (ev)->
    @debug "Configurando os novos Typeaheads"
    el = @libSupport ev.target
    unless el.data "typeheaded"
      console.log "Configurando os novos Typeaheads"


      url = el.data('autocomplete')
      url = App.Routes[url]() unless url.has('.json')

      storage = new Bloodhound
        datumTokenizer: (d)->
          Bloodhound.tokenizers.whitespace d
        limit: 10
        queryTokenizer: Bloodhound.tokenizers.whitespace
        remote: "#{url}?filter[all]=%QUERY"

      storage.initialize()

      el.typeahead( {highlight: true},
        name: el.attr('id')
        source: storage.ttAdapter()
        displayKey: el.data('valuekey')
        templates:
          suggestion: Handlebars.compile(if el.data('template')? then el.data('template') else """<p>{{name}}</p>""")
      )
      el.data("typeheaded", true).focus()
      el.on 'typeahead:selected', @libSupport.proxy( @selectedTypeahead, @ )
      el.on 'typeahead:closed',   @libSupport.proxy( @selectedClose, @ )
      el.on 'typeahead:cursorchanged', ->
        console.log arguments
      if el.data('callback')?
        @accessor('callbacks')[el.data('callback')](ev.target)

  ###

  ###
  selectedClose: (e, obj)->
    el = @libSupport e.target
    target = @libSupport "##{el.data('target')}"
    target.val '' if JokerUtils.isEmpty el.val()

  selectedTypeahead: (e, obj)->
    console.log arguments
    el = @libSupport e.target
    target = @libSupport "##{el.data('target')}"
    target.val obj[el.data('indicekey')]

  setEvents: ->
    @debug "Configurando os eventos"
    @libSupport(document).on 'focus', '.typeahead', @libSupport.proxy( @configure, @ )

  @debugPrefix: "Joker_Typeahead"
  @className  : "Joker_Typeahead"

  ###
  Armazena as funcoes de callbacks.
  Todas as chamadas de callbacks devem 
  estar dentro deste objeto
  @type Object
  ###
  @callbacks: new Object

  ###
  @type [Joker.Typeahead]
  ###
  @instance  : undefined

  ###
  Adiciona um novo callback a coleção
  @param String name
  @param Function func
  @retunrs Joker.Typeahead
  ###
  @addCallback: (name, func)->
    Joker.Typeahead.callbacks[name] = func
    Joker.Typeahead

  ###
  Retorna a variavel unica para a instacia do objeto
  @returns [Joker.Typeahead]
  ###
  @getInstance: ->
    Joker.Typeahead.instance =  new Joker.Typeahead() unless Joker.Typeahead.instance?
    Joker.Typeahead.instance