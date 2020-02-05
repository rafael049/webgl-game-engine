class Logo extends SpriteHUD
    (gl) ->
        pos = [1.2, -1.1, -0.1]
        super gl, pos
        @texture = Resources.getTexture gl, "logoTV.png"

class window.HUD
    @damageScreen = void
    (gl) ->
        @gl = gl
        @@damageScreen = document.getElementById "damageScreen"
        @weapon = new WeaponHud gl
        @manchete = new Text "MASCOTES ATACAM APRESENTADOR, MAS ELE TA LOUCO DE DROGA", "Arial", [70, 635], 32, "\#ffffff", true, 650
        @health = new Text "VIDA:", "Arial", [60, 600], 25, "\#ffffff", true, 200
            #@logo = new Logo gl

    render: ->
        orthoProjectionMatrix = mat4.create!
        mat4.ortho orthoProjectionMatrix, -2.0, 2.0, -2.0, 2.0, 0.1, 5.0

        if not Message.get "isPlayerDead"
            @weapon.render orthoProjectionMatrix
        else
            @@damageScreen.style.opacity = 0.25
            @manchete.setText "O CARA MORREU MANO KKKKKKKJJKKK KKKKKKKKKK"

        player = Message.get "playerRef"

        if player
            # Update player life
            @health.setText "VIDA: #{player.health}"
            # Walking animation
            if vec3.len(player.vel) > 0.1
                @weapon.pos[1] = 0.03*Math.sin(Date.now!/120) - 1.1

    update: ->
        @weapon.update!

