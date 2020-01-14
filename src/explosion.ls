class window.Explosion extends Sprite
    (gl, pos) ->
        super(gl, pos)
        @name = "explosion"
        @texture = Resources.getTexture(gl, "explosion.png")
        @shader = Resources.getShader(gl, "sprite")

        @anim.xTiles = 8
        @anim.yTiles = 4
        @anim.anims["Idle"] = [0, 31]
        @anim.curAnim = "Idle"
        @anim.ended = false
        @anim.loopAnim = true

    update: ->
        @lookAtCamera!

