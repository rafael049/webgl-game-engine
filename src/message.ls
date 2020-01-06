class window.Message
    @mailbox = {}

    @send = (name, value) !->
        mailbox[name] = value

    @read = (name) ->
        mailbox[name]
