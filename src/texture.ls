class window.Texture
    (gl, filename) ->
        @gl = gl
        @id = @createTexture "../assets/images/#{filename}"

    use: ->
        @gl.bindTexture @gl.TEXTURE_2D, @id

    createDefaultTexture: ->
        id = @gl.createTexture!
        @gl.bindTexture @gl.TEXTURE_2D, id

        @gl.pixelStorei(@gl.UNPACK_ALIGNMENT, 1)
        @gl.texImage2D(
            @gl.TEXTURE_2D,
            0,
            @gl.R8,
            2, 2,
            0,
            @gl.RED,
            @gl.UNSIGNED_BYTE,
            new Uint8Array([128, 64,  0, 192])
        )
        @gl.texParameteri(@gl.TEXTURE_2D, @gl.TEXTURE_WRAP_S, @gl.REPEAT)
        @gl.texParameteri(@gl.TEXTURE_2D, @gl.TEXTURE_WRAP_T, @gl.REPEAT)
        @gl.texParameteri(@gl.TEXTURE_2D, @gl.TEXTURE_MIN_FILTER, @gl.NEAREST)
        @gl.texParameteri(@gl.TEXTURE_2D, @gl.TEXTURE_MAG_FILTER, @gl.NEAREST)

        id

    createTexture: (name) ->
        id = @createDefaultTexture!
        gl = @gl
        @gl.bindTexture @gl.TEXTURE_2D, id

        image = new Image

        image.onload = ->
            gl.bindTexture gl.TEXTURE_2D, id

            gl.texImage2D(
                gl.TEXTURE_2D,
                0,
                gl.RGBA,
                gl.RGBA,
                gl.UNSIGNED_BYTE,
                image
            )

            if (isPowerOf2 image.width) and (isPowerOf2 image.height)
                gl.generateMipmap gl.TEXTURE_2D

            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE)
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE)
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST)
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST)

        image.src = name

        id

#    createCubemap: (name) ->
#        id = @createDefaultTexture!
#        gl = @gl
#
#        images = new Array(6)
#
#        for i from 0 til 6
#            images[i] = new Image()
#        # Face 0
#        images[0].onload = ->
#            gl.bindTexture gl.TEXTURE_CUBE_MAP, id
#            gl.texImage2D(
#                gl.TEXTURE_CUBE_MAP_POSITIVE_X,
#                0,
#                gl.RGB,
#                gl.RGB,
#                gl.UNSIGNED_BYTE,
#                images[0]
#            )
#        # Face 1
#        images[1].onload = ->
#            gl.bindTexture gl.TEXTURE_CUBE_MAP, id
#            gl.texImage2D(
#                gl.TEXTURE_CUBE_MAP_POSITIVE_X + 1,
#                0,
#                gl.RGB,
#                gl.RGB,
#                gl.UNSIGNED_BYTE,
#                images[1]
#            )
#        # Face 2
#        images[2].onload = ->
#            gl.bindTexture gl.TEXTURE_CUBE_MAP, id
#            gl.texImage2D(
#                gl.TEXTURE_CUBE_MAP_POSITIVE_X + 2,
#                0,
#                gl.RGB,
#                gl.RGB,
#                gl.UNSIGNED_BYTE,
#                images[2]
#            )
#        # Face 3
#        images[3].onload = ->
#            gl.bindTexture gl.TEXTURE_CUBE_MAP, id
#            gl.texImage2D(
#                gl.TEXTURE_CUBE_MAP_POSITIVE_X + 3,
#                0,
#                gl.RGB,
#                gl.RGB,
#                gl.UNSIGNED_BYTE,
#                images[3]
#            )
#        # Face 4
#        images[4].onload = ->
#            gl.bindTexture gl.TEXTURE_CUBE_MAP, id
#            gl.texImage2D(
#                gl.TEXTURE_CUBE_MAP_POSITIVE_X + 4,
#                0,
#                gl.RGB,
#                gl.RGB,
#                gl.UNSIGNED_BYTE,
#                images[4]
#            )
#        # Face 5
#        images[5].onload = ->
#            gl.bindTexture gl.TEXTURE_CUBE_MAP, id
#            gl.texImage2D(
#                gl.TEXTURE_CUBE_MAP_POSITIVE_X + 5,
#                0,
#                gl.RGB,
#                gl.RGB,
#                gl.UNSIGNED_BYTE,
#                images[5]
#            )
#
#            gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE)
#            gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE)
#            gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_WRAP_R, gl.CLAMP_TO_EDGE)
#            gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
#            gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
#
#        for i from 0 to 5
#            images[i].src = "#{name}#{i+1}.JPG"
#
#        id
#
#    createDefaultCubemap: ->
#        id = @gl.createTexture!
#        @gl.bindTexture @gl.TEXTURE_CUBE_MAP, id
#
#        @gl.pixelStorei(@gl.UNPACK_ALIGNMENT, 1)
#        for i from 0 to 5
#            @gl.texImage2D(
#                @gl.TEXTURE_CUBE_MAP_POSITIVE_X + i,
#                0,
#                @gl.R8,
#                2, 2,
#                0,
#                @gl.RED,
#                @gl.UNSIGNED_BYTE,
#                new Uint8Array([128, 64,  0, 192])
#            )
#        @gl.texParameteri(@gl.TEXTURE_CUBE_MAP, @gl.TEXTURE_WRAP_S, @gl.REPEAT)
#        @gl.texParameteri(@gl.TEXTURE_CUBE_MAP, @gl.TEXTURE_WRAP_T, @gl.REPEAT)
#        @gl.texParameteri(@gl.TEXTURE_CUBE_MAP, @gl.TEXTURE_MIN_FILTER, @gl.NEAREST)
#        @gl.texParameteri(@gl.TEXTURE_CUBE_MAP, @gl.TEXTURE_MAG_FILTER, @gl.NEAREST)
#
#        id


    isPowerOf2 = (value) ->
        (value .&. (value-1)) == 0

