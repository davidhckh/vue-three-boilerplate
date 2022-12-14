uniform sampler2D uEnvMap;
uniform sampler2D uTexture;
uniform float uRoughness;

varying vec3 vViewPosition;
varying vec2 vUv;
varying float vDistToHaru;

#include <common>
#include <packing>
#include <lights_pars_begin>
#include <shadowmap_pars_fragment>
#include <shadowmask_pars_fragment>
#include <normal_pars_fragment>

#define SHADOW_OPACITY 0.15
#define SHADOW_COLOR vec3(0.239,0.416,0.529)
#define FOG_COLOR vec3(0.812,0.894,0.953)

vec3 addFog(vec3 color, float distanceToHaru) {
    float fogFactor = smoothstep( .35, .8, distanceToHaru / 100. ) * .7;
    return vec3( mix( color, FOG_COLOR, fogFactor ) );
}

vec3 addShadow(vec3 color) {
    DirectionalLightShadow directionalShadow = directionalLightShadows[0];

    float shadow = getShadow(
        directionalShadowMap[0],
        directionalShadow.shadowMapSize,
        directionalShadow.shadowBias,
        directionalShadow.shadowRadius,
        vDirectionalShadowCoord[0]
    );

    vec4 shadowMap = vec4(vec3(1. - shadow), 1.);
    vec4 shadowColor = vec4(SHADOW_COLOR, 1.);
    float shadowFactor = SHADOW_OPACITY * shadowMap.r;

    return mix(color, shadowColor.rgb, shadowFactor);
}

void main() {
	#include <normal_fragment_begin>

    //matcap
	vec3 viewDir = normalize( vViewPosition );
	vec3 x = normalize( vec3( viewDir.z, 0.0, - viewDir.x ) );
	vec3 y = cross( viewDir, x );
	vec2 uv = vec2( dot( x, normal ), dot( y, normal ) ) * 0.495 + 0.5;
	vec4 matcapColor = texture2D( uEnvMap, uv );

    //texture
    vec4 textureColor = texture2D(uTexture, vUv);

    //mix
    vec4 matColor = mix(matcapColor, textureColor, uRoughness);
    vec3 finalColor = matColor.rgb;

    finalColor = addShadow(finalColor);
    finalColor = addFog(finalColor, vDistToHaru);

    gl_FragColor = vec4(finalColor, 1.);
}