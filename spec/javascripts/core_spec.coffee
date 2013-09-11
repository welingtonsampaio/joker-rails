#= require support/sinon-1.7.3
#= require joker
describe "Joker.Core", ->
  core = null

  beforeEach ->
    core = new Joker.Core()

  afterEach ->
    core.destroy() if core?

  it "should be able to verify the existence of the jQuery object", ->
    expect( core.verifyLibSupport() ).to.be.true
    core.jQuery = null
    expect( core.verifyLibSupport ).throw

  it "should at startup add the object to the collection JokerUtils", ->
    expect( JokerUtils.getObject(core.objectId) ).to.be.ok
    expect( JokerUtils.getObject(core.objectId) ).to.equal core

  it "should have a method to remove the object from the collection", ->
    id = core.id
    core.destroy()
    expect( JokerUtils.hasObject(id) ).to.be.false

  it "should be able to print debug messages", ->
    debug =
      debug: ->
#    Joker.Debug.console = debug
    spy = sinon.spy Joker.Debug.console, 'debug'
    core.debug "Test"
    console.log core.settings()
    expect( spy.called ).to.not.be.ok
    core.settings debug: true
    console.log core.settings()
    core.debug "Test"
    console.log core.settings()
    expect( spy.called ).to.be.true
    spy.restore()
