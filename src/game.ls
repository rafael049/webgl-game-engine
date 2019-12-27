teste = "oi"
class window.Game
    ->
        @canvas = document.getElementById "canvas"
        @screenWidth = canvas.width
        @screenHeight = canvas.height
        @gl = canvas.getContext "webgl"
        @gl.viewportWidth = canvas.width
        @gl.viewportHeight = canvas.height
        console.log "tudo show"

    start: ->
        @input = new Input
        @object = new GameObject(@gl)
        @object.setPosition([0.0, 0.0, -6.0])
        @camera = new Camera(@gl)


    render: !->
        @gl.clearColor 0.0, 0.1, 0.1, 1.0
        @gl.clearDepth 1.0
        @gl.enable @gl.DEPTH_TEST
        @gl.depthFunc @gl.LEQUAL
        @gl.clear @gl.COLOR_BUFFER_BIT
        projectionMatrix = @camera.getProjectionMatrix!
        viewMatrix = @camera.getViewMatrix!
        @object.render viewMatrix, projectionMatrix


    update: ->
        @camera.update!
        if Input.keys[37]
            @object.rot[1] += 0.01
