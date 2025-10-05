shader_type spatial;

uniform vec4 water_color : source_color;
uniform sampler2D noise_texture;

uniform float wave_speed : hint_range(0.1, 5.0) = 1.0;
uniform float wave_noise : hint_range(0.1, 5.0) = 1.0;
uniform vec3 wave_strength = vec3(0.1, 0.1, 0.2);

void vertex() {
    float time = TIME * wave_speed;

    vec2 noise_uv = UV + vec2(time * wave_noise, sin(time * 0.5) * wave_noise);

    vec4 noise = texture(noise_texture, noise_uv);

    VERTEX += vec3(noise.rg * wave_strength.xy, noise.b * wave_strength.z);
}

void fragment() {
    vec4 color = water_color;

    ALBEDO = color.rgb;

    ALPHA = color.a;
}
