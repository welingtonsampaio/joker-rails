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

#= require './plupload/moxie'
#= require './plupload/plupload'
#= require './plupload/jquery.plupload.queue'

###

###
class Joker.Uploader extends Joker.Core

  callbacks: undefined
  uploader : undefined

  constructor: (config={})->
    super
    @settings = @libSupport.extend true, new Object,
                                         @accessor('defaultSettings'),
                                         {headers: {"X-CSRF-Token": @libSupport("meta[name='csrf-token']").attr("content")}},
                                         config
    @debug "Inicializando o Uploader", @objectId
    @createUploader()

  addNewFiles: (up, files) ->

    @libSupport.each files, =>
      true
    @callbacks.FilesAdded(up, files)

  callbackFileUploaded: (up, file, info)->
    @settings.callbacks.FileUploaded(up, file, info)            if Object.isFunction(@settings.callbacks.FileUploaded)
    eval("#{@settings.callbacks.FileUploaded}(up, file, info)") if Object.isString(@settings.callbacks.FileUploaded)

  createUploader: ->
    @uploader = @libSupport("##{@settings.container}").pluploadQueue
      runtimes:         @settings.runtimes
      url:              @settings.url
      multi_selection:  @settings.multi_selection
      filters:          @settings.filters
      headers:          @settings.headers
      multipart_params: @settings.multipart_params
      unique_names:     @settings.unique_names
      init:
        FileUploaded: @libSupport.proxy(@callbackFileUploaded, @)


  @debugPrefix: "Joker_Uploader"
  @className  : "Joker_Uploader"

  @defaultSettings:
    container: null
    url: null
    filters:
      mime_types: []
      prevent_duplicates: true
    multipart_params: {}
    runtimes: 'html5'
    multi_selection: true
    unique_names: false
    callbacks:
      Refresh:        (up)->
      StateChanged:   (up)->
      QueueChanged:   (up)->
      UploadProgress: (up, file)->
      FilesAdded:     (up, files)->
      FilesRemoved:   (up, files)->
      FileUploaded:   (up, file, info)->
      ChunkUploaded:  (up, file, info)->
      Error:          (up, args)->

Joker.Core.libSupport ->
  plupload.addI18n Joker.I18n.translations.uploader
