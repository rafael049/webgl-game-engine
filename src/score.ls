class window.Score
    @score = 1000
    @lastUpdateMoment = 0
    @combo = 0

    @add = (value) ->
        timeInterval = Date.now! - @@lastUpdateMoment


        if timeInterval < 2500
            @@combo += 1
        else
            @@combo = 0

        # Update last moment
        @@lastUpdateMoment = Date.now!

        switch @@combo
        case 1
            AudioManager.playSound "irra.mp3"
        case 2
            AudioManager.playSound "jesus.m4a"
        case 3
            AudioManager.playSound "cavalo.m4a"
        case 4
            AudioManager.playSound "calma.m4a"
        case 5
            AudioManager.playSound "esse_e_meu_patrao.mp3"

        @@score += value * (@@combo+1)

        console.log @@combo

    @update = ! ->
        if @@score > 0 and Math.random! < 0.1
            @@score += Math.round (Math.random! * 8 - 4)
