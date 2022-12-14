varying vec2 vUv;
varying float vDistToCamera;

uniform float uProgressX;
uniform float uProgressZ;
uniform vec3 uLightColor;
uniform vec3 uShadowColor;

#define SHADOW_COLOR vec3(0.11,0.282,0.31)
#define LIGHT_COLOR vec3(0.706,0.894,0.847)
//#define LIGHT_COLOR vec3(1., 0., 0.)

#include "./snoise.glsl"

void main() {
    float lightStrength = distance(vUv, vec2(.5 + uProgressX * .1 - .15, .7 - uProgressZ * .35)) / .25;
    vec3 finalColor = mix(SHADOW_COLOR, LIGHT_COLOR, 1. - clamp(lightStrength, 0., 1.));

    //stripes
    float noise = snoise(vec2(vUv.x * 150. + uProgressX * 5., vUv.y * 6.5));
    noise = smoothstep(0.65, 1., noise);
    finalColor += noise * .08;

    gl_FragColor = vec4(finalColor , clamp(1.2 - vDistToCamera * 0.012, 0., .95));
    //gl_FragColor = vec4(vec3(noise), 1.);
}
