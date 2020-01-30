class window.WeaponHud
    (gl) ->
        @sprite = new SpriteHUD gl, [1.2, -2.1, -0.1]

    render: (projectionMatrix) ->
        @sprite.render projectionMatrix

    update: ->
        if Input.onKeydown(70)
            @sprite.playAnim "Shot", false
            AudioManager.playSound "tiro.mp3"

            cameraPos = Message.get "cameraPosition"
            cameraDir = Message.get "cameraFrontVec"
            Collision.raycast cameraPos, cameraDir, 1
