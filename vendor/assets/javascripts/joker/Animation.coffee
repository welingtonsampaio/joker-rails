###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Animation.js
@author      Welington Sampaio (http://welington.zaez.net/)
@contact     http://jokerjs.zaez.net/contato

@copyright Copyright 2013 Zaez Solucoes em Tecnologia, all rights reserved.

This source file is free software, under the license MIT, available at:
http://jokerjs.zaez.net/license

This source file is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.

For details please refer to: http://jokerjs.zaez.net
###

###
Responsavel pelas animacoes em css afetuadas nos DOMElements

@classDescription This class creates a new Animation.
@returns Animation Returns a new Animation.
@type    Object
###
class Joker.Animation extends Joker.Core

  ###
  Colecao de elementos que receberao os efeitos
  em ordem
  @type Array
  ###
  animations: undefined


  constructor: (data)->
    super
    @animations = []
    @appendAllAnimations(data) if Object.isArray data
    @appendAnimation(data)     if Object.isObject data
    @createAllAnimations()

  ###
  Metodo responsável por
  ###
  appendAllAnimations: (datas)->
    datas.each (data)=>
      @appendAnimation data

  appendAnimation: (data)->
    data = @libSupport.extend true, {}, @accessor("defaultData"), data
    @debug "Realizando o append da animacao para o objeto: ", data
    throw "Eh preciso informar o container" unless data.target?
    @animations.push data

  createAllAnimations: ->
    @animations.each (animation,indice)=>
      @createAnimation(@libSupport(animation.target), animation, indice)

  createAnimation: (element, data, indice)->
    @debug "Disparando o event de enter animation"
    element.removeClass("animated animate#{indice} #{data.leaveEffect}")
           .addClass(   "animated animate#{indice} #{data.enterEffect}")
    if data.autoLeave
      setTimeout( =>
        @debug "Disparando o event de leave animation"
        element.removeClass("animated animate#{indice} #{data.enterEffect}")
               .addClass(   "animated animate#{indice} #{data.leaveEffect}")
      , data.delayTime)




  @debugPrefix: "Joker_Animation"
  @className  : "Joker_Animation"

  @FX_FLASH              : "flash"
  @FX_SHAKE              : "shake"
  @FX_BOUNCE             : "bounce"
  @FX_TADA               : "tada"
  @FX_SWING              : "swing"
  @FX_WOBBLE             : "wobble"
  @FX_PULSE              : "pulse"
  @FX_FLIP               : "flip"
  @FX_FLIPINX            : "flipInX"
  @FX_FLIPOUTX           : "flipOutX"
  @FX_FLIPINY            : "flipInY"
  @FX_FLIPOUTY           : "flipOutY"
  @FX_FADEIN             : "fadeIn"
  @FX_FADEINUP           : "fadeInUp"
  @FX_FADEINDOWN         : "fadeInDown"
  @FX_FADEINLEFT         : "fadeInLeft"
  @FX_FADEINRIGHT        : "fadeInRight"
  @FX_FADEINBIG          : "fadeInBig"
  @FX_FADEINUPBIG        : "fadeInUpBig"
  @FX_FADEINDOWNBIG      : "fadeInDownBig"
  @FX_FADEINLEFTBIG      : "fadeInLeftBig"
  @FX_FADEINRIGHTBIG     : "fadeInRightBig"
  @FX_FADEOUT            : "fadeOut"
  @FX_FADEOUTUP          : "fadeOutUp"
  @FX_FADEOUTDOWN        : "fadeOutDown"
  @FX_FADEOUTLEFT        : "fadeOutLeft"
  @FX_FADEOUTRIGHT       : "fadeOutRight"
  @FX_FADEOUTBIG         : "fadeOutBig"
  @FX_FADEOUTUPBIG       : "fadeOutUpBig"
  @FX_FADEOUTDOWNBIG     : "fadeOutDownBig"
  @FX_FADEOUTLEFTBIG     : "fadeOutLeftBig"
  @FX_FADEOUTRIGHTBIG    : "fadeOutRightBig"
  @FX_BOUNCEIN           : "bounceIn"
  @FX_BOUNCEINUP         : "bounceInUp"
  @FX_BOUNCEINDOWN       : "bounceInDown"
  @FX_BOUNCEINLEFT       : "bounceInLeft"
  @FX_BOUNCEINRIGHT      : "bounceInRight"
  @FX_BOUNCEOUT          : "bounceOut"
  @FX_BOUNCEOUTUP        : "bounceOutUp"
  @FX_BOUNCEOUTDOWN      : "bounceOutDown"
  @FX_BOUNCEOUTLEFT      : "bounceOutLeft"
  @FX_BOUNCEOUTRIGHT     : "bounceOutRight"
  @FX_ROTATEIN           : "rotateIn"
  @FX_ROTATEINUPLEFT     : "rotateInUpLeft"
  @FX_ROTATEINDOWNLEFT   : "rotateInDownLeft"
  @FX_ROTATEINUPRIGHT    : "rotateInUpRight"
  @FX_ROTATEINDOWNRIGHT  : "rotateInDownRight"
  @FX_ROTATEOUT          : "rotateOut"
  @FX_ROTATEOUTUPLEFT    : "rotateOutUpLeft"
  @FX_ROTATEOUTDOWNLEFT  : "rotateOutDownLeft"
  @FX_ROTATEOUTUPRIGHT   : "rotateOutUpRight"
  @FX_ROTATEOUTDOWNRIGHT : "rotateOutDownRight"
  @FX_HINGE              : "hinge"
  @FX_ROLLIN             : "rollIn"
  @FX_ROLLOUT            : "rollOut"
  @FX_LIGHTSPEEDIN       : "lightSpeedIn"
  @FX_LIGHTSPEEDOUT      : "lightSpeedOut"
  @FX_WIGGLE             : "wiggle"

  @defaultData:
    target     : undefined
    enterEffect: Animation.FX_FADEIN
    autoLeave  : false
    delayTime  : 7000
    leaveEffect: Animation.FX_FADEOUT
