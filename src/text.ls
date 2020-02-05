class window.Text
    (value, font, pos, size, color = "\#ffffff", shadow = false, width = 400) ->
        @pos = pos
        @value = value

        overlayElement = document.getElementById "overlay"

        @texElement = document.createElement "SPAN"
        @node = document.createTextNode @value

        overlayElement.appendChild @texElement

        @texElement.appendChild @node
        @texElement.style.position = "absolute"
        @texElement.style.width = width + "px"
        @texElement.style.font-family = font
        @texElement.style.font-size = size + "px"
        if shadow then @texElement.style.text-shadow = "1px 1px 2px black"

        @setPos pos
        @setColor color

    setText: (txt) ->
        @node.data = txt

    setColor: (color) ->
        @texElement.style.color = color

    setPos: (pos) ->
        @texElement.style.left = pos[0] + "px"
        @texElement.style.top  = pos[1] + "px"

