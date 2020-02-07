class window.Player
    MAX_VEL = 0.2
    (gl, pos) ->
        @pos       = pos
        @vel       = [0.0, 0.0, 0.0]      # World Velocity
        @linearVel = 0.0
        @dir       = [0.0, 0.0, 0.0]      # Local direction
        @radius    = 1.0
        @height    = 2.0

        @collidingWith = []

        @camera = new Camera gl, [0.0, 0.0, 0.0], this

        @state = "Normal"

        @timers = []

        @health = 100
        @dead = false

        @lastVel = @vel

    update: (deltaTime) ->
        switch @state
        case "Normal"
            @camera.update!
            @updatePosition!
            @readInput!
            @calcVel deltaTime
            if @takingDamage
                if HUD.damageScreen.style.opacity > 0.05
                    HUD.damageScreen.style.opacity -= 0.05
                else
                    HUD.damageScreen.style.opacity = 0.0

        case "Dying"
            @dead = true
            @camera.deadView!
            if @wait "risada_delay", 2000

                @state = "Die"

                # Play random sound
                op = Math.round Math.random!
                switch op
                case 0
                    AudioManager.playSound "peludao.opus"
                case 1
                    AudioManager.playSound "va_com_deus.opus"

        case "Die"
            @health = 0

        @sendMessages!

    updatePosition: !->
        vel = []
        vec3.add(vel, @vel, @lastVel)
        vec3.scale(vel, vel, 0.5)
        vec3.add(@pos, @pos, vel)

        @lastVel = @vel

    calcVel: (deltaTime) !->
        front = vec3.clone(Message.get "cameraFrontVec")
        right = vec3.clone(Message.get "cameraRightVec")
        # Remove up component
        front[1] = 0.0
        vec3.normalize(front, front)

        vec3.scale(right, right, @dir[0]*@linearVel*deltaTime)
        vec3.scale(front, front, @dir[2]*@linearVel*deltaTime)

        vec3.add(@vel, front, right)

    readInput: !->
        @dir = [0.0, 0.0, 0.0]
        if Input.keys[87]       # W
            @dir[2] += 1
            @linearVel = MAX_VEL
        if Input.keys[83]       # S
            @dir[2] += -1
            @linearVel = MAX_VEL
        if Input.keys[68]       # D
            @dir[0] += 1
            @linearVel = MAX_VEL
        if Input.keys[65]       # A
            @dir[0] += -1
            @linearVel = MAX_VEL

        vec3.normalize @dir, @dir

    damage: (value) ->

        if @health <= 0 and not @dead
            @state = "Dying"
        else if not @dead
            @health -= value
            HUD.damageScreen.style.opacity = 0.25
            @takingDamage = true

            op = Math.round (Math.random! * 1)
            switch op
            case 0
                AudioManager.playSound "ai.m4a"
            case 1
                AudioManager.playSound "uepa.mp3"
            case 2
                AudioManager.playSound "jesus.m4a"

    sendMessages: ->
        Message.send "playerPosition", @pos
        Message.send "playerRef", this
        Message.send "isPlayerDead", @dead



    wait: (name, time, once=false) ->
        now = Date.now!
        end = now + time

        if @timers[name]
            if now > @timers[name]
                delete @timers[name]
                true
            else
                false

        else
            @timers[name] = end
            false
