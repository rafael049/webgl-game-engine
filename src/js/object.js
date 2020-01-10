// Generated by LiveScript 1.6.0
(function(){
  var GameObject;
  window.GameObject = GameObject = (function(){
    GameObject.displayName = 'GameObject';
    var prototype = GameObject.prototype, constructor = GameObject;
    function GameObject(gl){
      this.name = "no_name";
      this.gl = gl;
      this.pos = vec3.create();
      this.rot = vec3.create();
      this.sca = vec3.fromValues(1, 1, 1);
      this.vel = vec3.create();
      this.localMat = mat4.create();
      this.modelViewMat = mat4.create();
    }
    GameObject.prototype.render = function(viewMatrix, projectionMatrix){
      var modelMatrix, localMatrix;
      modelMatrix = mat4.create();
      mat4.translate(modelMatrix, modelMatrix, this.pos);
      localMatrix = mat4.create();
      mat4.scale(localMatrix, localMatrix, this.sca);
      mat4.rotateX(localMatrix, localMatrix, this.rot[0]);
      mat4.rotateY(localMatrix, localMatrix, this.rot[1]);
      mat4.rotateZ(localMatrix, localMatrix, this.rot[2]);
      this.gl.activeTexture(this.gl.TEXTURE0);
      this.texture.use();
      this.shader.setTexture(this.texture.id);
      this.shader.setProjection(projectionMatrix);
      this.shader.setView(viewMatrix);
      this.shader.setModel(modelMatrix);
      this.shader.setLocal(localMatrix);
      this.shader.use();
      return this.mesh.render(this.shader, this.texture);
    };
    GameObject.prototype.update = function(pos){
      console.log("Error: Game Object " + this.name + " do not implement update function!");
    };
    GameObject.prototype.setPosition = function(pos){
      this.pos = pos;
    };
    GameObject.prototype.setScale = function(scale){
      this.sca = scale;
    };
    GameObject.prototype.setRotationX = function(angle){
      this.rot[0] = angle;
    };
    GameObject.prototype.setRotationY = function(angle){
      this.rot[1] = angle;
    };
    GameObject.prototype.setRotationZ = function(angle){
      this.rot[2] = angle;
    };
    return GameObject;
  }());
}).call(this);
