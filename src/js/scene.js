// Generated by LiveScript 1.6.0
(function(){
  var Scene;
  window.Scene = Scene = (function(){
    Scene.displayName = 'Scene';
    var prototype = Scene.prototype, constructor = Scene;
    function Scene(gl){
      this.gl = gl;
      this.objects = new LinkedList();
      this.objects.add(new Xaropinho(gl, [-6.0, 1.0, -6.0]));
      this.objects.add(new Xaropinho(gl, [6.0, 1.0, -6.0]));
      this.objects.add(new Xaropinho(gl, [6.0, 1.0, 6.0]));
      this.objects.add(new Xaropinho(gl, [-8.0, 1.0, -6.0]));
      this.cenario = new Cenario(gl);
      this.player = new Player([0.0, 1.0, 0.0]);
      this.input = new Input;
      this.camera = new Camera(this.gl, [0.0, 1.0, 0.0], this.player);
      this.camera.pos = [0.0, 0.0, 0.0];
      this.audio = new AudioManager;
      this.skybox = new Skybox(this.gl);
      this.hud = new HUD(gl);
      this.gl.clearColor(0.0, 0.1, 0.1, 1.0);
      this.gl.clearDepth(1.0);
      this.gl.enable(this.gl.DEPTH_TEST);
      this.gl.depthFunc(this.gl.LEQUAL);
    }
    Scene.prototype.render = function(){
      var projectionMatrix, viewMatrix;
      this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
      projectionMatrix = this.camera.getProjectionMatrix();
      viewMatrix = this.camera.getViewMatrix();
      this.cenario.render(viewMatrix, projectionMatrix);
      this.objects.each(function(obj, l){
        return obj.data.render(viewMatrix, projectionMatrix);
      });
      this.skybox.render(viewMatrix, projectionMatrix);
      this.hud.render(viewMatrix);
    };
    Scene.prototype.update = function(){
      var current;
      this.camera.update();
      this.player.update(1.0);
      Collision.check(this.objects.toArray(), this.player);
      current = this.objects.head;
      while (current !== null) {
        current.data.update();
        if (current.data.trash) {
          if (current === this.objects.head) {
            if (current.next === current.prev) {
              this.objects.head = null;
              current.next = null;
            } else {
              this.objects.head = current.next;
              current.prev.next = current.next;
              current.next.prev = current.prev;
            }
          } else {
            current.prev.next = current.next;
            current.next.prev = current.prev;
          }
        }
        current = current.next;
        if (current === this.objects.head) {
          current = null;
        }
      }
      this.hud.update();
    };
    return Scene;
  }());
}).call(this);
