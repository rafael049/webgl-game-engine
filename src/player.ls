class window.Player
    MAX_VEL = 0.2
    (pos) ->
        @pos = pos
        @vel = [0.0, 0.0, 0.0]
        @radius = 1.0
        @height = 2.0

    update: (deltaTime) ->
        @readInput!

        @pos[0] += @vel[0]*deltaTime
        @pos[2] += @vel[2]*deltaTime

    readInput: ->
        @vel = [0.0, 0.0, 0.0]
        if Input.keys[87]
            @vel[2] = -1
        if Input.keys[83]
            @vel[2] = 1
        if Input.keys[68]
            @vel[0] = 1
        if Input.keys[65]
            @vel[0] = -1

        vec3.normalize @vel, @vel
        vec3.scale @vel, @vel, 0.2
