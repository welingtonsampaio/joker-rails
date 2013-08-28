describe "JokerUtils", ->

  it "should be able of generate id uniques", ->
    for i in [1..20]
      expect(JokerUtils.uniqid()).not.toEqual(JokerUtils.uniqid())

  it "should be able of converts a object to string, with method to_string", ->
    expect(JokerUtils.to_string("asd")).toEqual(jasmine.any(String))
    expect(JokerUtils.to_string({t:"sa"})).toEqual(jasmine.any(String))

  it "should be able to add an object to collection", ->
    expect( JokerUtils.add_object ).toThrow()
    expect( JokerUtils.add_object({objectId:"1"}) ).toBeTruthy()

  it "should be able to add and then retrieve an object from the collection", ->
    JokerUtils.add_object({objectId:"1"})
    expect( JokerUtils.get_object ).toThrow()
    expect( JokerUtils.get_object("1") ).toBeTruthy()
    expect( JokerUtils.get_object("1") ).toEqual( jasmine.any(Object) )

  it "should be able to remove an object from the collection", ->
    JokerUtils.add_object({objectId:"1"})
    expect( JokerUtils.remove_object("1") ).toBeTruthy()
    expect( JokerUtils.remove_object("1")).not.toBeTruthy()

  it "should be able to redirect the page to the url informed", ->
    spyOn(JokerUtils, 'redirect_to').andCallFake ->
      true
    expect( JokerUtils.redirect_to("http://google.com/") ).toBeTruthy()

  it "should check the string or object sent if the content is null or blank", ->
    expect( JokerUtils.is_empty("sad") ).not.toBeTruthy()
    expect( JokerUtils.is_empty(null) ).toBeTruthy()
    expect( JokerUtils.is_empty(undefined) ).toBeTruthy()
    expect( JokerUtils.is_empty("       ") ).toBeTruthy()

  it "should check if there is an element in the collection", ->
    JokerUtils.add_object({objectId:"1"})
    expect( JokerUtils.has_object("test") ).not.toBeTruthy()
    expect( JokerUtils.has_object("1") ).toBeTruthy()