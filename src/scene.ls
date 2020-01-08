class window.Scene
    (gl) ->
        @gl = gl
        @objects = []
        @objects.push new PaiJimmy gl, [0, 0,-6]
        @objects.push new PaiJimmy gl, [0, 3, 6]
        @objects.push new Sprite gl, [0.0, 0.0, 0.0]

        @input = new Input
        @camera = new Camera(@gl)
        @audio = new AudioManager
        @skybox = new Skybox @gl
        #@audio.playSound "rapaiz.mp3"
        #@audio.playSound "irra.mp3"
            #AudioManager.playSound "rapaiz.mp3"

        # Setup Render
        @gl.clearColor 0.0, 0.1, 0.1, 1.0
        @gl.clearDepth 1.0

        @gl.enable @gl.DEPTH_TEST
        #@gl.enable @gl.CULL_FACE
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

    update: !->
        @camera.update!

        for obj in @objects
            obj.update!

        if Input.keys[32]
            AudioManager.playSound "rapaiz.mp3"
