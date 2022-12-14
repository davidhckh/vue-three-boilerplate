varying vec3 vViewPosition;
varying vec3 vWorldNormal;
varying vec3 vModelPosition;

#include <common>
#include <shadowmap_pars_vertex>
#include <normal_pars_vertex>

void main() {
	#include <beginnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <project_vertex>
    #include <worldpos_vertex>
    #include <shadowmap_vertex>

	vec4 modelPosition = modelMatrix * vec4(1.0);
    
	vModelPosition = modelPosition.xyz;
	vViewPosition = - mvPosition.xyz;
}
