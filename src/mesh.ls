class window.Mesh
    (gl, name)->
        @gl = gl

        data = loadMesh(name)

        @numVertices = data.numVertices
        @posBuffer = @newPosBuffer data
        @indexBuffer = @newIndexBuffer data
        @texCoordBuffer = @newTexCoordBuffer data


    render: (shader, texture) !->
        vertexPosition = shader.getAttribLocation "aVertexPosition"
        @gl.bindBuffer @gl.ARRAY_BUFFER, @posBuffer
        @gl.vertexAttribPointer(
            vertexPosition,
            3,
            @gl.FLOAT,
            false,
            0,
            0
        )
        @gl.enableVertexAttribArray vertexPosition

        texCoord = shader.getAttribLocation "aTexCoord"
        @gl.bindBuffer @gl.ARRAY_BUFFER, @texCoordBuffer
        @gl.vertexAttribPointer(
            texCoord,
            2,
            @gl.FLOAT,
            false,
            0,
            0
        )

        @gl.enableVertexAttribArray texCoord

        shader.use!

        #@gl.bindBuffer @gl.ELEMENT_ARRAY_BUFFER, @indexBuffer

        @gl.drawArrays(
            @gl.TRIANGLES,
            0,
            @numVertices
        )

    newPosBuffer: (data) ->
        vertices = data.vertex

        posBuffer = @gl.createBuffer!
        @gl.bindBuffer @gl.ARRAY_BUFFER, posBuffer
        @gl.bufferData(@gl.ARRAY_BUFFER,
            new Float32Array(vertices),
            @gl.STATIC_DRAW
        )

        posBuffer

    newIndexBuffer: (data) ->
        indices = data.vertexIndex

        indexBuffer = @gl.createBuffer!
        @gl.bindBuffer @gl.ELEMENT_ARRAY_BUFFER, indexBuffer
        @gl.bufferData(
            @gl.ELEMENT_ARRAY_BUFFER,
            new Uint16Array(indices),
            @gl.STATIC_DRAW
        )

        indexBuffer

    newTexCoordBuffer: (data) ->
        textureCoordinates = data.texCoord

        texCoordBuffer = @gl.createBuffer!
        @gl.bindBuffer @gl.ARRAY_BUFFER, texCoordBuffer
        @gl.bufferData(
            @gl.ARRAY_BUFFER,
            new Float32Array(textureCoordinates),
            @gl.STATIC_DRAW
        )

        texCoordBuffer
