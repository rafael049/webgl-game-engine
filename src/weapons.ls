class window.WeaponHud
    (gl) ->
        @currentWeapon = "cacetete"
        @weapons =
            pistol:
                sprite: new PistolSprite gl
                sound: "tiro.mp3"
                type: "fire"
                firerate: 1.0
                damage: 1.0
            cacetete:
                sprite: new CaceteteSprite gl
                sound: "batSwing.mp3"
                type: "meelee"
                firerate: 1.0
                damage: 1.0

    render: (projectionMatrix) ->
        @weapons[@currentWeapon].sprite.render projectionMatrix

    update: ->
        currentWeapon = @weapons[@currentWeapon]
        @pos = currentWeapon.sprite.pos

        if Input.onKeydown(70)
            currentWeapon.sprite.playAnim "Shot", false
            AudioManager.playSound currentWeapon.sound

            cameraPos = Message.get "cameraPosition"
            cameraDir = Message.get "cameraFrontVec"
            if currentWeapon.type == "fire"
                obj = Collision.raycast cameraPos, cameraDir, 100.0
                if obj
                    obj.state = "Hurt"
                    obj.health -= 5.0
            else if currentWeapon.type == "meelee"
                obj = Collision.raycast cameraPos, cameraDir, 4.0
                if obj
                    obj.state = "Hurt"
                    obj.health -= 5.0

        if Input.onKeydown(49)
            @currentWeapon = "cacetete"
        if Input.onKeydown(50)
            @currentWeapon = "pistol"
