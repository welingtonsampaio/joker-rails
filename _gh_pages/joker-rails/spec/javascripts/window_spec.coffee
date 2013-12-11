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
    myWindow.destroy()

  it "deve poder criar mais de uma janela, e navegar entre elas", ->
    myWindow1 = new Joker.Window
      content: "Teste de conteudo 1"
      title: "Window 1"
    myWindow2 = new Joker.Window
      content: "Teste de conteudo 2"
      title: "Window 2"
    el1 = document.getElementById( myWindow1.objectId )
    el2 = document.getElementById( myWindow2.objectId )
    expect( el1 ).to.be.ok
    expect( el2 ).to.be.ok
    expect( el1.style.zIndex ).to.be.equal Joker.Window.defaultIndex.toString()
    expect( el2.style.zIndex ).to.be.equal (Joker.Window.defaultIndex + 1).toString()
    myWindow1.container.click()
    expect( el2.style.zIndex ).to.be.equal Joker.Window.defaultIndex.toString()
    expect( el1.style.zIndex ).to.be.equal (Joker.Window.defaultIndex + 1).toString()
    myWindow1.destroy()
    myWindow2.destroy()

  it "deve excluir o element da colecao e recolocar os indexes apos a chamada destroy", ->
    myWindow1 = new Joker.Window
      content: "Teste de conteudo 1"
      title: "Window 1"
    myWindow2 = new Joker.Window
      content: "Teste de conteudo 2"
      title: "Window 2"
    el2 = document.getElementById( myWindow2.objectId )
    myWindow1.destroy()
    expect( el2.style.zIndex ).to.be.equal Joker.Window.defaultIndex.toString()

  it "deve poder mover a janela utilizando o arastar do mouse", ->
    myWindow1 = new Joker.Window
      content: "Teste de conteudo 1"
      title: "Window 1"
    left = myWindow1.container[0].offsetLeft
    top  = myWindow1.container[0].offsetTop
    myWindow1.startDrag({clientX:left+5,clientY:top+5})
    myWindow1.moveContainer({clientX:left+55,clientY:top+55})
    myWindow1.stopDrag()
    expect( left ).to.be.below myWindow1.container[0].offsetLeft
    expect( top  ).to.be.below myWindow1.container[0].offsetTop


