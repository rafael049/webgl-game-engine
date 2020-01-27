class window.GameObject # Object is a reserved word
    (gl) ->
        @name = "no_name"
        @gl = gl

        @pos = vec3.create!
        @rot = vec3.create!
        @sca = vec3.fromValues(1, 1, 1)

        @vel = vec3.create!

        @localMat = mat4.create!
        @modelViewMat = mat4.create!

        @canCollide = false
        @collidingWith = []

    render: (viewMatrix, projectionMatrix) ->

        modelMatrix = mat4.create!
        mat4.translate(
            modelMatrix,
            modelMatrix,
            @pos
        )

        localMatrix = mat4.create!
        mat4.scale(
            localMatrix,
            localMatrix,
            @sca
        )
        mat4.rotateX(
            localMatrix,
            localMatrix,
            @rot[0]
        )
        mat4.rotateY(
            localMatrix,
            localMatrix,
            @rot[1]
        )
        mat4.rotateZ(
            localMatrix,
            localMatrix,
            @rot[2]
        )

        # Texture
        @gl.activeTexture(@gl.TEXTURE0)
        @texture.use!

        @shader.setTexture @texture.id

        @shader.setProjection projectionMatrix
        @shader.setView viewMatrix
        @shader.setModel modelMatrix
        @shader.setLocal localMatrix
        @shader.use!

        @mesh.render @shader, @texture

    update: (pos) !->
        console.log "Error: Game Object #{@name} do not implement update function!"

    setPosition: (pos) !->
        @pos = pos

    setScale: (scale) !->
        @sca = scale

    setRotationX: (angle) !->
        @rot[0] = angle
    setRotationY: (angle) !->
        @rot[1] = angle
    setRotationZ: (angle) !->
        @rot[2] = angle
