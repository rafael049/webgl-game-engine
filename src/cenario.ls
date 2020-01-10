class window.Cenario extends GameObject
    (gl) ->
        super(gl)
        @name = "cenario"

        @pos = [0.0, 0.0, 0.0]

        @texture = Resources.getTexture(gl, "cenario.png") #new Texture(gl, "paiJimmy.png")
        @shader = Resources.getShader(gl, "default")
        @mesh = Resources.getMesh(gl, "cenario")

    update: ->
        1 == 1
