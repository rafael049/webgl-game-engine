class window.SpriteHUD extends Sprite
    (gl, pos) ->
        # Call base constructor
        super gl, pos

    render:(projectionMatrix) ->
        viewMatrix = mat4.create!
        mat4.identity viewMatrix
        super viewMatrix, projectionMatrix

class window.PistolSprite extends SpriteHUD
    (gl) ->
        # Call base constructor
        pos = [1.2, -1.1, -0.1]
        super gl, pos

        @texture = Resources.getTexture gl, "doomPistol.png"

        @anim.xTiles = 3
        @anim.yTiles = 2

        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Shot"] = [0, 5]
        @anim.curAnim = "Idle"

class window.CaceteteSprite extends SpriteHUD
    (gl) ->
        # Call base constructor
        pos = [0.8, -1.1, -0.1]
        super gl, pos

        # Correct aspect ratio
        @sca[0] = 1.4
        @texture = Resources.getTexture gl, "doomBat.png"

        @anim.xTiles = 15
        @anim.yTiles = 1

        @anim.anims["Idle"] = [0, 0]
        @anim.anims["Shot"] = [0, 9]
        @anim.curAnim = "Idle"
