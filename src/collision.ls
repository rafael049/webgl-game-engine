class window.Collision
    X_BOUNDS = 24.0
    Y_BOUNDS = 15.0
    @check = (objs, player) ->
        player.collidingWith = []
        @checkBounds player

    @checkBounds = (obj) ->
        x = obj.pos[0] + obj.vel[0] # next x position
        y = obj.pos[2] + obj.vel[2] # next y position

        if Math.abs(x) > X_BOUNDS
            obj.vel[0] = 0

        if Math.abs(y) > Y_BOUNDS
            obj.vel[2] = 0

