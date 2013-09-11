#= require support/sinon-1.7.3
#= require joker

describe "Joker.Ajax", ->

  beforeEach ->
    Joker.debug = false

  afterEach ->
    Joker.debug = false

  it "deve ser uma heranca de Core", ->
    expect( Joker.Ajax.$super.className ).to.equal "Joker_Core"

  it "deve conseguir requisitar uma url imediatamente", ->
    sinon.stub Joker.Core.libSupport, 'ajax'
    new Joker.Ajax
      url: "/assets/support/content1.html"
    expect(Joker.Core.libSupport.ajax.called).to.be.true
    Joker.Core.libSupport.ajax.restore()

  it "deve conseguir requisitar uma url apos uma execucao", ->
    lib = sinon.spy Joker.Core.libSupport, 'ajax'
    xhr = new Joker.Ajax
      url: "/assets/support/content1.html"
      autoExec: false
    xhr.exec()
    expect(lib.called).to.be.true
    lib.restore()

  it "deve conseguir requisitar uma url com erro, e chamar o callback de erro", (done)->
    error = ->
      console.log "asd"
      done()
    xhr = new Joker.Ajax
      url: "/spec/not_found.html"
      callbacks:
        error: error
