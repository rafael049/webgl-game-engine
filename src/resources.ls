class window.Resources
    @meshes = {}
    @textures = {}
    @shaders = {}
    @images = {}
    @audio = {}

    @getMesh = (gl, name) ->
        if @meshes[name]
            @meshes[name]
        else
            @meshes[name] = new Mesh(gl, name)
            @meshes[name]

    @getTexture = (gl, name, cubemap = false) ->
        if @textures[name]
            @textures[name]
        else
            @textures[name] = new Texture(gl, name, cubemap)
            @textures[name]


    @getShader = (gl, name) ->
        if @shaders[name]
            @shaders[name]
        else
            @shaders[name] = new Shader(gl, name)
            @shaders[name]

    @getAudio = (name) ->
        if @audio[name]
            @audio[name]
        else
            audio = document.createElement "AUDIO"
            audio.src = "assets/audio/#{name}"
            @audio[name] = audio
            @audio[name]
