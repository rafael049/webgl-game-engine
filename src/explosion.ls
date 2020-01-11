class window.Explosion extends Sprite
    (gl, pos) ->
        super(gl, pos)
        @name = "explosion"
        @texture = Resources.getTexture(gl, "explosion.png")

