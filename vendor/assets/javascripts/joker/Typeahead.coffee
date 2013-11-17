


###

###
class Joker.Typeahead extends Joker.Core

  ###
  Constructor method
  ###
  constructor: (params={})->
    super
    @debug "Inicializando o Typeahead"
    @setEvents()

  configure: (ev)->
    @debug "Configurando os novos Typeaheads"
    el = @libSupport ev.target
    unless el.data "typeheaded"
      console.log "Configurando os novos Typeaheads"
      el.typeahead
        name: el.attr('id')
        remote: "#{el.data('autocomplete')}?q=%QUERY&limit=5"
        engine: Hogan
        valueKey: el.data('valuekey')
        template: if el.data('template')? then el.data('template') else """<p>{{name}}</p>"""
      el.data("typeheaded", true).focus()
      el.on 'typeahead:selected', @libSupport.proxy( @selectedTypeahead, @ )
      if el.data('callback')?
        @accessor('callbacks')[el.data('callback')](ev.target)

  selectedTypeahead: (e, obj)->
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