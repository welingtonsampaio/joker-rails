describe "Joker.Debug", ->

  afterEach ->
    Joker.debug = false
    Joker.Debug.console = window.console

  it "should have an attribute that contains the default parameters for debug", ->
    expect( Joker.Debug.paramsDefault ).toEqual( jasmine.any(Object) )

  it "should print to the console the message sent", ->
    myConsole = jasmine.createSpyObj('console', ["log","warn","debug"])
    Joker.Debug.console = myConsole
    Joker.Debug.print {}
    expect( myConsole.debug ).not.toHaveBeenCalled()
    Joker.Debug.print {debug:true}
    expect( myConsole.debug ).toHaveBeenCalled()
    Joker.debug = true
    Joker.Debug.print {index:2}
    expect( myConsole.debug ).toHaveBeenCalledWith(["Joker_Debug  - 2"])