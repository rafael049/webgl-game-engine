class SpriteHUD extends Sprite
    (gl, pos) ->
        super gl, pos
        @texture = Resources.getTexture gl, "doomPistol.png"
        @anim.xTiles = 3
        @anim.yTiles = 2
        @anim.anims["Idle"] = [1, 1]
        @anim.anims["Shot"] = [0, 5]
        @anim.curAnim = "Shot"
        @anim.ended = false
        @anim.loopAnim = false

    render:(projectionMatrix) ->
        viewMatrix = mat4.create!
        mat4.identity viewMatrix
        super viewMatrix, projectionMatrix


class window.HUD
    (gl) ->
        @gl = gl
        @gun = new SpriteHUD gl, [1.2, -2.1,-0.1]
        @text = new Text "Puta dor nas costas socorro", "Lucidas Console", [100, 300], 32, "\#ffffff", true

    render: ->
        orthoProjectionMatrix = mat4.create!
        mat4.ortho orthoProjectionMatrix, -2.0, 2.0, -2.0, 2.0, 0.1, 5.0
        @gun.render orthoProjectionMatrix

