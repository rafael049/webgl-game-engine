class window.Camera
    (gl, pos = vec3.create!, parent=void) ->
        @gl = gl
        @pos = pos
        @parent = parent

        @offset = [0.0, 1.0, 0.0] # Offset from parent

        @front = vec3.create!
        @up = vec3.create!
        @right = vec3.create!
        @worldUp = vec3.fromValues(0.0, 1.0, 0.0)

        @yaw = -90.0    # degrees
        @pitch = 0.0    # degrees
        @movSpeed = 0.1
        @sensivity = 1.5

        @fov = 35.0 # degrees
        @znear = 0.1
        @zfar = 1000.0
        @aspect = @gl.viewportWidth / @gl.viewportHeight

        @setupVectors!

    update: ->
        @setupVectors!

        # Adjust position to follow parent
        if @parent
            vec3.add(@pos, @parent.pos, @offset)

        if Input.keys[75] # k
            @pitch += @sensivity
        if Input.keys[74] # j
            @pitch -= @sensivity
        if Input.keys[76] # l
            @yaw += @sensivity
        if Input.keys[72] # h
            @yaw -= @sensivity

        if not Input.keys[16] # shift
            @pitch -= Input.mouseMove[1] * @sensivity / 20
            @yaw   += Input.mouseMove[0] * @sensivity / 20

        if not @parent
            if Input.keys[87]
                vec3.add(@pos, @pos, vec3.scale([], @front, @movSpeed))
            if Input.keys[83]
                vec3.add(@pos, @pos, vec3.scale([], @front,-@movSpeed))
            if Input.keys[68]
                vec3.add(@pos, @pos, vec3.scale([], @right, @movSpeed))
            if Input.keys[65]
                vec3.add(@pos, @pos, vec3.scale([], @right,-@movSpeed))

            if Input.keys[81]
                @pos[1] += @movSpeed
            if Input.keys[90]
                @pos[1] -= @movSpeed

        Message.send "cameraPosition", @pos
        Message.send "cameraFrontVec", @front
        Message.send "cameraRightVec", @right

    setupVectors: !->
        @front  = vec3.fromValues(
            Math.cos(@yaw*Math.PI/180) * Math.cos(@pitch*Math.PI/180),
            Math.sin(@pitch*Math.PI/180),
            Math.sin(@yaw*Math.PI/180) * Math.cos(@pitch*Math.PI/180)
        )
        vec3.normalize(@front, @front)
        @right = vec3.cross(@right, @front, @worldUp)
        vec3.normalize(@right, @right)
        @up = vec3.cross(@up, @right, @front)
        vec3.normalize(@up, @up)

    getViewMatrix: ->
        @setupVectors!
        viewMat = mat4.create!
        mat4.lookAt(
            viewMat,
            @pos,
            vec3.add([], @pos, @front),
            @worldUp
        )
        viewMat

    getProjectionMatrix: ->
        @setupVectors!
        projectionMatrix = mat4.create!
        mat4.perspective(
            projectionMatrix,
            45 * Math.PI/180, # field of view
            @gl.viewportWidth / @gl.viewportHeight, # aspect
            0.1, # z near
            100.0, #z far
        )
        projectionMatrix

    deadView: !->
        if @pitch < 45
            @pitch += (46 - @pitch)/25
            @pos[1] -= 0.02
