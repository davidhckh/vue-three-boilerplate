uniform sampler2D uTexture;
uniform vec2 uMarkerPosition;
uniform float uMarkerOpacity;
uniform float uFootstepAmount;

varying vec2 vUv;
varying float vDistToHaru;

#include <common>
#include <packing>
#include <lights_pars_begin>
#include <shadowmap_pars_fragment>
#include <shadowmask_pars_fragment>
#include <normal_pars_fragment>

#define SHADOW_OPACITY 0.1
#define SHADOW_COLOR vec3(0.239,0.416,0.529)
#define FOG_COLOR vec3(0.812,0.894,0.953)
#define MARKER_COLOR vec3(0.4,0.8,0.796)

vec3 addShadow(vec3 color) {
    DirectionalLightShadow directionalShadow = directionalLightShadows[0];

    float shadow = getShadow(
        directionalShadowMap[0],
        directionalShadow.shadowMapSize,
        directionalShadow.shadowBias,
        directionalShadow.shadowRadius,
        vDirectionalShadowCoord[0]
    );

    float shadowFactor = SHADOW_OPACITY * (1. - shadow);

    return mix(color, SHADOW_COLOR, shadowFactor);
}

vec3 addFog(vec3 color, float distanceToHaru) {
    float fogFactor = smoothstep( .35, .8, distanceToHaru / 100. ) * .3;
    return vec3( mix( color, FOG_COLOR, fogFactor ) );
}

float Marker() {
    float distanceToMarker = distance(vUv, uMarkerPosition) * 450.;
    float marker = 1. - smoothstep(.99, 1., distanceToMarker);
    marker -= 1. - smoothstep(.8, .81, distanceToMarker);
    return marker;
}

void main() {
	#include <normal_fragment_begin>

    vec4 textureColor = texture2D(uTexture, vUv);

    vec3 finalColor = textureColor.rgb;

    finalColor = addShadow(finalColor);
    finalColor = addFog(finalColor, vDistToHaru);

    float marker = Marker();
    finalColor = mix(finalColor, MARKER_COLOR, marker * uMarkerOpacity);

    gl_FragColor = vec4(finalColor, 1.);
}