// Generated by LiveScript 1.6.0
(function(){
  var Texture;
  window.Texture = Texture = (function(){
    Texture.displayName = 'Texture';
    var isPowerOf2, prototype = Texture.prototype, constructor = Texture;
    function Texture(gl, filename){
      this.gl = gl;
      this.id = this.createTexture("../assets/images/" + filename);
    }
    Texture.prototype.use = function(){
      return this.gl.bindTexture(this.gl.TEXTURE_2D, this.id);
    };
    Texture.prototype.createDefaultTexture = function(){
      var id;
      id = this.gl.createTexture();
      this.gl.bindTexture(this.gl.TEXTURE_2D, id);
      this.gl.pixelStorei(this.gl.UNPACK_ALIGNMENT, 1);
      this.gl.texImage2D(this.gl.TEXTURE_2D, 0, this.gl.R8, 2, 2, 0, this.gl.RED, this.gl.UNSIGNED_BYTE, new Uint8Array([128, 64, 0, 192]));
      this.gl.texParameteri(this.gl.TEXTURE_2D, this.gl.TEXTURE_WRAP_S, this.gl.REPEAT);
      this.gl.texParameteri(this.gl.TEXTURE_2D, this.gl.TEXTURE_WRAP_T, this.gl.REPEAT);
      this.gl.texParameteri(this.gl.TEXTURE_2D, this.gl.TEXTURE_MIN_FILTER, this.gl.NEAREST);
      this.gl.texParameteri(this.gl.TEXTURE_2D, this.gl.TEXTURE_MAG_FILTER, this.gl.NEAREST);
      return id;
    };
    Texture.prototype.createTexture = function(name){
      var id, gl, image;
      id = this.createDefaultTexture();
      gl = this.gl;
      this.gl.bindTexture(this.gl.TEXTURE_2D, id);
      image = new Image;
      image.onload = function(){
        gl.bindTexture(gl.TEXTURE_2D, id);
        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image);
        if (isPowerOf2(image.width) && isPowerOf2(image.height)) {
          gl.generateMipmap(gl.TEXTURE_2D);
        }
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
        return gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
      };
      image.src = name;
      return id;
    };
    isPowerOf2 = function(value){
      return (value & value - 1) === 0;
    };
    return Texture;
  }());
}).call(this);
