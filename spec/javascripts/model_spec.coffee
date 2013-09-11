#= require support/sinon-1.7.3
#= require joker
#= require support/user_model

describe "Joker.Model", ->

  beforeEach ->
    Joker.debug = yes

  afterEach ->
    Joker.debug = no

  it "deve ser uma heranca de Joker.Core", ->
    expect( Joker.Model.$super.className ).to.equal "Joker_Core"

  describe "User Model Example - support", ->
    user = null

    beforeEach ->
      user = new User

    it "deve poder requisitar uma lista de usuarios", ->
      u = User.all()


    xit "deve poder requisitar um usuario atraves do ID", ->




