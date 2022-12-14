varying vec2 vUv;
varying float vDistToCamera;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    vUv = uv;
    vDistToCamera = gl_Position.w;
}