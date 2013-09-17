#= require support/sinon-1.7.3
#= require joker

describe "Joker.Model", ->

  beforeEach ->
    Joker.debug = yes

  afterEach ->
    Joker.debug = no

  it "deve ser uma heranca de Joker.Core", ->
    expect( Joker.Model.__super__.name ).to.equal "Core"

  describe "User Model Example - support", ->
    user = null

    beforeEach ->
      user = new User

    xit "deve poder requisitar uma lista de usuarios", ->
      u = User.all().exec()


    xit "deve poder requisitar um usuario atraves do ID", ->




