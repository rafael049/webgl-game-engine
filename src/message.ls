class window.Message
    @mailbox = {}

    @send = (name, value) !->
        @@mailbox[name] = value

    @get = (name) ->
        @@mailbox[name]
