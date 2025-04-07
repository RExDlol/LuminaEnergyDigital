varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_blurAmount;

void main() {
    vec4 sum = vec4(0.0);
    for (int i = -4; i <= 4; i++) {
        sum += texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, float(i) * u_blurAmount)) * 0.111;
    }
    gl_FragColor = v_vColour * sum;
}