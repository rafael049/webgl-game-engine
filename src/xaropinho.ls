class window.Xaropinho extends Sprite
    (gl, pos) ->
        super(gl, pos)
        @name = "xaropinho"

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")
        @shader = Resources.getShader(gl, "sprite")
        @mesh = Resources.getMesh(gl, "sprite1")

        @canCollide = true

        @anim.xTiles = 1
        @anim.yTiles = 1

    update: ->
        @lookAtCamera!
