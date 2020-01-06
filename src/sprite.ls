class window.Sprite extends GameObject
    (gl, pos) ->
        super(gl)
        @name = "xaropinho"

        @pos = pos

        @texture = Resources.getTexture(gl, "xaropinho.png") #new Texture(gl, "paiJimmy.png")
        @shader = Resources.getShader(gl, "sprite")
        @mesh = Resources.getMesh(gl, "sprite1")

    update: ->
        @rot[1] = 0.0
