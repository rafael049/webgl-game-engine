class window.Xaropinho extends Enemy
    (gl, pos) ->
        super(gl, pos)
        @name = "xaropinho"

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")

        @canCollide = true
        @radius = 1.0

        # Setup animations
        @anim.xTiles = 5
        @anim.yTiles = 1
        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Hurt"] = [1, 1]
        @anim.anims["Attack"] = [2, 4]
        @anim.curAnim = "Idle"

        # Initial state
        @state = "Idle"

    update: ->
        super!

        switch @state
        case "Idle"
            @playAnim "Idle"
            @vel = [0, 0, 0]

            playerPos = Message.get "playerPosition"
            dist = []
            vec3.sub(dist, playerPos, @pos)
            if vec3.len(dist) < 10.0
                @state = "Seek"
        case "Hurt"
            @vel = [0, 0, 0]
            @playAnim "Hurt"

            if @wait "hurt_time", 100
                if @health <= 0
                    @state = "Dead"
                else
                    @state = "Seek"
        case "Seek"
            playerPos = Message.get "playerPosition"
            player = Message.get "playerRef"

            @playAnim "Idle"


            # Attack if close enough
            dist = []
            vec3.sub(dist, playerPos, @pos)
            if vec3.len(dist) < 3.0
                @state = "Attack"
            else
                # Follow player
                vel = []
                vec3.sub(vel, playerPos, @pos)
                vec3.normalize(vel, vel)
                vec3.scale(vel, vel, 0.1)
                @vel = vel

        case "Attack"
            player = Message.get "playerRef"

            @vel = [0, 0, 0]

            # Check if the player still in the range
            dist = []
            vec3.sub(dist, player.pos, @pos)
            if vec3.len(dist) > 3.0
                @state = "Seek"

            # Attack
            if @wait "Attack_interval", 1000
                @playAnim "Attack", false
                player.damage 10
                @state = "Seek"

        case "Dead"
            @vel = [0, 0, 0]
            AudioManager.playSound "rapaiz.mp3"
            if @wait "garbage", 500
                @trash = true
