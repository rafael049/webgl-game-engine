game = new Game

game.start!

render = ->
    game.render!
    game.update!
    requestAnimationFrame render

render!




















