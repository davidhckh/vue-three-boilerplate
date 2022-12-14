uniform sampler2D matcap;

varying vec3 vViewPosition;

#include <common>
#include <packing>
#include <lights_pars_begin>
#include <shadowmap_pars_fragment>
#include <shadowmask_pars_fragment>
#include <normal_pars_fragment>

#define SHADOW_OPACITY 0.1
#define SHADOW_COLOR vec3(0.239,0.416,0.529)
#define FOG_COLOR vec3(0.812,0.894,0.953)

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

void main() {
	#include <normal_fragment_begin>

    //matcap
	vec3 viewDir = normalize( vViewPosition );
	vec3 x = normalize( vec3( viewDir.z, 0.0, - viewDir.x ) );
	vec3 y = cross( viewDir, x );
	vec2 uv = vec2( dot( x, normal ), dot( y, normal ) ) * 0.49 + 0.5; // 0.495 to remove artifacts caused by undersized matcap disks

	vec4 matcapColor = texture2D( matcap, uv );

    matcapColor = vec4(addShadow(matcapColor.rgb), 1.);

    gl_FragColor = matcapColor;
}