#= require support/sinon-1.7.3
#= require joker
describe "Joker.Debug", ->

  afterEach ->
    Joker.debug = false
    Joker.Debug.console = window.console

  it "should have an attribute that contains the default parameters for debug", ->
    expect( Joker.Debug.paramsDefault ).to.be.an( "Object" )

  it "should print to the console the message sent", ->
    myConsole = sinon.spy(window.console, "debug")
    Joker.Debug.print {}
    expect( myConsole.called ).to.be.false
    Joker.Debug.print {debug:true}
    expect( myConsole.calledOnce ).to.be.true
    Joker.debug = true
    Joker.Debug.print {index:2}
    expect( myConsole.calledWith(["Joker_Debug  - 2"]) ).to.be.true
    myConsole.restore()