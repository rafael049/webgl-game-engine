
class window.HUD
    @damageScreen = void
    (gl) ->
        @gl = gl
        @@damageScreen = document.getElementById "damageScreen"
        @weapon = new WeaponHud gl
            #@text = new Text "Puta dor nas costas socorro", "Lucidas Console", [100, 300], 32, "\#ffffff", true

    render: ->
        orthoProjectionMatrix = mat4.create!
        mat4.ortho orthoProjectionMatrix, -2.0, 2.0, -2.0, 2.0, 0.1, 5.0
        if not Message.get "isPlayerDead"
            @weapon.render orthoProjectionMatrix
        else
            @@damageScreen.style.opacity = 0.25

    update: ->
        @weapon.update!

