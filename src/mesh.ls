class window.Mesh
    (gl)->
        @gl = gl
        @posBuffer = @newPosBuffer!
        @indexBuffer = @newIndexBuffer!
        @colorBuffer = @newColorBuffer!


    render: (shader) !->
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

        vertexColor = shader.getAttribLocation "aVertexColor" 
        @gl.bindBuffer @gl.ARRAY_BUFFER, @colorBuffer
        @gl.vertexAttribPointer(
            vertexColor,
            3,
            @gl.FLOAT,
            false,
            0,
            0
        )
        @gl.enableVertexAttribArray vertexColor

        shader.use!

        @gl.bindBuffer @gl.ELEMENT_ARRAY_BUFFER, @indexBuffer

        @gl.drawElements(
            @gl.TRIANGLES,
            36,
            @gl.UNSIGNED_SHORT,
            0
        )

    newPosBuffer: ->
        vertices = [
            # Front face
            -1.0, -1.0,  1.0,
             1.0, -1.0,  1.0,
             1.0,  1.0,  1.0,
            -1.0,  1.0,  1.0,

            # Back face
            -1.0, -1.0, -1.0,
            -1.0,  1.0, -1.0,
             1.0,  1.0, -1.0,
             1.0, -1.0, -1.0,

            # Top face
            -1.0,  1.0, -1.0,
            -1.0,  1.0,  1.0,
             1.0,  1.0,  1.0,
             1.0,  1.0, -1.0,

            # Bottom face
            -1.0, -1.0, -1.0,
             1.0, -1.0, -1.0,
             1.0, -1.0,  1.0,
            -1.0, -1.0,  1.0,

            # Right face
             1.0, -1.0, -1.0,
             1.0,  1.0, -1.0,
             1.0,  1.0,  1.0,
             1.0, -1.0,  1.0,

            # Left face
            -1.0, -1.0, -1.0,
            -1.0, -1.0,  1.0,
            -1.0,  1.0,  1.0,
            -1.0,  1.0, -1.0,
        ]

        posBuffer = @gl.createBuffer!
        @gl.bindBuffer @gl.ARRAY_BUFFER, posBuffer
        @gl.bufferData(@gl.ARRAY_BUFFER,
            new Float32Array(vertices),
            @gl.STATIC_DRAW
        )

        posBuffer

    newIndexBuffer: ->
        indices = [
            0,  1,  2,      0,  2,  3,    # front
            4,  5,  6,      4,  6,  7,    # back
            8,  9,  10,     8,  10, 11,   # top
            12, 13, 14,     12, 14, 15,   # bottom
            16, 17, 18,     16, 18, 19,   # right
            20, 21, 22,     20, 22, 23,   # left
        ]

        indexBuffer = @gl.createBuffer!
        @gl.bindBuffer @gl.ELEMENT_ARRAY_BUFFER, indexBuffer
        @gl.bufferData(
            @gl.ELEMENT_ARRAY_BUFFER,
            new Uint16Array(indices),
            @gl.STATIC_DRAW
        )

        indexBuffer

    newColorBuffer: ->
        colors = [
            1.0,  1.0,  1.0,  1.0,    # white
            1.0,  0.0,  0.0,  1.0,    # red
            0.0,  1.0,  0.0,  1.0,    # green
            0.0,  0.0,  1.0,  1.0,    # blue
            1.0,  1.0,  1.0,  1.0,    # white
            1.0,  0.0,  0.0,  1.0,    # red
            0.0,  1.0,  0.0,  1.0,    # green
            0.0,  0.0,  1.0,  1.0,    # blue
            1.0,  1.0,  1.0,  1.0,    # white
            1.0,  0.0,  0.0,  1.0,    # red
            0.0,  1.0,  0.0,  1.0,    # green
            0.0,  0.0,  1.0,  1.0,    # blue
            1.0,  1.0,  1.0,  1.0,    # white
            1.0,  0.0,  0.0,  1.0,    # red
            0.0,  1.0,  0.0,  1.0,    # green
            0.0,  0.0,  1.0,  1.0,    # blue
            1.0,  1.0,  1.0,  1.0,    # white
            1.0,  0.0,  0.0,  1.0,    # red
            0.0,  1.0,  0.0,  1.0,    # green
            0.0,  0.0,  1.0,  1.0,    # blue
        ];
        colorBuffer = @gl.createBuffer!
        @gl.bindBuffer @gl.ARRAY_BUFFER, colorBuffer
        @gl.bufferData(
            @gl.ARRAY_BUFFER,
            new Float32Array(colors),
            @gl.STATIC_DRAW
        )

        colorBuffer
