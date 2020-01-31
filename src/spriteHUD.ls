class window.SpriteHUD extends Sprite
    (gl, pos) ->
        # Call base constructor
        super gl, pos

        # Set texture
        @texture = Resources.getTexture gl, "doomPistol.png"

        # Configure texture tiles
        @anim.xTiles = 3
        @anim.yTiles = 2

        # Define animations
        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Shot"] = [0, 5]
        @anim.curAnim = "Idle"


    render:(projectionMatrix) ->
        viewMatrix = mat4.create!
        mat4.identity viewMatrix
        super viewMatrix, projectionMatrix