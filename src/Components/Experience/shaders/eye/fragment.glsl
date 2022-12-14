varying float vDistToCamera;
varying vec2 vUv;

uniform float uIrisRadius;
uniform float uPupilRadius;
uniform float uTopLidDent;
uniform float uTopLidOffset;
uniform float uBottomLidDent;
uniform float uBottomLidOffset;
uniform vec2 uPupilPosition;
uniform vec3 uIrisColor0;
uniform vec3 uIrisColor1;
uniform float uBlendOpacity;
uniform vec3 uBlendColor;
uniform float uEyeRotation;
uniform float uStripesX;

#define BACKGROUND_COLOR mix(vec3(0.11,0.196,0.255), vec3(0.184,0.278,0.357), vUv.y)
#define PI 3.1415926535897932384626433832795

vec4 circleShape(float radius, vec2 position, vec4 color) {
    float d = distance(position, vUv);
    float circle = smoothstep(radius, radius - 0.01, d);
    vec4 coloredCircle = mix(vec4(0.0), color, circle);
    return coloredCircle;
}

vec2 getPupilPosition(float multiplyBy) {
    vec2 rPosition = mix(vec2(0.5), uPupilPosition, multiplyBy);
    return rPosition;
}

vec4 Eye() {
    vec4 irisOutline = circleShape(uIrisRadius, getPupilPosition(.7), vec4(1., 1., 1., clamp(20. - vDistToCamera, 0., .7))); //hide outline when camera is far away
    vec4 irisColor = vec4(mix(uIrisColor0, uIrisColor1, smoothstep(uPupilRadius, uIrisRadius, distance(getPupilPosition(.9), vUv))), 1.);
    vec4 iris = circleShape(uIrisRadius - .015, getPupilPosition(.7), irisColor);
    iris = mix(irisOutline, iris, iris.a);

    vec4 pupil = circleShape(uPupilRadius, uPupilPosition, vec4(BACKGROUND_COLOR, 1.));

    vec2 shinePosition = getPupilPosition(.6);
    shinePosition.x += 0.1;
    shinePosition.y -= 0.1;
    vec4 shine = circleShape(uIrisRadius * .3, shinePosition, vec4(1.0, 1.0, 1.0, .3));
    
    vec4 eye = mix(iris, pupil, pupil.a);
    return mix(eye, shine, shine.a);
}

vec4 lidShape(float radius, vec2 position) {
    float d = distance(position, vUv);
    float circle = smoothstep( radius - 0.01, radius, d);
    vec4 coloredCircle = mix(vec4(BACKGROUND_COLOR, 1.), vec4(BACKGROUND_COLOR, .0), circle);
    return coloredCircle;
}

vec4 TopLid() {
    float x = vUv.x;
    float y = sin(x * PI) * -uTopLidDent + uTopLidOffset;
    vec4 lid = lidShape(.5, vec2(x, y));
    return lid;
}

vec4 BottomLid() {
    float x = vUv.x;
    float y = sin(x * PI) * uBottomLidDent + 1. + uBottomLidOffset;
    vec4 lid = lidShape(.5, vec2(x, y));
    return lid;
}

vec4 BlendBg() {
    float bgStrength = distance(vec2(0.5, .1), vUv);
    vec4 blendBg = mix(vec4(1.), vec4(uBlendColor, 1.), bgStrength);
    return blendBg; 
}

vec2 rotate(vec2 uv, float rotation, vec2 mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

vec4 BlendStripes() {
    vec2 rotatedUv = rotate(vUv, uEyeRotation - .35, vec2(0.5, 0.5));
    float stripeStrength = smoothstep(.0 + uStripesX, .05 + uStripesX, rotatedUv.x);
    stripeStrength -= smoothstep(.225 + uStripesX, .275 + uStripesX, rotatedUv.x);
    stripeStrength += smoothstep(.35 + uStripesX, .4 + uStripesX, rotatedUv.x);
    stripeStrength -= smoothstep(.45 + uStripesX, .5 + uStripesX, rotatedUv.x);
    stripeStrength *= distance(vec2(0.3, .1), vUv) + 0.35;
    vec4 stripes = mix(vec4(0.), vec4(1.), stripeStrength * .2);
    return stripes;
}

void main() {
    vec4 color = vec4(BACKGROUND_COLOR,  1.);
    vec4 eye = Eye();
    vec4 topLid = TopLid();
    vec4 bottomLid = BottomLid();
    vec4 blendBg = BlendBg();
    vec4 blendStripes = BlendStripes();

    color = mix(color, eye, eye.a);
    color = mix(color, vec4(BACKGROUND_COLOR, 1.), topLid.a);
    color = mix(color, vec4(BACKGROUND_COLOR, 1.), bottomLid.a);
    color = mix(color, blendBg, uBlendOpacity);
    color = mix(color, blendStripes, blendStripes.a * uBlendOpacity);

    gl_FragColor = color;
}