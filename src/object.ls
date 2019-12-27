class window.GameObject
    (gl) ->
        @gl = gl

        @pos = vec3.create!
        @rot = vec3.create!
        @sca = vec3.create!

        @vel = vec3.create!

        @localMat = mat4.create!
        @modelViewMat = mat4.create!

        @shader = new Shader("default", gl)
        @mesh = new Mesh(gl)

    render: (viewMatrix, projectionMatrix) ->

        modelMatrix = mat4.create!
        mat4.translate(
            modelMatrix,
            modelMatrix,
            @pos
        )

        localMatrix = mat4.create!
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

        @shader.setProjection projectionMatrix
        @shader.setView viewMatrix
        @shader.setModel modelMatrix
        @shader.setLocal localMatrix
        @shader.use!

        @mesh.render @shader
    setPosition: (pos) !->
        @pos = pos

    setRotationX: (angle) !->
        @rot[0] = angle
    setRotationY: (angle) !->
        @rot[1] = angle
    setRotationZ: (angle) !->
        @rot[2] = angle
