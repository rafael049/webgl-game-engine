class window.Player
    MAX_VEL = 0.2
    (pos) ->
        @pos = pos
        @vel = [0.0, 0.0, 0.0]
        @radius = 1.0
        @height = 2.0

    update: (deltaTime) ->
        @readInput!
        front = vec3.clone(Message.get "cameraFrontVec")
        right = vec3.clone(Message.get "cameraRightVec")
        # Remove up component
        front[1] = 0.0
        vec3.normalize(front, front)

        vec3.scale(right, right, @vel[0]*deltaTime)
        vec3.scale(front, front, @vel[2]*deltaTime)

        sum = []
        vec3.add(sum, front, right)
        vec3.add(@pos, @pos, sum)

    readInput: ->
        @vel = [0.0, 0.0, 0.0]
        if Input.keys[87]
            @vel[2] = 1
        if Input.keys[83]
            @vel[2] = -1
        if Input.keys[68]
            @vel[0] = 1
        if Input.keys[65]
            @vel[0] = -1

        vec3.normalize @vel, @vel
        vec3.scale @vel, @vel, 0.2
