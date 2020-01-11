class window.Explosion extends Sprite
    (gl, pos) ->
        super(gl, pos)
        @name = "explosion"
        @texture = Resources.getTexture(gl, "explosion.png")
        @shader = Resources.getShader(gl, "sprite")

        #@anim = {
        #    xTiles: 8
        #    yTiles: 4
        #    curFrame: 0
        #    curAnim: "Idle"
        #}
        @anim.xTiles = 8
        @anim.yTiles = 4

    update: ->
        @lookAtCamera!

