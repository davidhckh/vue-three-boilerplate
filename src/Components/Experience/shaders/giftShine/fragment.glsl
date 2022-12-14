varying vec2 vUv;

uniform float uProgress;

#define PI
#define OPACITY 0.3
#define COLOR vec3(1.,0.98,0.855)

void main() {
    float strength = smoothstep(1. - uProgress, 1.0, vUv.y);
    gl_FragColor = vec4(COLOR, strength * OPACITY);
}