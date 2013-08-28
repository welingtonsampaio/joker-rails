describe "Joker.Core", ->
  core = null

  beforeEach ->
    core = new Joker.Core()

  afterEach ->
    core.destroy() if core?

  it "should be able to verify the existence of the jQuery object", ->
    expect( core.verify_jquery() ).toBeTruthy()
    core.jQuery = null
    expect( core.verify_jquery ).toThrow()

  it "should at startup add the object to the collection JokerUtils", ->
    expect( JokerUtils.get_object(core.objectId) ).toBeTruthy()
    expect( JokerUtils.get_object(core.objectId) ).toEqual core

  it "should have a method to remove the object from the collection", ->
    id = core.id
    core.destroy()
    expect( JokerUtils.has_object(id) ).not.toBeTruthy()

  it "should be able to print debug messages", ->
    myConsole = jasmine.createSpyObj('console', ["log","warn","debug"])
    Joker.Debug.console = myConsole
    core.debug "Test"
    expect( myConsole.debug ).not.toHaveBeenCalled()
    core.settings.debug = true
    core.debug "Test"
    expect( myConsole.debug ).toHaveBeenCalled()
    Joker.Debug.console = window.console

  it "deve poder criar metodos setters e getters, em objetos extendidos", ->
    class Test extends Joker.Core
      @attr_accesor "test1",
        default: "bla"
        container: "attr"
      @attr_accesor "test2"
    window.test = new Test
    expect( test.test1 ).toEqual jasmine.any(Function)
    expect( test.test2 ).toEqual jasmine.any(Function)
    expect( test.test1() ).toEqual "bla"
    expect( test.test1("value 1") ).toEqual test.test1()
    expect( test.test2("value 2") ).toEqual test.test2()
    expect( test.test1() ).toEqual test.attr._test1
    expect( test.test2() ).toEqual test._test2
