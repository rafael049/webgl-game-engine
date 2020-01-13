class gunHUD extends Sprite
    (gl, pos) ->
        super gl, pos
        @texture = Resources.getTexture gl, "doomPistol.png"
        @anim.xTiles = 3
        @anim.yTiles = 2

    render:(projectionMatrix) ->
        viewMatrix = mat4.create!
        mat4.identity viewMatrix
        #mat4.identity projectionMatrix
        console.log "Era pra desenhar alguma coisa"
        super viewMatrix, projectionMatrix



class window.HUD
    (gl) ->
        @gl = gl
        @gun = new gunHUD gl, [1.2, -2.1,-0.1]
        @text = new Text "Puta dor nas costas socorro", "Lucidas Console", [100, 300], 32, "\#ffffff", true

    render: ->
        orthoProjectionMatrix = mat4.create!
        mat4.ortho orthoProjectionMatrix, -2.0, 2.0, -2.0, 2.0, 0.1, 5.0
        @gun.render orthoProjectionMatrix

