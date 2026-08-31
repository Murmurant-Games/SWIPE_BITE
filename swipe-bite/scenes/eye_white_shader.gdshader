shader_type canvas_item;
//took it directly from balatro source code
//buy balatro now: https://www.playbalatro.com


uniform highp float spin_rotation_speed = 2.0;
uniform highp float move_speed = 7.0;
uniform highp vec2 offset = vec2(0., 0.);
uniform highp vec4 colour_1 : source_color = vec4(0.5, 0.0, 0.0, 1.0);
uniform highp vec4 colour_2 : source_color = vec4(0.0, 0.02, 0.006, 1.0);
uniform highp vec4 colour_3 : source_color = vec4(0.0, 0.1, 0.1, 1.0);
uniform highp float contrast = 3.5;
uniform highp float lighting = 0.4;
uniform highp float spin_amount = 0.25;
uniform highp float pixel_filter = 740.;
uniform bool is_rotating = false;
#define MAXCOLORS 16

uniform bool enabled = true;
uniform bool dithering = true;
uniform int colors : hint_range(1, MAXCOLORS) = 2;
uniform int dither_size: hint_range(1, 8) = 4;
uniform float min_alpha = 1.0;

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


vec4 effect(vec2 screenSize, vec2 screen_coords){

	highp float pixel_size = length(screenSize.xy) / pixel_filter;
    highp vec2 uv = (floor(screen_coords.xy*(1./pixel_size))*pixel_size - 0.5*screenSize.xy)/length(screenSize.xy) - offset;
    highp float uv_len = length(uv);


    highp float speed = (spin_rotation_speed*SPIN_EASE*0.2);
	if(is_rotating){
		speed = TIME * speed;
	}
	speed += 302.2;
    highp float new_pixel_angle = (atan(uv.y, uv.x)) + speed - SPIN_EASE*20.*(1.*spin_amount*uv_len + (1. - 1.*spin_amount));
    highp vec2 mid = (screenSize.xy/length(screenSize.xy))/2.;
    uv = (vec2((uv_len * cos(new_pixel_angle) + mid.x), (uv_len * sin(new_pixel_angle) + mid.y)) - mid);

    uv *= 30.;
    speed = TIME*(move_speed);
	highp vec2 uv2 = vec2(uv.x+uv.y);

	for(int i=0; i < 5; i++) {
		uv2 += sin(max(uv.x, uv.y)) + uv;
		uv  += 0.5*vec2(cos(5.1123314 + 0.353*uv2.y + speed*0.131121),sin(uv2.x - 0.113*speed));
		uv  -= 1.0*cos(uv.x + uv.y) - 1.0*sin(uv.x*0.711 - uv.y);
	}


    highp float contrast_mod = (0.25*contrast + 0.5*spin_amount + 1.2);
	highp float paint_res = min(2., max(0.,length(uv)*(0.035)*contrast_mod));
    highp float c1p = max(0.,1. - contrast_mod*abs(1.-paint_res));
    highp float c2p = max(0.,1. - contrast_mod*abs(paint_res));
    highp float c3p = 1. - min(1., c1p + c2p);
	
	highp float ligth = (lighting - 0.2) * max(c1p*5. - 4., 0.) + lighting * max(c2p*5. - 4., 0.); 
	highp vec4 ret_col = (0.3/contrast)*colour_1 + (1. - 0.3/contrast)*(colour_1*c1p + colour_2*c2p + vec4(c3p*colour_3.rgb, c3p*colour_1.a)) + ligth;
	return ret_col;
}
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
    vec2 uv = UV * 1.0;
	//COLOR *= effect(TEXTURE_PIXEL_SIZE, uv);
	
	vec4 screen_colour = effect(TEXTURE_PIXEL_SIZE, uv);
	//COLOR = screen_colour;
	vec4 raw = screen_colour;
	ivec2 iuv = ivec2(FRAGCOORD.xy / float(dither_size));

	
	float dithering_value = 1.0;
	if (dithering)
	{
		dithering_value = dithering_pattern(iuv);
	}
	
	COLOR.r = reduce_color(raw.r, (dithering_value - 0.5) * dithering_value + 0.5, colors - 1);
	COLOR.g = reduce_color(raw.g, (dithering_value - 0.5) * dithering_value + 0.5, colors - 1);
	COLOR.b = reduce_color(raw.b, (dithering_value - 0.5) * dithering_value + 0.5, colors - 1);
	COLOR.a = colour_3.a;
//
	//int x = int(FRAGCOORD.x) % 512;
	//int y = int(FRAGCOORD.y) % 512;
	//int index = x + (y * 512);
	//
	//float dither_offset = (ps1_dither[index] / 512.0);
	//
	//vec3 quantized_colour = floor((screen_colour * 255.0) / 8.0 + dither_offset) / 31.0;
	//COLOR = vec4(quantized_colour, 1.0);
}
