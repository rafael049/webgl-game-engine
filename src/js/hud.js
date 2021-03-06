// Generated by LiveScript 1.6.0
(function(){
  var Logo, HUD;
  Logo = (function(superclass){
    var prototype = extend$((import$(Logo, superclass).displayName = 'Logo', Logo), superclass).prototype, constructor = Logo;
    function Logo(gl){
      var pos;
      pos = [1.2, -1.1, -0.1];
      Logo.superclass.call(this, gl, pos);
      this.texture = Resources.getTexture(gl, "logoTV.png");
    }
    return Logo;
  }(SpriteHUD));
  window.HUD = HUD = (function(){
    HUD.displayName = 'HUD';
    var prototype = HUD.prototype, constructor = HUD;
    HUD.damageScreen = void 8;
    function HUD(gl){
      this.gl = gl;
      constructor.damageScreen = document.getElementById("damageScreen");
      this.weapon = new WeaponHud(gl);
      this.manchete = new Text("MASCOTES ATACAM APRESENTADOR, MAS ELE TA LOUCO DE DROGA", "Arial", [70, 635], 32, "#ffffff", true, 650);
      this.health = new Text("VIDA:", "Arial", [60, 600], 25, "#ffffff", true, 200);
      this.score = new Text("IBOPE:", "Arial", [60, 50], 30, "#ffffff", true, 200);
    }
    HUD.prototype.render = function(){
      var orthoProjectionMatrix;
      orthoProjectionMatrix = mat4.create();
      mat4.ortho(orthoProjectionMatrix, -2.0, 2.0, -2.0, 2.0, 0.1, 5.0);
      if (!Message.get("isPlayerDead")) {
        return this.weapon.render(orthoProjectionMatrix);
      } else {
        constructor.damageScreen.style.opacity = 0.25;
        return this.manchete.setText("O CARA MORREU MANO KKKKKKKJJKKK KKKKKKKKKK");
      }
    };
    HUD.prototype.update = function(){
      var player;
      this.weapon.update();
      player = Message.get("playerRef");
      if (player) {
        this.health.setText("VIDA: " + player.health);
        if (vec3.len(player.vel) > 0.1) {
          this.weapon.pos[1] = 0.03 * Math.sin(Date.now() / 120) - 1.1;
        }
      }
      return this.score.setText("IBOPE: " + Score.score);
    };
    return HUD;
  }());
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
