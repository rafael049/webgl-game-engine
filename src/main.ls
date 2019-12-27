glsl_scripts = ["default"]
js_scripts = ["shader" "game" "gl-matrix"]

mainScript = document.getElementById "main_script"

for f in glsl_scripts
    script = document.createElement "SCRIPT"
    script.src = "assets/shaders/" +  f + ".vs"
    script.type = "x-shader/x-vertex"
    script.id = f + ".vs"
    document.body.insertBefore script, document.body.childNodes[0]

    script = document.createElement "SCRIPT"
    script.src = "assets/shaders/" + f + ".fs"
    script.type = "x-shader/x-fragment"
    script.id = f + ".fs"
    document.body.insertBefore script, document.body.childNodes[0]
#
#for f in js_scripts
#    script = document.createElement "SCRIPT"
#    script.src = "src/" + f + ".js"
#    document.body.insertBefore script, document.body.childNodes[0]

game = new Game

game.start!

render = ->
    game.render!
    game.update!
    requestAnimationFrame render

render!
