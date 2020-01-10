// Generated by LiveScript 1.6.0
(function(){
  var prelude, Shader;
  prelude = require("prelude-ls");
  window.Shader = Shader = (function(){
    Shader.displayName = 'Shader';
    var loadTextFile, prototype = Shader.prototype, constructor = Shader;
    function Shader(gl, name){
      this.gl = gl;
      this.vertexShader = this.createShader(name.concat(".vs"));
      this.fragShader = this.createShader(name.concat(".fs"));
      this.program = this.createProgram();
    }
    Shader.prototype.createShader = function(name){
      var source_str, shader, extension, info;
      source_str = loadTextFile("assets/shaders/" + name);
      shader = void 8;
      extension = prelude.dropWhile((function(it){
        return !deepEq$(it, '.', '===');
      }), name);
      if (extension === ".fs") {
        shader = this.gl.createShader(this.gl.FRAGMENT_SHADER);
      } else if (extension === ".vs") {
        shader = this.gl.createShader(this.gl.VERTEX_SHADER);
      } else {
        console.log("Unknow shader type");
        return null;
      }
      this.gl.shaderSource(shader, source_str);
      this.gl.compileShader(shader);
      if (!this.gl.getShaderParameter(shader, this.gl.COMPILE_STATUS)) {
        info = this.gl.getShaderInfoLog(shader);
        console.log("Failed to compile shader " + name + "\n" + info);
        this.gl.deleteShader(shader);
        return null;
      }
      return shader;
    };
    Shader.prototype.createProgram = function(){
      var shaderProgram, info;
      shaderProgram = this.gl.createProgram();
      this.gl.attachShader(shaderProgram, this.vertexShader);
      this.gl.attachShader(shaderProgram, this.fragShader);
      this.gl.linkProgram(shaderProgram);
      if (!this.gl.getProgramParameter(shaderProgram, this.gl.LINK_STATUS)) {
        info = this.gl.getProgramInfoLog(shaderProgram);
        console.log("Shaders cannot be initialized" + "\n" + info);
      }
      this.gl.useProgram(shaderProgram);
      return shaderProgram;
    };
    Shader.prototype.use = function(){
      this.gl.useProgram(this.program);
    };
    Shader.prototype.getAttribLocation = function(name){
      this.use();
      return this.gl.getAttribLocation(this.program, name);
    };
    Shader.prototype.getUniformLocation = function(name){
      this.use();
      return this.gl.getUniformLocation(this.program, name);
    };
    Shader.prototype.setLocal = function(mat){
      this.gl.uniformMatrix4fv(this.getUniformLocation("uLocalMat"), false, mat);
    };
    Shader.prototype.setModel = function(mat){
      this.gl.uniformMatrix4fv(this.getUniformLocation("uModelMat"), false, mat);
    };
    Shader.prototype.setView = function(mat){
      this.gl.uniformMatrix4fv(this.getUniformLocation("uViewMat"), false, mat);
    };
    Shader.prototype.setProjection = function(mat){
      this.gl.uniformMatrix4fv(this.getUniformLocation("uProjectionMat"), false, mat);
    };
    Shader.prototype.setTexture = function(id){
      return this.gl.uniform1i(this.getUniformLocation("uTexture"), id);
    };
    loadTextFile = function(path){
      var result, xmlhttp;
      result = void 8;
      xmlhttp = new XMLHttpRequest;
      xmlhttp.async = false;
      xmlhttp.open("GET", path, false);
      xmlhttp.send();
      if (xmlhttp.status === 200) {
        result = xmlhttp.responseText;
      }
      return result;
    };
    return Shader;
  }());
  function deepEq$(x, y, type){
    var toString = {}.toString, hasOwnProperty = {}.hasOwnProperty,
        has = function (obj, key) { return hasOwnProperty.call(obj, key); };
    var first = true;
    return eq(x, y, []);
    function eq(a, b, stack) {
      var className, length, size, result, alength, blength, r, key, ref, sizeB;
      if (a == null || b == null) { return a === b; }
      if (a.__placeholder__ || b.__placeholder__) { return true; }
      if (a === b) { return a !== 0 || 1 / a == 1 / b; }
      className = toString.call(a);
      if (toString.call(b) != className) { return false; }
      switch (className) {
        case '[object String]': return a == String(b);
        case '[object Number]':
          return a != +a ? b != +b : (a == 0 ? 1 / a == 1 / b : a == +b);
        case '[object Date]':
        case '[object Boolean]':
          return +a == +b;
        case '[object RegExp]':
          return a.source == b.source &&
                 a.global == b.global &&
                 a.multiline == b.multiline &&
                 a.ignoreCase == b.ignoreCase;
      }
      if (typeof a != 'object' || typeof b != 'object') { return false; }
      length = stack.length;
      while (length--) { if (stack[length] == a) { return true; } }
      stack.push(a);
      size = 0;
      result = true;
      if (className == '[object Array]') {
        alength = a.length;
        blength = b.length;
        if (first) {
          switch (type) {
          case '===': result = alength === blength; break;
          case '<==': result = alength <= blength; break;
          case '<<=': result = alength < blength; break;
          }
          size = alength;
          first = false;
        } else {
          result = alength === blength;
          size = alength;
        }
        if (result) {
          while (size--) {
            if (!(result = size in a == size in b && eq(a[size], b[size], stack))){ break; }
          }
        }
      } else {
        if ('constructor' in a != 'constructor' in b || a.constructor != b.constructor) {
          return false;
        }
        for (key in a) {
          if (has(a, key)) {
            size++;
            if (!(result = has(b, key) && eq(a[key], b[key], stack))) { break; }
          }
        }
        if (result) {
          sizeB = 0;
          for (key in b) {
            if (has(b, key)) { ++sizeB; }
          }
          if (first) {
            if (type === '<<=') {
              result = size < sizeB;
            } else if (type === '<==') {
              result = size <= sizeB
            } else {
              result = size === sizeB;
            }
          } else {
            first = false;
            result = size === sizeB;
          }
        }
      }
      stack.pop();
      return result;
    }
  }
}).call(this);
