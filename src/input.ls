class window.Input
    @keys = []
    ->
        window.addEventListener 'keydown', @keydownCallback
        window.addEventListener 'keyup', @keyupCallback

    keydownCallback: (e) ->
        @@keys[e.keyCode] = true

    keyupCallback: (e) ->
        @@keys[e.keyCode] = false

