class window.Sprite extends GameObject
    (gl, pos) ->
        super(gl)
        @name = "xaropinho"

        @pos = pos

        @anim = {
            xTiles: 2
            yTiles: 2
            curFrame: 0
            curAnim: "Idle"
        }

        @shader = Resources.getShader(gl, "sprite")
        @mesh = Resources.getMesh(gl, "sprite1")

    render: (viewMatrix, projectionMatrix) ->
        @setShaderAnimation!
        @nextFrame!
        super ...

    update: ->
        1 == 1

    setShaderAnimation: !->
        @shader.setUniformInt("x_tiles", @anim.xTiles)
        @shader.setUniformInt("y_tiles", @anim.yTiles)
        @shader.setUniformInt("frame", @anim.curFrame)

    nextFrame: !->
        @anim.curFrame += 1

    lookAtCamera: ! ->
        camPos = vec3.clone Message.get "cameraPosition"
        if camPos
            camPos[1] = 0.0     # Remove y component
            camPos[2] *= -1
            dist = vec3.sub([0.0, 0.0, 0.0], camPos, @pos)     # Calculate distance
            vec3.normalize(dist, dist)      # normalize distance
            if dist[0] > 0.0 and dist[2] > 0.0
                @rot[1] = Math.atan(dist[2]/dist[0])

            else if dist[0] < 0.0 and dist[2] > 0.0
                @rot[1] = Math.PI + Math.atan(dist[2]/dist[0])

            else if dist[0] < 0.0 and dist[2] < 0.0
                @rot[1] = Math.PI + Math.atan(dist[2]/dist[0])

            else
                @rot[1] = Math.atan(dist[2]/dist[0])

            @rot[1] += Math.PI/2
