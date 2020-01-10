class window.PaiJimmy extends GameObject
    (gl, pos) ->
        super(gl)

        @name = "paiJimmy"

        @pos = pos

        @texture = Resources.getTexture(gl, "paiJimmy.png") #new Texture(gl, "paiJimmy.png")
        @shader = Resources.getShader(gl, "default")
        @mesh = Resources.getMesh(gl, "cube")

    update: ->
        @rot[1] += -0.01
