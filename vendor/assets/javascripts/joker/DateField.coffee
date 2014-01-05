###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        DateField.js
@author      Welington Sampaio
@contact     http://jokerjs.zaez.net/contato

@copyright Copyright 2014 Zaez Solucoes em Tecnologia, all rights reserved.

This source file is free software, under the license MIT, available at:
http://jokerjs.zaez.net/license

This source file is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.

For details please refer to: http://jokerjs.zaez.net
###



###

###
class Joker.DateField extends Joker.Core

  constructor: (config={})->
    super
    @settings = @libSupport.extend true, new Object,
      @accessor('defaultSettings'),
      {
        monthsFull: Joker.I18n.translate('date.month_names').slice(1,Joker.I18n.translate('date.month_names').length)
        monthsShort: Joker.I18n.translate('date.abbr_month_names').slice(1,Joker.I18n.translate('date.abbr_month_names').length)
        weekdaysFull: Joker.I18n.translate('date.day_names')
        weekdaysShort: Joker.I18n.translate('date.abbr_day_names')
        today: Joker.I18n.translate('date_field.today')
        clear: Joker.I18n.translate('date_field.clear')
        format: Joker.I18n.translate('date_field.format')
      },
      config
    @debug "Inicializando o DateField", @objectId
    @setEvents


  @debugPrefix: "Joker_DateField"
  @className  : "Joker_DateField"

  @defaultSettings:
    # translations names
    monthsFull: undefined
    monthsShort: undefined
    weekdaysFull: undefined
    weekdaysShort: undefined
    # Buttons
    today: undefined
    clear: undefined
    # Formats
    format: undefined
    formatSubmit: 'yyyy-mm-dd'
    # Editable input
    editable: undefined
    # Dropdown selectors
    selectYears: undefined
    selectMonths: undefined
    # First day of the week
    firstDay: undefined
    # Date limits
    min: undefined
    max: undefined
    # Disable dates
    disable: undefined
    # Root container
    container: undefined



  ###
  @type [Joker.DateField]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @returns [Joker.DateField]
  ###
  @getInstance: ->
    Joker.DateField.instance =  new Joker.DateField() unless Joker.DateField.instance?
    Joker.DateField.instance