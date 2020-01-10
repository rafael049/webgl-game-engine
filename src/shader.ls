prelude = require "prelude-ls"

class window.Shader
    (gl, name) ->
        @gl = gl
        @vertexShader = @createShader (name ++ ".vs")
        @fragShader = @createShader (name ++ ".fs")
        @program = @createProgram!


    createShader: (name) ->
        source_str = loadTextFile ("assets/shaders/#{name}")
        shader = void

        extension = prelude.drop-while (!== '.'), name

        if extension == ".fs"
            shader = @gl.createShader @gl.FRAGMENT_SHADER
        else if extension == ".vs"
            shader = @gl.createShader @gl.VERTEX_SHADER
        else
            console.log "Unknow shader type"
            return null

        @gl.shaderSource shader, source_str
        @gl.compileShader shader

        if not @gl.getShaderParameter shader, @gl.COMPILE_STATUS
            info = @gl.getShaderInfoLog shader
            console.log "Failed to compile shader " + name + "\n" + info
            @gl.deleteShader shader
            return null

        shader

    createProgram: ->
        shaderProgram = @gl.createProgram!

        @gl.attachShader shaderProgram, @vertexShader
        @gl.attachShader shaderProgram, @fragShader
        @gl.linkProgram shaderProgram

        if not @gl.getProgramParameter shaderProgram, @gl.LINK_STATUS
            info = @gl.getProgramInfoLog shaderProgram
            console.log "Shaders cannot be initialized" + "\n" + info

        @gl.useProgram shaderProgram ###POLEMICO

        shaderProgram

    use: !->
        @gl.useProgram @program

    getAttribLocation: (name) ->
        @use!
        @gl.getAttribLocation @program, name

    getUniformLocation: (name) ->
        @use!
        @gl.getUniformLocation @program, name

    setLocal: (mat) !->
        @gl.uniformMatrix4fv(
            @getUniformLocation("uLocalMat"),
            false,
            mat
        )

    setModel: (mat) !->
        @gl.uniformMatrix4fv(
            @getUniformLocation("uModelMat"),
            false,
            mat
        )

    setView: (mat) !->
        @gl.uniformMatrix4fv(
            @getUniformLocation("uViewMat"),
            false,
            mat
        )

    setProjection: (mat) !->
        @gl.uniformMatrix4fv(
            @getUniformLocation("uProjectionMat"),
            false,
            mat
        )

    setTexture: (id) ->
        @gl.uniform1i(
            @getUniformLocation("uTexture"),
            id
        )

    loadTextFile = (path) ->
        result = void
        xmlhttp = new XMLHttpRequest
        xmlhttp.async = false
        xmlhttp.open "GET", path, false
        xmlhttp.send!

        if xmlhttp.status == 200
            result = xmlhttp.responseText

        return result
