// Generated by LiveScript 1.6.0
(function(){
  var Scene;
  window.Scene = Scene = (function(){
    Scene.displayName = 'Scene';
    var prototype = Scene.prototype, constructor = Scene;
    function Scene(gl){
      this.gl = gl;
      this.objects = [];
      this.objects.push(new Xaropinho(gl, [-6.0, 0.0, -6.0]));
      this.objects.push(new Explosion(gl, [6.0, 0.0, -6.0]));
      this.objects.push(new Cenario(gl));
      this.player = new Player([0.0, 0.0, 0.0]);
      this.input = new Input;
      this.camera = new Camera(this.gl, [0.0, 2.0, 0.0], this.player);
      this.camera.pos = [0.0, 2.0, 12.0];
      this.audio = new AudioManager;
      this.skybox = new Skybox(this.gl);
      this.hud = new HUD(gl);
      this.gl.clearColor(0.0, 0.1, 0.1, 1.0);
      this.gl.clearDepth(1.0);
      this.gl.enable(this.gl.DEPTH_TEST);
      this.gl.depthFunc(this.gl.LEQUAL);
    }
    Scene.prototype.render = function(){
      var projectionMatrix, viewMatrix, i$, ref$, len$, obj;
      this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
      projectionMatrix = this.camera.getProjectionMatrix();
      viewMatrix = this.camera.getViewMatrix();
      for (i$ = 0, len$ = (ref$ = this.objects).length; i$ < len$; ++i$) {
        obj = ref$[i$];
        obj.render(viewMatrix, projectionMatrix);
      }
      this.skybox.render(viewMatrix, projectionMatrix);
      this.hud.render(viewMatrix);
    };
    Scene.prototype.update = function(){
      var i$, ref$, len$, obj;
      this.camera.update();
      this.player.update(1.0);
      Collision.check(this.objects, this.player);
      for (i$ = 0, len$ = (ref$ = this.objects).length; i$ < len$; ++i$) {
        obj = ref$[i$];
        obj.update();
      }
      if (Input.keys[32]) {
        AudioManager.playSound("rapaiz.mp3");
      }
      this.hud.update();
    };
    return Scene;
  }());
}).call(this);
