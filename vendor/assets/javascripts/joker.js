/**
 *= require jquery
 *= require_tree ./joker/support
 *= require joker/JokerUtils
 *= require joker/Debug
 *= require joker/Core
 *= require joker/Animation
 *= require joker/Alert
 *= require joker/Ajax
 *= require joker/Window
 *= require joker/Render
 *= require joker/Navigation
 *= require_self
 */

window.Joker.bootstrap = function() {
  Joker.Render.getInstance();
  Joker.Navigation.init();
};