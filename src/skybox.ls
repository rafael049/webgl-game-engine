class window.Skybox extends GameObject
    (gl) ->
        super(gl)

        @name = "skybox"

        @pos = [0.0, 0.0, 0.0]

        @texture = Resources.getTexture(gl, "sea", true)
        @shader = Resources.getShader(gl, "default")
        @mesh = Resources.getMesh(gl, "cube")

    update: !->
        1 == 1
