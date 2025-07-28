// Flying Bats Shader for Ghostty Terminal
// Small animated bats that fly around the top-right castle area
// Designed to be layered on top of other effects

#define NUM_BATS 20
#define BAT_COLOR vec3(0.0, 0.0, 0.0) // Pure black

// Hash function for randomization
float hash11(float p) {
    p = fract(p * .1031);
    p *= p + 33.33;
    p *= p + p;
    return fract(p);
}

// Simple bat SDF - less detail looks better at tiny sizes
float sdBat(vec2 p, float flap) {
    // Tiny body dot
    float body = length(p) - 0.15;
    
    // Simple V-shaped wings
    float wingSpread = mix(0.7, 0.2, flap);
    
    // Just two triangular wings
    float wing1 = abs(p.x - p.y * wingSpread) - 0.05;
    float wing2 = abs(p.x + p.y * wingSpread) - 0.05;
    
    return min(body, min(wing1, wing2));
}

// Fast, simple flapping
float flapAnimation(float t) {
    float speed = 15.0; // very fast flapping
    float phase = fract(t * speed);
    return phase < 0.5 ? phase * 2.0 : 2.0 - phase * 2.0;
}

// More natural circular flight paths
vec2 batPath(float t, float seed) {
    // Spread around top-right area
    vec2 baseCenter = vec2(0.85, 0.12); // was 0.88
    
    // Each bat has its own circular orbit
    float orbitRadius = 0.06 + 0.04 * hash11(seed * 4.7);
    float orbitSpeed = 1.0 + 0.7 * hash11(seed * 3.1); // Moderate speed orbits
    float orbitPhase = seed * 6.28;
    
    // Circular motion with vertical variation
    vec2 circularPath = vec2(
        cos(t * orbitSpeed + orbitPhase) * orbitRadius,
        sin(t * orbitSpeed + orbitPhase) * orbitRadius * 0.6
    );
    
    // Add some wandering
    vec2 wander = vec2(
        sin(t * 0.7 + seed * 5.0) * 0.02,
        cos(t * 0.5 + seed * 7.0) * 0.015
    );
    
    return baseCenter + circularPath + wander;
}

// Removed - not needed for tiny bats

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    float time = iTime;
    
    // Get input from previous shader/terminal
    vec4 inputColor = texture(iChannel0, uv);
    
    // Draw bats
    float batAlpha = 0.0;
    
    for (int i = 0; i < NUM_BATS; i++) {
        float seed = float(i) * 1.337;
        
        // Slightly slower speeds
        float speed = 0.8 + 0.6 * hash11(seed * 2.1);
        float t = time * speed + seed * 10.0;
        
        // Get bat position
        vec2 batPos = batPath(t, seed);
        
        // Calculate fade based on Y position (castle occlusion effect)
        vec2 baseCenter = vec2(0.85, 0.12); // was 0.88
        float orbitRadius = 0.06 + 0.04 * hash11(seed * 4.7);
        float orbitHeight = orbitRadius * 0.6; // matches the 0.6 factor in batPath
        
        // Normalize Y position: 0 = bottom of orbit, 1 = top of orbit
        float yMin = baseCenter.y - orbitHeight;
        float yMax = baseCenter.y + orbitHeight;
        float yNorm = (batPos.y - yMin) / (yMax - yMin);
        
        // Fade parameters - adjust these to match your castle
        float fadeStart = 0.75;  // Start fading at 75% height
        float fadeEnd = 0.90;    // Fully transparent at 90% height
        
        // Calculate occlusion alpha (1.0 = visible, 0.0 = hidden behind castle)
        float occlusionAlpha = smoothstep(fadeEnd, fadeStart, yNorm);
        
        // Add slight individual variation to avoid uniform fading
        float fadeVariation = 0.05 * hash11(seed * 2.9);
        occlusionAlpha = clamp(occlusionAlpha + fadeVariation, 0.05, 1.0); // Never fully invisible
        
        // Even tinier scale, with slight size reduction when "behind" castle
        float baseScale = 0.0015 + 0.0005 * sin(t * 0.3 + seed);
        float depthScale = mix(0.85, 1.0, occlusionAlpha); // Smaller when faded
        float scale = baseScale * depthScale;
        
        // Transform to bat space
        vec2 batUV = (uv - batPos) / scale;
        batUV.x /= iResolution.x / iResolution.y; // Aspect ratio correction
        
        // Only compute SDF if potentially visible
        if (length(batUV) < 2.5) {
            // Wing animation with individual timing
            float flapOffset = hash11(seed * 1.7) * 2.0;
            float flap = flapAnimation(t * 1.2 + flapOffset);
            
            float d = sdBat(batUV, flap);
            float alpha = smoothstep(0.05, -0.05, d); // Softer edges at tiny size
            
            // Apply castle occlusion effect
            alpha *= occlusionAlpha;
            
            batAlpha = max(batAlpha, alpha);
        }
    }
    
    // Composite bats over input
    vec3 finalColor = mix(inputColor.rgb, BAT_COLOR, batAlpha);
    
    fragColor = vec4(finalColor, inputColor.a);
}