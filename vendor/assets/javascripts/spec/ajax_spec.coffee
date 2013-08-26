describe "Joker.Ajax", ->

  beforeEach ->
    Joker.debug = true

  afterEach ->
    Joker.debug = false

  it "deve ser uma heranca de Core", ->
    expect( Joker.Ajax.__super__.name ).toEqual "Core"

  it "deve conseguir requisitar uma url imediatamente", ->
    complete = false
    success = ->
      complete = true
    new Joker.Ajax
      url: "/spec/content1.html"
      callbacks:
        success: success
    waitsFor ->
      complete
    , "Nao pode receber o content1.html com sucesso", 500

  it "deve conseguir requisitar uma url apos uma execucao", ->
    complete = false
    success = ->
      complete = true
    xhr = new Joker.Ajax
      url: "/spec/content1.html"
      autoExec: false
      callbacks:
        success: success
    setTimeout ->
      xhr.exec()
    , 250
    waitsFor ->
      complete
    , "Nao pode receber o content1.html com sucesso", 750

  it "deve conseguir requisitar uma url com erro, e chamar o callback de erro", ->
    complete = false
    error = ->
      complete = true
    xhr = new Joker.Ajax
      url: "/spec/not_found.html"
      callbacks:
        error: error
    waitsFor ->
      complete
    , "Nao pode receber o content1.html com sucesso", 500

