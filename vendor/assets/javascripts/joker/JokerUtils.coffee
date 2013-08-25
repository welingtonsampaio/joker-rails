



class JokerUtils
  uniqidSeed: 1
  ###
  Generates a unique string for script execution.

  original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
  revised by: Kankrelune (http://www.webfaktory.info/)
  @example
    Lol.Utils.uniqid();            // a30285b160c14
    Lol.Utils.uniqid('foo');       // fooa30285b1cd361
    Lol.Utils.uniqid('bar', true); // bara20285b23dfd1.31879087
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
  ###
  add_bject: (obj)->
    @_object_id[obj.id] = obj
  ###
  Retrieves an object from the collection.
  ###
  get_object: (id)->
    @_object_id[id]
  ###
  Removes an object from the collection.
  ###
  remove_object: (id)->
    return false if @_object_id[id] == null
    @_object_id[id] = null
    @_object_id[id] == null
  ###
  Redirects the page to another url.
  ###
  redirect_to: (url)->
    window.location = url
  ###
  Verify empty state of an string. Including spaces
  @return {Boolean}
  ###
  is_empty: (pStrText)->
    newString = "";
    for char in pStrText
      if char != " "
        newString = newString + char
    newString.length <= 0