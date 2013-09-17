#= require support/sinon-1.7.3
#= require joker
#= require support/address_model
#= require support/user_model
describe "Joker.ActiveResource", ->



  it "deve ser uma herenca de Joker.Core", ->
    expect( Joker.ActiveResource.__super__.accessor("className") ).to.equal "Joker_Core"

  it "deve poder configurar"