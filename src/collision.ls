class window.Collision
    X_BOUNDS = 24.0
    Y_BOUNDS = 15.0
    @objs = []

    @check = (objs, player) ->
        @objs = objs

        player.collidingWith = []
        @checkBounds player

        for obj in objs
            @checkBounds obj

        quad = new Quad(-X_BOUNDS, -Y_BOUNDS, 2*X_BOUNDS, 2*Y_BOUNDS)
        quadTree = new QuadTree objs.concat(player), quad

        @checkCollisionFromTree quadTree


    @checkBounds = (obj) ->
        x = obj.pos[0]
        y = obj.pos[2]
        vx = obj.vel[0]
        vy = obj.vel[2]

        _x = x + vx # next x position
        _y = y + vy # next y position

        if Math.abs(_x) > X_BOUNDS
            obj.vel[0] = 0

        if Math.abs(_y) > Y_BOUNDS
            obj.vel[2] = 0

        if x > X_BOUNDS
            obj.pos[0] = X_BOUNDS
        else if x < -X_BOUNDS
            obj.pos[0] = -X_BOUNDS
        if y > X_BOUNDS
            obj.pos[2] = Y_BOUNDS
        else if y < -Y_BOUNDS
            obj.pos[2] = -Y_BOUNDS


    @checkCollisionFromTree = (quadTree) ->
        if not quadTree
            return

        for i from 0 til quadTree.objs.length

            curObj = quadTree.objs.pop!
            otherObjs = @getTreeElements quadTree

            for otherObj in otherObjs
                @checkCollision curObj, otherObj

        @checkCollisionFromTree quadTree.node1
        @checkCollisionFromTree quadTree.node2
        @checkCollisionFromTree quadTree.node3
        @checkCollisionFromTree quadTree.node4


    @checkCollision = (obj1, obj2) ->
        x1 = obj1.pos[0] + obj1.vel[0]
        y1 = obj1.pos[2] + obj1.vel[2]

        x2 = obj2.pos[0] + obj2.vel[0]
        y2 = obj2.pos[2] + obj2.vel[2]

        if Math.sqrt( (x1 - x2)^2 + (y1 - y2)^2 ) < (obj1.radius + obj2.radius)
            normal = vec3.create!
            vec3.sub(normal, obj2.pos, obj1.pos) # vetor do obj1 para obj2
            vec3.normalize(normal, normal)

            dot1 = vec3.dot(obj1.vel, normal)
            dot2 = vec3.dot(obj2.vel, normal)

            cancelVel1 = []
            vec3.scale(cancelVel1, normal, dot1)
            cancelVel2 = []
            vec3.scale(cancelVel2, normal, dot2)

            vec3.sub(obj1.pos, obj1.pos, cancelVel1)
            vec3.sub(obj2.pos, obj2.pos, cancelVel2)



    @getTreeElements = (quadTree) ->
        if not quadTree
            []
        else
            quadTree.objs ++
            @getTreeElements(quadTree.node1) ++
            @getTreeElements(quadTree.node2) ++
            @getTreeElements(quadTree.node3) ++
            @getTreeElements(quadTree.node4)

    @raycast = (origin, dir, n) ->
        caughtObjs = []
        for obj in @objs
            dist = @distFromStraight origin, dir, obj

            if dist < obj.radius
                if obj.playAnim
                    obj.state = "Hurt"

    @distFromStraight = (origin, dir, obj) ->
        sub = []
        vec3.sub(sub, obj.pos, origin)
        cross = []
        vec3.cross(cross, dir, sub)
        len1 = vec3.len(cross)
        len2 = vec3.len(dir)

        len1/len2




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
    (objs, quad, level = 0) ->
        @objs = []

        if objs.length == 0
            @node1 = null
            @node2 = null
            @node3 = null
            @node4 = null
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


        if objs1
            @node1 = new QuadTree objs1, bound1, level+1
        else
            @node1 = null

        if objs2
            @node2 = new QuadTree objs2, bound1, level+1
        else
            @node1 = null

        if objs3
            @node3 = new QuadTree objs3, bound1, level+1
        else
            @node3 = null

        if objs4
            @node4 = new QuadTree objs4, bound4, level+1
        else
            @node4 = null






