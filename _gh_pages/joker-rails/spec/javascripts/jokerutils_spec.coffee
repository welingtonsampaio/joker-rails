#= require support/sinon-1.7.3
#= require joker
describe "JokerUtils", ->

  it "should be able of generate id uniques", ->
    for i in [1..20]
      expect(JokerUtils.uniqid()).to.not.equal( JokerUtils.uniqid() )

  it "should be able of converts a object to string, with method to_string", ->
    expect(JokerUtils.toString("asd")).to.be.a("String")
    expect(JokerUtils.toString({t:"sa"})).to.be.a("String")

  it "should be able to add an object to collection", ->
    expect( JokerUtils.addObject ).throw
    expect( JokerUtils.addObject({objectId:"1"}) ).to.be.ok

  it "should be able to add and then retrieve an object from the collection", ->
    JokerUtils.addObject({objectId:"1"})
    expect( JokerUtils.getObject ).throw
    expect( JokerUtils.getObject("1") ).not.throw
    expect( JokerUtils.getObject("1") ).to.be.an "object"

  it "should be able to remove an object from the collection", ->
    JokerUtils.addObject({objectId:"1"})
    expect( JokerUtils.removeObject("1") ).to.be.ok
    expect( JokerUtils.removeObject("1")).to.not.be.ok

  it "should be able to redirect the page to the url informed", ->
    spy = sinon.spy(JokerUtils, 'redirectTo')
    JokerUtils.redirectTo("http://google.com/")
    expect( spy.called ).to.be.true
    spy.restore()

  it "should check the string or object sent if the content is null or blank", ->
    expect( JokerUtils.isEmpty("sad") ).to.not.be.ok
    expect( JokerUtils.isEmpty(null) ).to.be.ok
    expect( JokerUtils.isEmpty(undefined) ).to.be.ok
    expect( JokerUtils.isEmpty("       ") ).to.be.ok

  it "should check if there is an element in the collection", ->
    JokerUtils.addObject({objectId:"1"})
    expect( JokerUtils.hasObject("test") ).to.not.be.ok
    expect( JokerUtils.hasObject("1") ).to.be.ok