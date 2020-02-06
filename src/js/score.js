// Generated by LiveScript 1.6.0
(function(){
  var Score;
  window.Score = Score = (function(){
    Score.displayName = 'Score';
    var prototype = Score.prototype, constructor = Score;
    Score.score = 1000;
    Score.lastUpdateMoment = Date.now();
    Score.combo = 0;
    Score.add = function(value){
      var timeInterval;
      timeInterval = Date.now() - constructor.lastUpdateMoment;
      if (timeInterval < 5000) {
        constructor.combo += 1;
        constructor.lastUpdateMoment = Date.now();
      } else {
        constructor.combo = 0;
      }
      switch (constructor.combo) {
      case 1:
        AudioManager.playSound("irra.mp3");
        break;
      case 2:
        AudioManager.playSound("rapaiz_kisse.ogg");
      }
      constructor.score += value;
      return console.log(constructor.combo);
    };
    Score.update = function(){
      if (constructor.score > 0 && Math.random() < 0.1) {
        constructor.score += Math.round(Math.random() * 8 - 4);
      }
    };
    function Score(){}
    return Score;
  }());
}).call(this);
