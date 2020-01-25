class window.Input
    @keys = []
    @_keys = []
    @keysTap = []

    ->
        window.addEventListener 'keydown', @keydownCallback
        window.addEventListener 'keyup', @keyupCallback

    keydownCallback: (e) ->
        if not e.repeat
            @@_keys[e.keyCode] = true
            @@keys[e.keyCode] = true
            console.log "Keydown"

    keyupCallback: (e) ->
        @@keys[e.keyCode] = false

    @onKeydown = (key) ->
        if @@_keys[key]
            @@_keys[key] = false
            true



