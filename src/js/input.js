// Generated by LiveScript 1.6.0
(function(){
  var Input;
  window.Input = Input = (function(){
    Input.displayName = 'Input';
    var prototype = Input.prototype, constructor = Input;
    Input.keys = [];
    Input._keys = [];
    Input.keysTap = [];
    function Input(){
      window.addEventListener('keydown', this.keydownCallback);
      window.addEventListener('keyup', this.keyupCallback);
    }
    Input.prototype.keydownCallback = function(e){
      if (!e.repeat) {
        constructor._keys[e.keyCode] = true;
        constructor.keys[e.keyCode] = true;
        return console.log("Keydown");
      }
    };
    Input.prototype.keyupCallback = function(e){
      return constructor.keys[e.keyCode] = false;
    };
    Input.onKeydown = function(key){
      if (constructor._keys[key]) {
        constructor._keys[key] = false;
        return true;
      }
    };
    return Input;
  }());
}).call(this);
