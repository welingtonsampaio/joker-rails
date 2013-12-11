#= require support/sinon-1.7.3
#= require joker
#= require support/css

describe "Joker.Alert", ->

  beforeEach ->
    Joker.Core.libSupport('body').empty()
    Joker.Alert.alertContainer = undefined

  it "deve ser uma heranca de Core", ->
    expect( Joker.Alert.__super__.accessor('className') ).to.equal "Joker_Core"

  it "deve poder um alerta passando apenas uma string", (done)->
    alert = new Joker.Alert "My first Alert notice"
    expect( document.getElementById(alert.objectId) ).to.be.ok
    setTimeout(done, 500)

  it "deve poder um alerta do tipo Erro", (done)->
    alert = new Joker.Alert
      message: "My error alert notice"
      type: Joker.Alert.TYPE_ERROR
    expect( document.getElementById(alert.objectId) ).to.be.ok
    expect( alert.alertWindow.hasClass(Joker.Alert.TYPE_ERROR)).to.be.true
    setTimeout(done, 500)

  it "deve poder um alerta do tipo Sucesso", (done)->
    alert = new Joker.Alert
      message: "My error alert notice"
      type: Joker.Alert.TYPE_SUCCESS
    expect( document.getElementById(alert.objectId) ).to.be.ok
    expect( alert.alertWindow.hasClass(Joker.Alert.TYPE_SUCCESS)).to.be.true
    setTimeout(done, 500)

  it "deve poder um alerta do tipo Info", (done)->
    alert = new Joker.Alert
      message: "My error alert notice"
      type: Joker.Alert.TYPE_INFO
    expect( document.getElementById(alert.objectId) ).to.be.ok
    expect( alert.alertWindow.hasClass(Joker.Alert.TYPE_INFO)).to.be.true
    setTimeout(done, 500)


  it "deve poder um alerta do tipo Waning", (done)->
    alert = new Joker.Alert
      message: "My error alert notice"
      type: Joker.Alert.TYPE_WANING
    expect( document.getElementById(alert.objectId) ).to.be.ok
    setTimeout(done, 500)

  it "deve poder remover um alerta apos o tempo de delay", (done)->
    alert = new Joker.Alert
      message: "My error alert notice"
      type: Joker.Alert.TYPE_WANING
      delayTime: 10

    setTimeout(->
      expect( document.getElementById(alert.objectId) ).to.not.be.ok
      done()
    , 1200)

