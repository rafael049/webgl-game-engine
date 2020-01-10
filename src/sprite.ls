class window.Sprite extends GameObject
    (gl, pos) ->
        super(gl)
        @name = "xaropinho"

        @pos = pos

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")
        @shader = Resources.getShader(gl, "sprite")
        @mesh = Resources.getMesh(gl, "sprite1")

    update: ->
        camPos = vec3.clone Message.get "cameraPosition"
        #console.log "CameraPosition: #{camPos[0]}, #{camPos[2]}"
        #console.log "angle: #{@rot[1]}"
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
