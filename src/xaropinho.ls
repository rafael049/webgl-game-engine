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
        playerPos = Message.get "playerPosition"
        vel = []
        vec3.sub(vel, playerPos, @pos)
        if vec3.len(vel) > 5.0
            vec3.normalize(vel, vel)
            vec3.scale(vel, vel, 0.1)
            @vel = vel
        else
            @vel = [0, 0, 0]
