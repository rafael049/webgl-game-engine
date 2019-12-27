attribute vec4 aVertexPosition;
attribute vec4 aVertexColor;

uniform mat4 uLocalMat;
uniform mat4 uModelMat;
uniform mat4 uViewMat;
uniform mat4 uProjectionMat;

varying lowp vec4 vColor;

void main(void) {
    gl_Position = uProjectionMat*uViewMat*uModelMat*uLocalMat*aVertexPosition;
    vColor = aVertexColor;
}
