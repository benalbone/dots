// Spooky Mist Shader for Ghostty Terminal
// Standalone volumetric mist effect with swirling motion

// Configuration
#define MIST_LAYERS 3
#define MIST_SPEED 0.2
#define MIST_BASE_COLOR vec3(0.05, 0.04, 0.08)
#define FOG_GLOW_COLOR vec3(0.2, 0.15, 0.4)
#define BLACK_BLEND_THRESHOLD 0.4

// Noise functions
vec3 hash3(vec3 p) {
    p = vec3(dot(p, vec3(127.1, 311.7, 74.7)),
             dot(p, vec3(269.5, 183.3, 246.1)),
             dot(p, vec3(113.5, 271.9, 124.6)));
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

float noise(vec3 p) {
    vec3 i = floor(p);
    vec3 f = fract(p);
    vec3 u = f * f * (3.0 - 2.0 * f);
    
    return mix(mix(mix(dot(hash3(i + vec3(0,0,0)), f - vec3(0,0,0)),
                       dot(hash3(i + vec3(1,0,0)), f - vec3(1,0,0)), u.x),
                   mix(dot(hash3(i + vec3(0,1,0)), f - vec3(0,1,0)),
                       dot(hash3(i + vec3(1,1,0)), f - vec3(1,1,0)), u.x), u.y),
               mix(mix(dot(hash3(i + vec3(0,0,1)), f - vec3(0,0,1)),
                       dot(hash3(i + vec3(1,0,1)), f - vec3(1,0,1)), u.x),
                   mix(dot(hash3(i + vec3(0,1,1)), f - vec3(0,1,1)),
                       dot(hash3(i + vec3(1,1,1)), f - vec3(1,1,1)), u.x), u.y), u.z);
}

float fbm(vec3 p, float octaves) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    
    for (int i = 0; i < 4; i++) {
        if (float(i) >= octaves) break;
        value += amplitude * noise(p * frequency);
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

// Volumetric mist with swirling motion
vec3 mistLayer(vec2 uv, float time, float depth, float seed) {
    // Swirling motion
    vec2 swirl = vec2(
        sin(time * 0.8 + seed * 2.0) * 0.6,
        cos(time * 0.7 + seed * 3.0) * 0.5
    );
    
    // Per-layer offset for variation
    vec2 layerOffset = vec2(sin(seed * 12.0 + time * 0.15), cos(seed * 15.0 + time * 0.15)) * 0.04;
    vec3 p = vec3((uv + swirl + layerOffset) * (1.5 + depth * 2.0), time * (MIST_SPEED + 0.05 * seed));
    
    // Multi-octave noise for detail
    float density = fbm(p, 3.0 - depth) * 0.5 + 0.5;
    density += fbm(p * 2.0 + vec3(time * 0.1), 2.0) * 0.25;
    
    // Shape the mist
    density = pow(density, 0.9); // less than 1.0 boosts midtones
    
    // Subtle pulsing
    float pulse = 0.95 + 0.05 * sin(time * 0.3);
    density *= pulse;
    
    // Height-based fade
    density *= smoothstep(0.8, -0.1, uv.y); // affects more of the screen
    
    // Color variation
    vec3 color = mix(MIST_BASE_COLOR, FOG_GLOW_COLOR, density * 0.5);
    
    return color * density;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 centered_uv = uv * 2.0 - 1.0;
    centered_uv.x *= iResolution.x / iResolution.y;
    float time = iTime;
    
    // Get terminal content
    vec4 terminalColor = texture(iChannel0, uv);
    
    // Create layered mist
    vec3 mistEffect = vec3(0.0);
    for (int i = 0; i < MIST_LAYERS; i++) {
        float depth = float(i) / float(MIST_LAYERS);
        float seed = float(i) * 1.618;
        vec3 layer = mistLayer(centered_uv, time, depth, seed);
        mistEffect += layer * (1.0 - depth * 0.6);
    }
    
    // Composite with terminal
    vec3 finalColor = terminalColor.rgb;
    
    // Vignette effect
    float vignette = smoothstep(1.2, 0.9, length(centered_uv));
    mistEffect *= mix(1.0, vignette, 0.25); // Only 25% strength
    
    // Apply mist with terminal content visibility
    float terminalMask = smoothstep(0.0, BLACK_BLEND_THRESHOLD, length(terminalColor.rgb));
    vec3 mistBlend = mix(mistEffect * 0.42, mistEffect * 0.13, terminalMask);
    finalColor = mix(finalColor, finalColor * 0.86 + mistBlend, 0.67);
    
    // Final color grading
    finalColor = pow(finalColor, vec3(1.05)); // slight gamma lift
    finalColor = mix(finalColor, vec3(0.13, 0.13, 0.17), 0.05); // dark Dracula-tint shift
    
    fragColor = vec4(finalColor, terminalColor.a);
}