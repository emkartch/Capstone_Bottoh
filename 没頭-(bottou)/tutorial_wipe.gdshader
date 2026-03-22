shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.0) = 0.5;
uniform vec2 center = vec2(0.5, 0.5);
uniform float screen_width = 1920.0;
uniform float screen_height = 1080.0;

void fragment() {
    float ratio = screen_width / screen_height;
    // Adjust UV for aspect ratio to ensure a perfect circle
    vec2 scaled_uv = vec2(UV.x * ratio, UV.y);
    vec2 scaled_center = vec2(center.x * ratio, center.y);
    
    // Calculate distance from center
    float dist = distance(scaled_uv, scaled_center);
    
    // Use smoothstep for anti-aliasing edges
    float mask = smoothstep(circle_size, circle_size + 0.01, dist);
    
    // Set COLOR alpha based on mask (1 = opaque, 0 = transparent)
    // COLOR.a is the base opacity of the ColorRect
    COLOR.a = mask * COLOR.a;
}
