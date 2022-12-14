#include <common>
#include <shadowmap_pars_vertex>
#include <normal_pars_vertex>

varying vec3 vViewPosition;
varying vec2 vUv;
varying float vDistToHaru;

uniform vec3 uHaruPosition;

void main() {
	#include <beginnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <project_vertex>
    #include <worldpos_vertex>
    #include <shadowmap_vertex>

	gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
    
	vViewPosition = - mvPosition.xyz;
	vDistToHaru = distance(uHaruPosition, (modelMatrix * vec4(position, 1.0)).xyz);
    vUv = uv;
}