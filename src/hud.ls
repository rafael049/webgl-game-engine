class SpriteHUD extends Sprite
    (gl, pos) ->
        # Call base constructor
        super gl, pos

        # Set texture
        @texture = Resources.getTexture gl, "doomPistol.png"

        # Configure texture tiles
        @anim.xTiles = 3
        @anim.yTiles = 2

        # Define animations
        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Shot"] = [0, 5]
        @anim.curAnim = "Idle"


    render:(projectionMatrix) ->
        viewMatrix = mat4.create!
        mat4.identity viewMatrix
        super viewMatrix, projectionMatrix

class WeaponHud
    (gl) ->
        @sprite = new SpriteHUD gl, [1.2, -2.1, -0.1]

    render: (projectionMatrix) ->
        @sprite.render projectionMatrix

    update: ->
        if Input.onKeydown(70)
            @sprite.playAnim "Shot", false
            AudioManager.playSound "tiro.mp3"


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

