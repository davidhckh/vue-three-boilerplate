varying vec2 vUv;

uniform float uTime;
uniform float uOpacity;

#define COLOR vec3(0.486,0.835,0.831)

void main() {
    float distToCenter = distance(vUv, vec2(0.5));
    float strength = smoothstep(sin( distToCenter * 25.0 - uTime * 4.0), sin( distToCenter * 25.0 - uTime * 4.0) + .5, 0.);
    strength -= smoothstep(0.49, 0.5, distToCenter);

    gl_FragColor = vec4(COLOR, strength * uOpacity);
}