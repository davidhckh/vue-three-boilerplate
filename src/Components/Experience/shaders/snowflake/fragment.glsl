varying float vDistToHaru;

#define FOG_COLOR vec3(0.812,0.894,0.953)

vec3 addFog(vec3 color, float distanceToHaru) {
    float fogFactor = smoothstep( .35, .8, distanceToHaru / 100. ) * .7;
    return vec3( mix( color, FOG_COLOR, fogFactor ) );
}

void main()
{
    float distanceToCenter = distance(gl_PointCoord, vec2(0.5));
    float strength = smoothstep(0.5, 0.1, distanceToCenter);
    vec3 finalColor = vec3(1., 1., 1.);
    finalColor = addFog(finalColor, vDistToHaru);

    gl_FragColor = vec4(finalColor, strength * .5);
}