// Generated by LiveScript 1.6.0
(function(){
  var AudioManager;
  window.AudioManager = AudioManager = (function(){
    AudioManager.displayName = 'AudioManager';
    var sounds, soundChannels, trackChannel, NUM_CHANNELS, currentChannel, prototype = AudioManager.prototype, constructor = AudioManager;
    sounds = {};
    soundChannels = [];
    trackChannel = void 8;
    NUM_CHANNELS = 1;
    currentChannel = 0;
    AudioManager.playSound = function(name){
      var audio;
      audio = Resources.getAudio(name);
      audio.play();
      soundChannels[currentChannel % NUM_CHANNELS] = audio;
      return currentChannel += 1;
    };
    AudioManager.playTrack = function(name){
      var trackChannel;
      trackChannel = Resources.getAudio(name);
      return trackChannel.play();
    };
    function AudioManager(){}
    return AudioManager;
  }());
}).call(this);