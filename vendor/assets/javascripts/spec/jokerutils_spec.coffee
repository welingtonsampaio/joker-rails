describe "JokerUtils", ->

  it "should be able of generate id uniques", ->
    for i in [1..20]
      expect(JokerUtils.uniqid()).not.toEqual(JokerUtils.uniqid())

  it "should be able of converts a object to string, with method to_string", ->
    expect(JokerUtils.toString("asd")).toEqual(jasmine.any(String))
    expect(JokerUtils.toString({t:"sa"})).toEqual(jasmine.any(String))

  it "should be able to add an object to collection", ->
    expect( JokerUtils.addObject ).toThrow()
    expect( JokerUtils.addObject({objectId:"1"}) ).toBeTruthy()

  it "should be able to add and then retrieve an object from the collection", ->
    JokerUtils.addObject({objectId:"1"})
    expect( JokerUtils.getObject ).toThrow()
    expect( JokerUtils.getObject("1") ).toBeTruthy()
    expect( JokerUtils.getObject("1") ).toEqual( jasmine.any(Object) )

  it "should be able to remove an object from the collection", ->
    JokerUtils.addObject({objectId:"1"})
    expect( JokerUtils.removeObject("1") ).toBeTruthy()
    expect( JokerUtils.removeObject("1")).not.toBeTruthy()

  it "should be able to redirect the page to the url informed", ->
    spyOn(JokerUtils, 'redirectTo').andCallFake ->
      true
    expect( JokerUtils.redirectTo("http://google.com/") ).toBeTruthy()

  it "should check the string or object sent if the content is null or blank", ->
    expect( JokerUtils.isEmpty("sad") ).not.toBeTruthy()
    expect( JokerUtils.isEmpty(null) ).toBeTruthy()
    expect( JokerUtils.isEmpty(undefined) ).toBeTruthy()
    expect( JokerUtils.isEmpty("       ") ).toBeTruthy()

  it "should check if there is an element in the collection", ->
    JokerUtils.addObject({objectId:"1"})
    expect( JokerUtils.hasObject("test") ).not.toBeTruthy()
    expect( JokerUtils.hasObject("1") ).toBeTruthy()