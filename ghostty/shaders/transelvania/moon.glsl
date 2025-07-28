#version 330

uniform float iTime;
uniform vec2 iResolution;

out vec4 fragColor;

void main() {
    // Normalize pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    
    // Position the moon in the top right corner
    vec2 moonPos = vec2(0.85, 0.85);  // Adjusted position
    
    // Create the moon shape
    float moonRadius = 0.03;  // Made moon slightly smaller
    float dist = length(uv - moonPos);
    float moon = smoothstep(moonRadius, moonRadius - 0.005, dist);
    
    // Create a soft glow around the moon
    float glow = smoothstep(moonRadius * 3.0, moonRadius * 0.5, dist) * 0.3;
    
    // Moon color (pale yellow)
    vec3 moonColor = vec3(0.98, 0.98, 0.82);  // Slightly warmer color
    
    // Create background transparency
    float alpha = clamp(moon + glow, 0.0, 1.0);
    
    // Combine moon and glow
    vec3 finalColor = moon * moonColor + glow * moonColor * 0.5;
    
    // Output final color with proper transparency
    fragColor = vec4(finalColor, alpha);
}