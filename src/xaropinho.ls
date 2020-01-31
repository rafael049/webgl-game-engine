class window.Xaropinho extends Enemy
    (gl, pos) ->
        super(gl, pos)
        @name = "xaropinho"

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")

        @canCollide = true
        @radius = 1.0

        @anim.xTiles = 2
        @anim.yTiles = 1

        # Define animations
        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Hurt"] = [1, 1]
        @anim.curAnim = "Idle"

    update: ->
        super!

        switch @state
        case "Idle"
            @playAnim "Idle"
            @vel = [0, 0, 0]

            playerPos = Message.get "playerPosition"
            dist = []
            vec3.sub(dist, playerPos, @pos)
            if vec3.len(dist) > 5.0
                @state = "Attack"
        case "Hurt"
            console.log @health
            @vel = [0, 0, 0]
            @playAnim "Hurt"

            if @wait "hurt_time", 100
                if @health <= 0
                    @state = "Dead"
                else
                    @state = "Idle"
        case "Attack"
            playerPos = Message.get "playerPosition"
            vel = []
            vec3.sub(vel, playerPos, @pos)

            @playAnim "Idle"

            vec3.normalize(vel, vel)
            vec3.scale(vel, vel, 0.1)
            @vel = vel
        case "Dead"
            @vel = [0, 0.0, 0]
            if @wait "garbage", 500
                @trash = true
