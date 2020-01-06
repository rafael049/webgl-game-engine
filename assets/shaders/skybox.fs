precision mediump float;

varying lowp vec4 vColor;
varying lowp vec2 vTexCoord;

uniform sampler2D uTexture;

void main(void) {
    vec4 texColor = texture2D(uTexture, vTexCoord);
    if(texColor.a < 0.1){
        //discard;
    }
    gl_FragColor = texColor;
}
