// Generated by LiveScript 1.6.0
(function(){
  var teste, Game;
  teste = "oi";
  window.Game = Game = (function(){
    Game.displayName = 'Game';
    var prototype = Game.prototype, constructor = Game;
    function Game(){
      this.canvas = document.getElementById("canvas");
      this.screenWidth = canvas.width;
      this.screenHeight = canvas.height;
      this.gl = canvas.getContext("webgl2");
      this.gl.viewportWidth = canvas.width;
      this.gl.viewportHeight = canvas.height;
    }
    Game.prototype.start = function(){
      return this.scene1 = new Scene(this.gl);
    };
    Game.prototype.render = function(){
      this.scene1.render();
    };
    Game.prototype.update = function(){
      return this.scene1.update();
    };
    return Game;
  }());
}).call(this);
