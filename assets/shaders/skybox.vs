attribute vec4 aVertexPosition;
attribute vec2 aTexCoord;

uniform mat4 uLocalMat;
uniform mat4 uModelMat;
uniform mat4 uViewMat;
uniform mat4 uProjectionMat;

varying lowp vec2 vTexCoord;

void main(void){
    mat4 staticViewMat = uViewMat;
    staticViewMat[3] = vec4(0.0, 0.0, 0.0, 1.0);

    vec4 position = uProjectionMat*staticViewMat*vec4(aVertexPosition.xyz, 1.0);

    gl_Position = position.xyww;
    vTexCoord = aTexCoord;
}
