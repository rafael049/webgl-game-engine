class window.AudioManager
    @audioBuffers = null
    @ctx = null
    (ctx) ->

        @@ctx = ctx
        @@audioBuffers = new Buffer ctx, "assets/audio/tiro.mp3"


    @playSound = (name) ->
        sound = new Sound @@ctx, @@audioBuffers.buffers[name]
        sound.play!

class Buffer
    (ctx, path) ->
        @ctx = ctx
        @paths =
            [ "rapaiz.mp3"
            , "tiro.mp3"
            , "batSwing.mp3"
            , "irra.mp3"
            , "peludao.opus"
            , "ratinho.mp3"
            , "esse_e_meu_patrao.mp3"
            , "uepa.mp3"
            , "va_com_deus.opus"
            , "aow_potencia.m4a"
            , "cavalo.m4a"
            , "jesus.m4a"
            , "calma.m4a"
            , "ai.m4a"
            , "danca_gatinho.m4a"
            ]
        @buffers = {}
        @ready = false

        for path in @paths
            @loadSound path

    loadSound: (filename) ->
        fullPath = "assets/audio/" + filename
        request = new XMLHttpRequest!
        request.open 'get', fullPath, true
        request.responseType = 'arraybuffer'
        thisBuffer = this
        request.onload = ! ->
            thisBuffer.ctx.decodeAudioData(request.response, (buffer) ->
                thisBuffer.buffers[filename] = buffer
            )
        request.send!

class Sound
    (ctx, buffer) ->
        @ctx = ctx
        @buffer = buffer

    init: ->
        @gainNode = @ctx.createGain!
        @gainNode.gain.value = 0.8
        @source = @ctx.createBufferSource!
        @source.buffer = @buffer
        @source.connect @gainNode
        @gainNode.connect @ctx.destination

    play: ->
        @init!
        @source.start @ctx.currentTime

