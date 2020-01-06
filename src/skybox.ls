class window.Skybox extends GameObject
    (gl) ->
        super(gl)

        @name = "skybox"

        @pos = [0.0, 0.0, 0.0]

        @texture = Resources.getTexture gl, "skybox.png"
        @shader = Resources.getShader gl, "skybox"
        @mesh = Resources.getMesh gl, "skybox"

    update: !->
        1 == 1
