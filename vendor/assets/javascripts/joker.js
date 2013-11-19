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
 *= require joker/Modal
 *= require joker/Form
 *= require joker/RestDelete
 *= require joker/Typeahead
 *= require joker/KeyboardShortcut
 *= require_self
 */

window.Joker.bootstrap = function() {
  Joker.Render.getInstance();
  Joker.Form.getInstance();
  Joker.RestDelete.getInstance();
  Joker.Typeahead.getInstance();
  Joker.KeyboardShortcut.getInstance();
  Joker.Navigation.init();
};