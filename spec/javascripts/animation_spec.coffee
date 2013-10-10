#= require support/sinon-1.7.3
#= require joker
#= require support/css

describe "Joker.Animation", ->

  object_1 = """
             <div style="width:200px;height:200px;background:red;" />
             """
  object_2 = """
             <div style="width:200px;height:200px;background:blue;" />
             """

  before ->
    Joker.Core.libSupport('body').empty()

  it "deve ser uma heranca de Core", ->
    expect( Joker.Animation.__super__.accessor('className') ).to.equal "Joker_Core"

  it "deve ter uma configuração padrão para elementos setados", ->
    expect( Joker.Animation.defaultData).to.be.an "object"
    for key, valeu in Joker.Animation.defaultData
      expect( value ).to.be.ok if key != 'target'

  it "deve poder setar uma configuração informando apenas o target do objeto", ->
    obj1 = Joker.Core.libSupport( object_1 )
    Joker.Core.libSupport('body').append obj1
    new Joker.Animation
      target: obj1
    expect( obj1.hasClass 'fadeIn' ).to.be.true

  it "dev poder setar mais de um objeto para animacão", (done)->
    obj1 = Joker.Core.libSupport( object_1 )
    obj2 = Joker.Core.libSupport( object_2 )
    Joker.Core.libSupport('body').append obj1
    Joker.Core.libSupport('body').append obj2
    new Joker.Animation [
      {
        target: obj1
      },
      {
        target: obj2
      }
    ]
    expect( obj1.hasClass 'fadeIn' ).to.be.true
    expect( obj2.hasClass 'fadeIn' ).to.be.true
    setTimeout(done, 600)

  it "deve poder executar efeito de saida apos um tempo determinado", (done)->
    obj1 = Joker.Core.libSupport( object_1 )
    Joker.Core.libSupport('body').append obj1
    new Joker.Animation
      target   : obj1
      delayTime: 700
      autoLeave: true
    expect( obj1.hasClass 'fadeIn' ).to.be.true
    setTimeout( ->
      expect( obj1.hasClass 'fadeOut' ).to.be.true
      done()
    , 800)

  it "deve poder modificar o efeito de entrada e de saida do objeto", (done)->
    obj1 = Joker.Core.libSupport( object_1 )
    Joker.Core.libSupport('body').append obj1
    new Joker.Animation
      target   : obj1
      delayTime: 700
      autoLeave: true
      enterEffect: Joker.Animation.FX_FLIPINY
      leaveEffect: Joker.Animation.FX_FLIPOUTX
    expect( obj1.hasClass 'flipInY' ).to.be.true
    setTimeout( ->
      expect( obj1.hasClass 'flipOutX' ).to.be.true
      done()
    , 800)


