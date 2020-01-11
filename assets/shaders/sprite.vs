attribute vec4 aVertexPosition;
attribute vec2 aTexCoord;

uniform mat4 uLocalMat;
uniform mat4 uModelMat;
uniform mat4 uViewMat;
uniform mat4 uProjectionMat;

uniform int x_tiles;
uniform int y_tiles;
uniform int frame;

varying lowp vec4 vColor;
varying lowp vec2 vTexCoord;

int mod(int a, int b);

void main(void) {
    mat4 viewMat = uViewMat;
    gl_Position = uProjectionMat*viewMat*uModelMat*uLocalMat*aVertexPosition;

    vec2 tiledTexCoord = aTexCoord;
    tiledTexCoord.x = tiledTexCoord.x/float(x_tiles) + float( mod(frame+1, x_tiles) )/float(x_tiles);
    tiledTexCoord.y = tiledTexCoord.y/float(y_tiles) + float( mod((frame+1)/x_tiles, y_tiles) )/float(y_tiles);
    vTexCoord = tiledTexCoord;
}

int mod(int a, int b){
    return a - int( floor(float(a)/float(b)) )*b;
}
