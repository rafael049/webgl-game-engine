// Generated by LiveScript 1.6.0
(function(){
  var Xaropinho;
  window.Xaropinho = Xaropinho = (function(superclass){
    var prototype = extend$((import$(Xaropinho, superclass).displayName = 'Xaropinho', Xaropinho), superclass).prototype, constructor = Xaropinho;
    function Xaropinho(gl, pos){
      Xaropinho.superclass.call(this, gl, pos);
      this.name = "xaropinho";
      this.texture = Resources.getTexture(gl, "xaropinho.png");
      this.canCollide = true;
      this.radius = 1.0;
      this.anim.xTiles = 1;
      this.anim.yTiles = 1;
    }
    Xaropinho.prototype.update = function(){
      var playerPos, vel;
      superclass.prototype.update.call(this);
      playerPos = Message.get("playerPosition");
      vel = [];
      vec3.sub(vel, playerPos, this.pos);
      if (vec3.len(vel) > 5.0) {
        vec3.normalize(vel, vel);
        vec3.scale(vel, vel, 0.1);
        return this.vel = vel;
      } else {
        return this.vel = [0, 0, 0];
      }
    };
    return Xaropinho;
  }(Enemy));
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
