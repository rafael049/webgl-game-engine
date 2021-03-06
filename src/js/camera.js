// Generated by LiveScript 1.6.0
(function(){
  var Camera;
  window.Camera = Camera = (function(){
    Camera.displayName = 'Camera';
    var prototype = Camera.prototype, constructor = Camera;
    function Camera(gl, pos, parent){
      pos == null && (pos = vec3.create());
      parent == null && (parent = void 8);
      this.gl = gl;
      this.pos = pos;
      this.parent = parent;
      this.offset = [0.0, 1.0, 0.0];
      this.front = vec3.create();
      this.up = vec3.create();
      this.right = vec3.create();
      this.worldUp = vec3.fromValues(0.0, 1.0, 0.0);
      this.yaw = -90.0;
      this.pitch = 0.0;
      this.movSpeed = 0.1;
      this.sensivity = 1.5;
      this.fov = 35.0;
      this.znear = 0.1;
      this.zfar = 1000.0;
      this.aspect = this.gl.viewportWidth / this.gl.viewportHeight;
      this.setupVectors();
    }
    Camera.prototype.update = function(){
      this.setupVectors();
      if (this.parent) {
        vec3.add(this.pos, this.parent.pos, this.offset);
      }
      if (Input.keys[75]) {
        this.pitch += this.sensivity;
      }
      if (Input.keys[74]) {
        this.pitch -= this.sensivity;
      }
      if (Input.keys[76]) {
        this.yaw += this.sensivity;
      }
      if (Input.keys[72]) {
        this.yaw -= this.sensivity;
      }
      if (!Input.keys[16]) {
        this.pitch -= Input.mouseMove[1] * this.sensivity / 20;
        this.yaw += Input.mouseMove[0] * this.sensivity / 20;
      }
      if (!this.parent) {
        if (Input.keys[87]) {
          vec3.add(this.pos, this.pos, vec3.scale([], this.front, this.movSpeed));
        }
        if (Input.keys[83]) {
          vec3.add(this.pos, this.pos, vec3.scale([], this.front, -this.movSpeed));
        }
        if (Input.keys[68]) {
          vec3.add(this.pos, this.pos, vec3.scale([], this.right, this.movSpeed));
        }
        if (Input.keys[65]) {
          vec3.add(this.pos, this.pos, vec3.scale([], this.right, -this.movSpeed));
        }
        if (Input.keys[81]) {
          this.pos[1] += this.movSpeed;
        }
        if (Input.keys[90]) {
          this.pos[1] -= this.movSpeed;
        }
      }
      Message.send("cameraPosition", this.pos);
      Message.send("cameraFrontVec", this.front);
      return Message.send("cameraRightVec", this.right);
    };
    Camera.prototype.setupVectors = function(){
      this.front = vec3.fromValues(Math.cos(this.yaw * Math.PI / 180) * Math.cos(this.pitch * Math.PI / 180), Math.sin(this.pitch * Math.PI / 180), Math.sin(this.yaw * Math.PI / 180) * Math.cos(this.pitch * Math.PI / 180));
      vec3.normalize(this.front, this.front);
      this.right = vec3.cross(this.right, this.front, this.worldUp);
      vec3.normalize(this.right, this.right);
      this.up = vec3.cross(this.up, this.right, this.front);
      vec3.normalize(this.up, this.up);
    };
    Camera.prototype.getViewMatrix = function(){
      var viewMat;
      this.setupVectors();
      viewMat = mat4.create();
      mat4.lookAt(viewMat, this.pos, vec3.add([], this.pos, this.front), this.worldUp);
      return viewMat;
    };
    Camera.prototype.getProjectionMatrix = function(){
      var projectionMatrix;
      this.setupVectors();
      projectionMatrix = mat4.create();
      mat4.perspective(projectionMatrix, 45 * Math.PI / 180, this.gl.viewportWidth / this.gl.viewportHeight, 0.1, 100.0);
      return projectionMatrix;
    };
    Camera.prototype.deadView = function(){
      if (this.pitch < 45) {
        this.pitch += (46 - this.pitch) / 25;
        this.pos[1] -= 0.02;
      }
    };
    return Camera;
  }());
}).call(this);
