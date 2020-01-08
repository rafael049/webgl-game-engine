attribute vec4 aVertexPosition;
attribute vec2 aTexCoord;

uniform mat4 uLocalMat;
uniform mat4 uModelMat;
uniform mat4 uViewMat;
uniform mat4 uProjectionMat;

varying lowp vec4 vColor;
varying lowp vec2 vTexCoord;

void main(void) {
    mat4 viewMat = uViewMat;
    gl_Position = uProjectionMat*viewMat*uModelMat*uLocalMat*aVertexPosition;
    vTexCoord = aTexCoord;
}
