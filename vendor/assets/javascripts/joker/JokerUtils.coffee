###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        JokerUtils.js
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

(global ? window).JokerUtils =
  uniqidSeed: 1
  ###
  Generates a unique string for script execution.

  original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  revised by: Kankrelune (http://www.webfaktory.info/)
  @example
    JokerUtils.uniqid();            // a30285b160c14
    JokerUtils.uniqid('foo');       // fooa30285b1cd361
    JokerUtils.uniqid('bar', true); // bara20285b23dfd1.31879087
  @return {String}
  ###
  uniqid: (prefix='', more_entropy)->
    formatSeed = (seed, reqWidth)->
      seed = parseInt(seed, 10).toString(16)
      return seed.slice(seed.length - reqWidth) if reqWidth < seed.length
      return Array(1 + (reqWidth - seed.length)).join('0') + seed if reqWidth > seed.length
      seed

    @uniqidSeed = Math.floor(Math.random() * 0x75bcd15) if not @uniqidSeed
    @uniqidSeed++

    retId = prefix
    retId += formatSeed(parseInt(new Date().getTime() / 1000, 10), 8)
    retId += formatSeed(@uniqidSeed, 5)
    retId += (Math.random() * 10).toFixed(8).toString() if more_entropy
    retId

  ###
  Convert to string
  @param {Mixin} obj
  @return {String}
  ###
  to_string: (obj)->
    new String(obj)

  # Add references objects
  # @example :
  #  {
  #    "12asd5a12": Joker.Core,
  #    "23sa1d5as": Joker.UrlParser
  #  }
  _object_id: {}

  ###
  Adds an object to the collection Lol.
  @param {Object} obj
  @return {Object}
  ###
  add_object: (obj)->
    throw "This object does not have the id attribute" unless obj.hasOwnProperty("objectId")
    @_object_id[obj.objectId] = obj
    obj

  ###
  Retrieves an object from the collection.
  @param {String} id
  @return {Object}
  ###
  get_object: (id)->
    throw "This id does not belong to collection" unless @has_object(id)
    @_object_id[id]

  ###
  Checks if the specified id is present in
  the collection of objects
  @param {String} id
  @return {Boolean}
  ###
  has_object: (id)->
    @_object_id.hasOwnProperty(id)

  ###
  Removes an object from the collection.
  @param {String} id
  @return {Boolean}
  ###
  remove_object: (id)->
    return false unless @has_object(id)
    @_object_id[id] = null
    delete @_object_id[id]
    not @_object_id.hasOwnProperty(id)

  ###
  Redirects the page to another url.
  @param {String} url
  ###
  redirect_to: (url)->
    window.location = url

  ###
  Verify empty state of an string. Including spaces
  @param {String | Mixin} pStrText
  @return {Boolean}
  ###
  is_empty: (pStrText)->
    return true if pStrText == null or pStrText == undefined
    newString = ""
    for char in pStrText
      if char != " "
        newString = newString + char
    newString.length <= 0