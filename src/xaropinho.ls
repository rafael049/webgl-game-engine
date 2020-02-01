class window.Xaropinho extends Enemy
    (gl, pos) ->
        super(gl, pos)
        @name = "xaropinho"

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")

        @canCollide = true
        @radius = 1.0

        @anim.xTiles = 5
        @anim.yTiles = 1

        # Define animations
        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Hurt"] = [1, 1]
        @anim.anims["Attack"] = [2, 4]
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
            player = Message.get "playerRef"
            vel = []
            vec3.sub(vel, playerPos, @pos)

            if @wait "Attack_interval", 1000
                @playAnim "Attack", false
                player.damage 10

            vec3.normalize(vel, vel)
            vec3.scale(vel, vel, 0.1)
            @vel = vel
        case "Dead"
            @vel = [0, 0, 0]
            AudioManager.playSound "rapaiz.mp3"
            if @wait "garbage", 500
                @trash = true
