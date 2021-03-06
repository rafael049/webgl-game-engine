// Generated by LiveScript 1.6.0
(function(){
  var Text;
  window.Text = Text = (function(){
    Text.displayName = 'Text';
    var prototype = Text.prototype, constructor = Text;
    function Text(value, font, pos, size, color, shadow, width){
      var overlayElement;
      color == null && (color = "#ffffff");
      shadow == null && (shadow = false);
      width == null && (width = 400);
      this.pos = pos;
      this.value = value;
      overlayElement = document.getElementById("overlay");
      this.texElement = document.createElement("SPAN");
      this.node = document.createTextNode(this.value);
      overlayElement.appendChild(this.texElement);
      this.texElement.appendChild(this.node);
      this.texElement.style.position = "absolute";
      this.texElement.style.width = width + "px";
      this.texElement.style.fontFamily = font;
      this.texElement.style.fontSize = size + "px";
      if (shadow) {
        this.texElement.style.textShadow = "1px 1px 2px black";
      }
      this.setPos(pos);
      this.setColor(color);
    }
    Text.prototype.setText = function(txt){
      return this.node.data = txt;
    };
    Text.prototype.setColor = function(color){
      return this.texElement.style.color = color;
    };
    Text.prototype.setPos = function(pos){
      this.texElement.style.left = pos[0] + "px";
      return this.texElement.style.top = pos[1] + "px";
    };
    return Text;
  }());
}).call(this);
