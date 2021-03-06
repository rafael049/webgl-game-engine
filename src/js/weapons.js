// Generated by LiveScript 1.6.0
(function(){
  var WeaponHud;
  window.WeaponHud = WeaponHud = (function(){
    WeaponHud.displayName = 'WeaponHud';
    var prototype = WeaponHud.prototype, constructor = WeaponHud;
    function WeaponHud(gl){
      this.currentWeapon = "cacetete";
      this.weapons = {
        pistol: {
          sprite: new PistolSprite(gl),
          sound: "tiro.mp3",
          type: "fire",
          firerate: 1.0,
          damage: 20.0
        },
        cacetete: {
          sprite: new CaceteteSprite(gl),
          sound: "batSwing.mp3",
          type: "meelee",
          firerate: 1.0,
          damage: 5.0
        }
      };
    }
    WeaponHud.prototype.render = function(projectionMatrix){
      return this.weapons[this.currentWeapon].sprite.render(projectionMatrix);
    };
    WeaponHud.prototype.update = function(){
      var currentWeapon, cameraPos, cameraDir, obj;
      currentWeapon = this.weapons[this.currentWeapon];
      this.pos = currentWeapon.sprite.pos;
      if (Input.onKeydown(70)) {
        currentWeapon.sprite.playAnim("Shot", false);
        AudioManager.playSound(currentWeapon.sound);
        cameraPos = Message.get("cameraPosition");
        cameraDir = Message.get("cameraFrontVec");
        if (currentWeapon.type === "fire") {
          obj = Collision.raycast(cameraPos, cameraDir, 100.0);
          if (obj) {
            obj.doDamage(currentWeapon.damage);
          }
        } else if (currentWeapon.type === "meelee") {
          obj = Collision.raycast(cameraPos, cameraDir, 4.0);
          if (obj) {
            obj.doDamage(currentWeapon.damage);
          }
        } else if (currentWeapon.type === "") {
          console.log("TODO");
        }
      }
      if (Input.onKeydown(49)) {
        this.currentWeapon = "cacetete";
      }
      if (Input.onKeydown(50)) {
        return this.currentWeapon = "pistol";
      }
    };
    return WeaponHud;
  }());
}).call(this);
