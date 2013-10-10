#= require support/sinon-1.7.3
#= require joker
#= require support/css

describe "Joker.Window", ->

  before ->
    Joker.Core.libSupport('body').empty()

  it "deve ser uma heranca de Core", ->
    expect( Joker.Window.__super__.accessor('className') ).to.equal "Joker_Core"

  it "deve poder criar uma janela, com titulo e conteudo", ->
    myWindow = new Joker.Window
      content: "Teste de conteudo"
      title: "Window 1"
    expect( document.getElementById( myWindow.objectId ) ).to.be.ok


