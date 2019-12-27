class window.Camera
    (gl, pos = vec3.create!) ->
        @gl = gl
        @pos = pos

        @front = vec3.create!
        @up = vec3.create!
        @right = vec3.create!
        @worldUp = vec3.fromValues(0.0, 1.0, 0.0)

        @yaw = -90.0
        @pitch = 0.0
        @movSpeed = 0.1
        @sensivity = 0.1

        @fov = 35.0 # degrees
        @znear = 0.1
        @zfar = 1000.0
        @aspect = @gl.viewportWidth / @gl.viewportHeight

        @setupVectors!

    update: ->
        @setupVectors!

        if Input.keys[75]
            @pitch += 0.5
        if Input.keys[74]
            @pitch -= 0.5
        if Input.keys[76]
            @yaw += 0.5
        if Input.keys[72]
            @yaw -= 0.5

        if Input.keys[87]
            vec3.add(@pos, @pos, vec3.scale([], @front, @movSpeed))
        if Input.keys[83]
            vec3.add(@pos, @pos, vec3.scale([], @front,-@movSpeed))
        if Input.keys[68]
            vec3.add(@pos, @pos, vec3.scale([], @right, @movSpeed))
        if Input.keys[65]
            vec3.add(@pos, @pos, vec3.scale([], @right,-@movSpeed))

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
