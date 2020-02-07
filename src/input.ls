class window.Input
    @keys = []
    @_keys = []
    @keysTap = []
    @mouseMove = [0.0, 0.0]

    ->
        window.addEventListener 'keydown', @keydownCallback
        window.addEventListener 'keyup', @keyupCallback
        window.addEventListener 'mousemove', @mouseCallback

        window.addEventListener 'click', ->
            document.body.requestPointerLock!

    update: ! ->
        @@mouseMove = [0.0, 0.0]

    keydownCallback: (e) ->
        if not e.repeat
            @@_keys[e.keyCode] = true
            @@keys[e.keyCode] = true

    keyupCallback: (e) ->
        @@keys[e.keyCode] = false

    @onKeydown = (key) ->
        if @@_keys[key]
            @@_keys[key] = false
            true
    mouseCallback: (e) ->
        @@mouseMove[0] = e.movementX
        @@mouseMove[1] = e.movementY



