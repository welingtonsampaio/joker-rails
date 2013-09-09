#= require support/sinon-1.7.3
#= require joker

describe "Joker.Ajax", ->

  beforeEach ->
    Joker.debug = true

  afterEach ->
    Joker.debug = false

  it "deve ser uma heranca de Core", ->
    expect( Joker.Ajax.__super__.name ).to.equal "Core"

  it "deve conseguir requisitar uma url imediatamente", ->
    sinon.stub Joker.Core.jQuery, 'ajax'
    new Joker.Ajax
      url: "/spec/content1.html"
    expect(Joker.Core.jQuery.ajax.calledOnce).to.be.true
    Joker.Core.jQuery.ajax.restore()

  it "deve conseguir requisitar uma url apos uma execucao", ->
    sinon.stub Joker.Core.jQuery, 'ajax'
    xhr = new Joker.Ajax
      url: "/spec/content1.html"
      autoExec: false
    xhr.exec()
    expect(Joker.Core.jQuery.ajax.calledOnce).to.be.true
    Joker.Core.jQuery.ajax.restore()

  it "deve conseguir requisitar uma url com erro, e chamar o callback de erro", (done)->
    error =
      er: ->
        done()
    new Joker.Ajax
      url: "/spec/not_found.html"
      callbacks:
        error: error.er

