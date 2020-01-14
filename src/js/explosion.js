// Generated by LiveScript 1.6.0
(function(){
  var Explosion;
  window.Explosion = Explosion = (function(superclass){
    var prototype = extend$((import$(Explosion, superclass).displayName = 'Explosion', Explosion), superclass).prototype, constructor = Explosion;
    function Explosion(gl, pos){
      Explosion.superclass.call(this, gl, pos);
      this.name = "explosion";
      this.texture = Resources.getTexture(gl, "explosion.png");
      this.shader = Resources.getShader(gl, "sprite");
      this.anim.xTiles = 8;
      this.anim.yTiles = 4;
      this.anim.anims["Idle"] = [0, 31];
      this.anim.curAnim = "Idle";
      this.anim.ended = false;
      this.anim.loopAnim = true;
    }
    Explosion.prototype.update = function(){
      return this.lookAtCamera();
    };
    return Explosion;
  }(Sprite));
  function extend$(sub, sup){
    function fun(){} fun.prototype = (sub.superclass = sup).prototype;
    (sub.prototype = new fun).constructor = sub;
    if (typeof sup.extended == 'function') sup.extended(sub);
    return sub;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
