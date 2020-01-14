class window.Sprite extends GameObject
    (gl, pos) ->
        super(gl)
        @name = "xaropinho"

        @pos = pos

        @anim = {
            xTiles: 1
            yTiles: 1
            curFrame: 0
            curAnim: "Idle"
            anims:{
                Idle: [0, 0]
            }
            loopAnim: true
            ended: false
        }

        @shader = Resources.getShader(gl, "sprite")
        @mesh = Resources.getMesh(gl, "sprite1")


    render: (viewMatrix, projectionMatrix) ->
        @shader.setUniformInt("x_tiles", @anim.xTiles)
        @shader.setUniformInt("y_tiles", @anim.yTiles)
        @setShaderAnimation!
        super ...
        @nextFrame!

    update: ->
        1 == 1

    setShaderAnimation: !->
        @shader.setUniformInt("frame", @anim.curFrame)

    nextFrame: !->
        start = @anim.anims[@anim.curAnim][0]
        end   = @anim.anims[@anim.curAnim][1]

        # Verify if the current animation ended
        if @anim.curFrame == end
            @anim.ended = true

        # Reset animation if loop is set
        if @anim.ended and @anim.loopAnim
            @anim.curFrame = start
            @anim.ended = false
        else if @anim.ended
            @anim.curFrame = end
        else
            # Advance to next frame
            @anim.curFrame += 1


    playAnim: (name, _loop = true) ->
        @anim.curAnim = name
        start = @anim.anims[name][0]
        end   = @anim.anims[name][1]

        @anim.curFrame = start
        @anim.ended = false
        @anim.loopAnim = _loop


    lookAtCamera: ! ->
        camPos = vec3.clone Message.get "cameraPosition"
        pos = vec3.clone @pos
        if camPos
            camPos[1] = 0.0     # Remove y component
            camPos[2] *= -1     # Fix z position

            pos[2] *= -1        # ????? it just works

            dist = vec3.create!
            dist = [ camPos.[0] - pos.[0], 0.0, camPos.[2] - pos.[2] ] 
            vec3.normalize(dist, dist)      # normalize distance

            if dist[0] < 0.0
                @rot[1] = Math.PI + Math.atan(dist[2]/dist[0])

            else
                @rot[1] = Math.atan(dist[2]/dist[0])

            @rot[1] += Math.PI/2        # Fix rotation
