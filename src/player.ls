class window.Player
    MAX_VEL = 0.2
    (pos) ->
        @pos      = pos
        @vel      = [0.0, 0.0, 0.0]      # World Velocity
        @dir      = [0.0, 0.0, 0.0]      # Local direction
        @radius   = 1.0
        @height   = 2.0

        @collidingWith = []

    update: (deltaTime) ->

        @updatePosition!

        @readInput!
        @calcVel deltaTime

    updatePosition: !->
        vec3.add(@pos, @pos, @vel)

    calcVel: (deltaTime) !->
        front = vec3.clone(Message.get "cameraFrontVec")
        right = vec3.clone(Message.get "cameraRightVec")
        # Remove up component
        front[1] = 0.0
        vec3.normalize(front, front)

        vec3.scale(right, right, @dir[0]*MAX_VEL*deltaTime)
        vec3.scale(front, front, @dir[2]*MAX_VEL*deltaTime)

        vec3.add(@vel, front, right)

    readInput: !->
        @dir = [0.0, 0.0, 0.0]
        if Input.keys[87]       # W
            @dir[2] += 1
        if Input.keys[83]       # S
            @dir[2] += -1
        if Input.keys[68]       # D
            @dir[0] += 1
        if Input.keys[65]       # A
            @dir[0] += -1

        vec3.normalize @dir, @dir
