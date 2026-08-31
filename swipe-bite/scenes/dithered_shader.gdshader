shader_type canvas_item;

#define MAXCOLORS 16

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0,1);
uniform float burn_size: hint_range(0.0, 1.0, 0.01);
uniform vec4 burn_color: source_color;

uniform bool enabled = true;
uniform bool dithering = true;
uniform int colors : hint_range(1, MAXCOLORS) = 8;
uniform int dither_size: hint_range(1, 8) = 2;

float dithering_pattern(ivec2 fragcoord) {
	const float pattern[] = {
		0.00, 0.50, 0.10, 0.65, 
		0.75, 0.25, 0.90, 0.35, 
		0.20, 0.70, 0.05, 0.50, 
		0.95, 0.40, 0.80, 0.30
	};
	
	int x = fragcoord.x % 4;
	int y = fragcoord.y % 4;
	
	return pattern[y * 4 + x];
}

#define SPIN_EASE 1.0

float reduce_color(float raw, float dither, int depth) {
	float div = 1.0 / float(depth);
	float val = 0.0;
	int i = 0;

	while (i <= MAXCOLORS)
	{
		if (raw > div * (float(i + 1))) {
			i = i + 1;
			continue;
		}

		if (raw * float(depth) - float(i) <= dither * 0.999)
		{
			val = div * float(i);
		} 
		else
		{
			val = div * float(i + 1);
		}
		return val;

		i = i+1;
	}

	return val;
}

const float ps1_dither[16] = float[16](
	-4.0, 0.0, -3.0, 0.0,
	2.0, -2.0, 3.0, -1.0,
	-3.0, 1.0, -4.0, 0.0,
	3.0, -1.0, 2.0, -2.0
);


void fragment() {
    vec2 uv = UV;
	
	vec4 main_texture = texture(TEXTURE, UV);
    vec4 noise_texture = texture(dissolve_texture, UV);
	
	float burn_size_step = burn_size * step(0.001, dissolve_value) * step(dissolve_value, 0.999);
	float threshold = smoothstep(noise_texture.x-burn_size_step, noise_texture.x, dissolve_value);
	float border = smoothstep(noise_texture.x, noise_texture.x + burn_size_step, dissolve_value);
	
	
	vec4 tex = main_texture;
	
	tex.a *= threshold;

	tex.rgb = mix(burn_color.rgb, main_texture.rgb, border);
	
	vec4 screen_colour = tex;
	vec4 raw = screen_colour;
	ivec2 iuv = ivec2(FRAGCOORD.xy / float(dither_size));

	float dithering_value = 1.0;
	if (dithering)
	{
		dithering_value = dithering_pattern(iuv);
	}
	
	vec4 dithered_color = vec4(0, 0, 0, 1);
	
	dithered_color.r = reduce_color(raw.r, (dithering_value - 0.5) * dithering_value + 0.5, colors - 1);
	dithered_color.g = reduce_color(raw.g, (dithering_value - 0.5) * dithering_value + 0.5, colors - 1);
	dithered_color.b = reduce_color(raw.b, (dithering_value - 0.5) * dithering_value + 0.5, colors - 1);
	dithered_color.a = tex.a;
	
	COLOR = dithered_color;
}
