class window.Game
    ->
        @canvas = document.getElementById "canvas"
        @screenWidth = canvas.width
        @screenHeight = canvas.height
        @gl = canvas.getContext "webgl2"
        @gl.viewportWidth = canvas.width
        @gl.viewportHeight = canvas.height

        @audioCtx = new window.AudioContext
        @audio = new AudioManager @audioCtx

    start: ->
        @scene1 = new Scene(@gl)


    render: !->
        @scene1.render!


    update: ->
        @scene1.update!
