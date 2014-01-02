###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Uploader.js
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
class Joker.Uploader extends Joker.Core

  constructor: ->
    super
    @setEvents()

  addNewFiles: (up, files) ->
    @libSupport.each files, =>

  ###
  # Types:
  #   filelist: cria uma tabela que lista os arquivos enviados
  #   filename: cria um campo com o nome do arquivo (somente para arquivos unicos)
  #   avatar
  ###
  createUploaderElements: (params = {}) ->
    defaultParams =
      type: 'filelist'
    params = @libSupport.extend true, {}, defaultParams, params

  setEvents: ->
    @libSupport(document).on 'ajaxComplete', @libSupport.proxy(@verifyUploader, @)

  setUploader: (el) ->
    window.el = el
#    options = @libSupport(el.dataset.upload
#    console.log options
#    uploader = new plupload.Uploader
#      runtimes: 'html5'
#      url: el.dataset.uploadUrl
#      container: el.getAttribute("id")
#      browse_button: 'pickfiles'
#      max_file_soze: '10mb'
#      multi_selection: if el.dataset.uploadMultiple == "true" then true else false
#      filters: [
#        {title : "Image  files", extensions : "jpg,gif,png"},
#        {title : "Zip files", extensions : "zip"}
#      ]
#    uploader.init()
#    uploader.on 'FilesAdded', (up, files) => @addNewFiles(up, files)
    el.dataset.uploader = true

  verifyUploader: (e) ->
    @libSupport(".joker-uploader:not([data-uploader])").each (index, el) => @setUploader el


  @debugPrefix: "Joker_Uploader"
  @className  : "Joker_Uploader"

  ###
  @type [Joker.Uploader]
  ###
  @instance  : undefined
  @patterns:
    link: """<a href="#" class="remove-item"><i class="{icon}" data-target="{ref}"></i></a>"""

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.Uploader]
  ###
  @getInstance: ->
    Joker.Uploader.instance =  new Joker.Uploader() unless Joker.Uploader.instance?
    Joker.Uploader.instance