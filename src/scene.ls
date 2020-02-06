class window.Scene
    (gl) ->
        @gl = gl
        @objects = new LinkedList!
        @objects.add new Explosion gl, [ 8.0, 0.0,-6.0]
        @objects.add new Xaropinho gl, [-6.0, 1.0,-6.0]
        @objects.add new Xaropinho gl, [ 6.0, 1.0,-6.0]
        @objects.add new Xaropinho gl, [ 6.0, 1.0, 6.0]
        @objects.add new Xaropinho gl, [-8.0, 1.0,-6.0]

        @cenario = new Cenario gl

        @player = new Player gl, [0.0, 1.0, 0.0]

        @input = new Input
        @skybox = new Skybox @gl

        @hud = new HUD gl
        # Setup Render
        @gl.clearColor 0.0, 0.1, 0.1, 1.0
        @gl.clearDepth 1.0

        @gl.enable @gl.DEPTH_TEST
        @gl.depthFunc @gl.LEQUAL

    render: !->
        @gl.clear (@gl.COLOR_BUFFER_BIT .|. @gl.DEPTH_BUFFER_BIT)

        projectionMatrix = @player.camera.getProjectionMatrix!
        viewMatrix = @player.camera.getViewMatrix!

        # Render Scene Objects
        @cenario.render viewMatrix, projectionMatrix

        @objects.each(
            (obj, l) ->
                obj.data.render viewMatrix, projectionMatrix
        )

        # Render Skybox
        @skybox.render viewMatrix, projectionMatrix
        # Render HUD
        @hud.render viewMatrix

    update: !->

        # Update player
        @player.update 1.0

        # Update Score
        Score.update!

        # Get current vel and pos from objs and check collision
        # @ Update Collision system to use linked list
        Collision.check @objects.toArray!, @player

        # Go through the object list updating them and removing
        # the unused objects ( The list method "each()" doesnt work )
        current = @objects.head
        while current != null
            # update current object
            current.data.update!

            # Verify if the obj is ready for deletetion
            if current.data.trash
                # if the current object is the head
                if current == @objects.head
                    # if the list has one element
                    if current.next == current.prev
                        @objects.head = null
                        current.next = null
                    else
                        @objects.head = current.next
                        current.prev.next = current.next
                        current.next.prev = current.prev
                else
                    current.prev.next = current.next
                    current.next.prev = current.prev

            current = current.next
            if current == @objects.head
                current = null

        @hud.update!
