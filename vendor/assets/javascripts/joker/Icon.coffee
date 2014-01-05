###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Icon.js
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
Joker.Icon =

  iconBase: '/assets/icons'

  mimetypes:
    doc: "application/msword"
    dot: "application/msword"
    pdf: "application/pdf"
    pgp: "application/pgp-signature"
    ps: "application/postscript"
    ai: "application/postscript"
    eps: "application/postscript"
    rtf: "application/rtf"
    xls: "application/vnd.ms-excel"
    xlb: "application/vnd.ms-excel"
    ppt: "application/vnd.ms-powerpoint"
    pps: "application/vnd.ms-powerpoint"
    pot: "application/vnd.ms-powerpoint"
    zip: "application/zip"
    swf: "application/x-shockwave-flash"
    swfl: "application/x-shockwave-flash"
    docx: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    dotx: "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
    xlsx: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    pptx: "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    potx: "application/vnd.openxmlformats-officedocument.presentationml.template"
    ppsx: "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
    js: "application/x-javascript"
    json: "application/json"
    mp3: "audio/mpeg"
    mpga: "audio/mpeg"
    mpega: "audio/mpeg"
    mp2: "audio/mpeg"
    wav: "audio/x-wav"
    m4a: "audio/x-m4a"
    oga: "audio/ogg"
    ogg: "audio/ogg"
    aiff: "audio/aiff"
    aif: "audio/aiff"
    flac: "audio/flac"
    aac: "audio/aac"
    ac3: "audio/ac3"
    wma: "audio/x-ms-wma"
    bmp: "image/bmp"
    gif: "image/gif"
    jpg: "image/jpeg"
    jpeg: "image/jpeg"
    jpe: "image/jpeg"
    psd: "image/photoshop"
    png: "image/png"
    svg: "image/svgxml"
    svgz: "image/svgxml"
    tiff: "image/tiff"
    tif: "image/tiff"
    asc: "text/plain"
    txt: "text/plain"
    text: "text/plain"
    diff: "text/plain"
    log: "text/plain"
    htm: "text/html"
    html: "text/html"
    xhtml: "text/html"
    css: "text/css"
    csv: "text/csv"
    mpeg: "video/mpeg"
    mpg: "video/mpeg"
    mpe: "video/mpeg"
    rtf: "video/mpeg"
    mov: "video/quicktime"
    qt: "video/quicktime"
    mp4: "video/mp4"
    m4v: "video/x-m4v"
    flv: "video/x-flv"
    wmv: "video/x-ms-wmv"
    avi: "video/avi"
    webm: "video/webm"
    '3gp': "video/3gpp"
    '3gpp': "video/3gpp"
    '3g2': "video/3gpp2"
    rv: "video/vnd.rn-realvideo"
    ogv: "video/ogg"
    mkv: "video/x-matroska"
    otf: "application/vnd.oasis.opendocument.formula-template"
    exe: "application/octet-stream"
    p12: 'application/x-pkcs12'


  existsExtIcon: ($ext)->
    $extensions = ['3g2', '3gp', 'ai', 'air', 'asf', 'avi', 'bib', 'cls', 'csv', 'deb', 'djvu', 'dmg', 'doc', 'docx',
                   'dwf', 'dwg', 'eps', 'epub', 'exe', 'f', 'f77', 'f90', 'flac', 'flv', 'gz', 'indd',
                   'iso', 'log', 'm4a', 'm4v', 'midi', 'mkv', 'mov', 'mp3', 'mp4', 'mpeg', 'mpg', 'msi',
                   'odp', 'ods', 'odt', 'oga', 'ogg', 'ogv', 'pdf', 'pps', 'ppsx', 'ppt', 'pptx', 'psd', 'pub',
                   'py', 'qt', 'ra', 'ram', 'rar', 'rm', 'rpm', 'rtf', 'rv', 'skp', 'sql', 'sty', 'tar', 'tex', 'tgz',
                   'tiff', 'ttf', 'txt', 'vob', 'wav', 'wmv', 'xls', 'xlsx', 'xml', 'xpi', 'zip']
    Joker.Core.libSupport.inArray($ext , $extensions) != -1


  generateIconFor: (url)->
    return '' if (url == '')

    image = /.*\.(jpg|jpeg|png|gif|ico)+/gi

    bg  = "#{@iconBase}/outhers.png"
    ar  = url.split('.')
    ext = ar[ar.length-1]

    bg = url                       if image.test(url)
    bg = "#{@iconBase}/#{ext}.png" if @existsExtIcon(ext)

    """
    <div class="joker-icon">
	    <div class="file" style="background-image: url(#{bg});"></div>
	  </div>
    """

  generateInfoFor: (url)->
    return '' if (url == '')

    ar = url.split('/')
    filename = ar[ar.length-1]

    ar = url.split('.')
    ext = ar[ar.length-1]

    html = "<blockquote>" +
    "<p>#{Joker.I18n.translate('icon.filename')}:</p>" +
    "<small>"+filename+"</small>"
    if @getMimeType(ext)
      html += "<p>#{Joker.I18n.translate('icon.mimetype')}:</p>" +
      "<small>"+@getMimeType(ext)+"</small>"
    html += "</blockquote>"
    html

  getMimeType: (ext)->
    return @mimetypes[ext] if @mimetypes.hasOwnProperty(ext)
    false