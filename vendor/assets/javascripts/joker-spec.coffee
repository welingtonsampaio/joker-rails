#= require jasmine/jasmine
#= require jasmine/jasmine-html
#= require_tree ./spec
#= require_self

jasmineInit = ->
  document.body.innerHTML = ''

  link = document.createElement('link')
  link.setAttribute('href',"/assets/jasmine.css")
  link.setAttribute('rel', 'stylesheet')
  link.setAttribute('type', 'text/css')
  $('head').append link

  container = document.createElement('div')
  container.setAttribute('id', 'spec_container')
  container.style.display = "block"
  container.style.visibility = "hidden"
  container.style.position = "absolute"
  container.style.zIndex = 1
  $('body').append container

  jasmineEnv = jasmine.getEnv()
  jasmineEnv.updateInterval = 1000

  htmlReporter = new jasmine.HtmlReporter()

  jasmineEnv.addReporter(htmlReporter)

  jasmineEnv.specFilter = (spec)->
    htmlReporter.specFilter(spec)

  currentWindowOnload = window.onload

  window.onload = ->
    currentWindowOnload() if (currentWindowOnload)

  execJasmine = ->
    jasmineEnv.execute()

  execJasmine()

#  setTimeout( ->
#    $('body > *').not('.jasmine_reporter').remove()
#  , 500)

jQuery ->
  setTimeout jasmineInit, 100
