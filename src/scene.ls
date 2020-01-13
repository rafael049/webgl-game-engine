class window.Scene
    (gl) ->
        @gl = gl
        @objects = []
        @objects.push new Xaropinho gl, [-6.0, 0.0,-6.0]
        @objects.push new Explosion gl, [ 6.0, 0.0,-6.0]
        @objects.push new Cenario gl

        @input = new Input
        @camera = new Camera(@gl)
        @camera.pos = [0.0, 2.0, 12.0]
        @audio = new AudioManager
        @skybox = new Skybox @gl

        @hud = new HUD gl
        # Setup Render
        @gl.clearColor 0.0, 0.1, 0.1, 1.0
        @gl.clearDepth 1.0

        @gl.enable @gl.DEPTH_TEST
        @gl.depthFunc @gl.LEQUAL

    render: !->
        @gl.clear (@gl.COLOR_BUFFER_BIT .|. @gl.DEPTH_BUFFER_BIT)

        projectionMatrix = @camera.getProjectionMatrix!
        viewMatrix = @camera.getViewMatrix!

        # Render Scene Objects
        for obj in @objects
            obj.render viewMatrix, projectionMatrix

        # Render Skybox
        @skybox.render viewMatrix, projectionMatrix
        # Render HUD
        @hud.render viewMatrix

    update: !->
        @camera.update!

        for obj in @objects
            obj.update!

        if Input.keys[32]
            AudioManager.playSound "rapaiz.mp3"
