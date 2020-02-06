class window.Score
    @score = 1000
    @lastUpdateMoment = Date.now!
    @combo = 0

    @add = (value) ->
        timeInterval = Date.now! - @@lastUpdateMoment


        if timeInterval < 5000
            @@combo += 1
            @@lastUpdateMoment = Date.now!
        else
            @@combo = 0

        switch @@combo
        case 1
            AudioManager.playSound "irra.mp3"
        case 2
            AudioManager.playSound "rapaiz_kisse.ogg"

        @@score += value

        console.log @@combo

    @update = ! ->
        if @@score > 0 and Math.random! < 0.1
            @@score += Math.round (Math.random! * 8 - 4)
