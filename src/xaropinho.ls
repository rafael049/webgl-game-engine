class window.Xaropinho extends Enemy
    (gl, pos) ->
        super(gl, pos)
        @name = "xaropinho"

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")

        @canCollide = true
        @radius = 1.0

        @anim.xTiles = 1
        @anim.yTiles = 1

    update: ->
        super!
        @vel[0] = 0.1
