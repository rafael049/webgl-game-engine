
class window.HUD
    (gl) ->
        @gl = gl
        @weapon = new WeaponHud gl
            #@text = new Text "Puta dor nas costas socorro", "Lucidas Console", [100, 300], 32, "\#ffffff", true

    render: ->
        orthoProjectionMatrix = mat4.create!
        mat4.ortho orthoProjectionMatrix, -2.0, 2.0, -2.0, 2.0, 0.1, 5.0
        @weapon.render orthoProjectionMatrix

    update: ->
        @weapon.update!

