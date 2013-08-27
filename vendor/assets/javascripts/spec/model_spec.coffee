describe "Joker.Model", ->

  beforeEach ->
    Joker.debug = yes

  afterEach ->
    Joker.debug = no

  it "deve ser uma heranca de Joker.Core", ->
    expect( Joker.Model.__super__.name ).toEqual "Core"

  describe "User Model Example - support", ->
    user = null

    beforeEach ->
      user = new User

    it "deve ter", ->



