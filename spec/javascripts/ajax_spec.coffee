#= require support/sinon-1.7.3
#= require joker

describe "Joker.Ajax", ->

  it "deve ser uma heranca de Core", ->
    expect( Joker.Ajax.__super__.accessor('className') ).to.equal "Joker_Core"

  it "deve conseguir requisitar uma url imediatamente", ->
    sinon.stub Joker.Core.libSupport, 'ajax'
    new Joker.Ajax
      url: "/spec/content1.html"
    expect(Joker.Core.libSupport.ajax.calledOnce).to.be.true
    Joker.Core.libSupport.ajax.restore()

  it "deve conseguir requisitar uma url apos uma execucao", ->
    sinon.stub Joker.Core.libSupport, 'ajax'
    xhr = new Joker.Ajax
      url: "/spec/content1.html"
      autoExec: false
    xhr.exec()
    expect(Joker.Core.libSupport.ajax.calledOnce).to.be.true
    Joker.Core.libSupport.ajax.restore()

  it "deve conseguir requisitar uma url com erro, e chamar o callback de erro", (done)->
    error = ->
      done()
    new Joker.Ajax
      url: "/spec/not_found.html"
      callbacks:
        error: error

