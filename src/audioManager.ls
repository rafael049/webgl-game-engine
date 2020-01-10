class window.AudioManager
    sounds = {}
    soundChannels = []
    trackChannel = void
    NUM_CHANNELS = 1
    currentChannel = 0


    @playSound = (name) ->
        audio = Resources.getAudio name
        audio.play!
        soundChannels[currentChannel % NUM_CHANNELS] = audio
        currentChannel += 1

    @playTrack = (name) ->
        trackChannel = Resources.getAudio name
        trackChannel.play!
