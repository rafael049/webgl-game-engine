class Quad
    (x, y, w, h) ->
        @x = x
        @y = y
        @w = w
        @h = h

    isInside: (x, y, r) ->
        if  x - r > @x and 
            x + r < @x + @w and 
            y - r > @y and 
            y + r < @y + @h

            true
        else
            false

class QuadTree
    (objs, quad) ->
        @objs = []

        if objs.length == 0
            node1 = null
            node2 = null
            node3 = null
            node4 = null
            return

        bound1 = new Quad(
            quad.x + quad.w/2,
            quad.y + quad.h/2,
            quad.w/2,
            quad.h/2
        )
        bound2 = new Quad(
            quad.x,
            quad.y + quad.h/2,
            quad.w/2,
            quad.h/2
        )
        bound3 = new Quad(
            quad.x,
            quad.y,
            quad.w/2,
            quad.h/2
        )
        bound4 = new Quad(
            quad.x + quad.w/2,
            quad.y,
            quad.w/2,
            quad.h/2
        )

        objs1 = []
        objs2 = []
        objs3 = []
        objs4 = []


        for obj in objs
            x = obj.pos[0] + obj.vel[0]
            y = obj.pos[2] + obj.vel[2]
            r = 1.0 # obj.radius

            if bound1.isInside x, y, r
                objs1.push obj
            else if bound2.isInside x, y, r
                objs2.push obj
            else if bound3.isInside x, y, r
                objs3.push obj
            else if bound4.isInside x, y, r
                objs4.push obj
            else
                @objs.push obj


        @node1 = new QuadTree objs1, bound1
        @node2 = new QuadTree objs2, bound2
        @node3 = new QuadTree objs3, bound3
        @node4 = new QuadTree objs4, bound4


class window.Collision
    X_BOUNDS = 24.0
    Y_BOUNDS = 15.0
    @check = (objs, player) ->
        player.collidingWith = []
        @checkBounds player

        quad = new Quad(-X_BOUNDS, -Y_BOUNDS, 2*X_BOUNDS, 2*Y_BOUNDS)
        window.quadTree = new QuadTree objs, quad

    @checkBounds = (obj) ->
        x = obj.pos[0] + obj.vel[0] # next x position
        y = obj.pos[2] + obj.vel[2] # next y position

        if Math.abs(x) > X_BOUNDS
            obj.vel[0] = 0

        if Math.abs(y) > Y_BOUNDS
            obj.vel[2] = 0

