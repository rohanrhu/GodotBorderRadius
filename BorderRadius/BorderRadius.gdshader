/*
 * Pixel-sized Border Radius Shader
 * Copyright (C) 2023 Oğuzhan Eroğlu <meowingcate@gmail.com> (https://oguzhaneroglu.com)
 */

shader_type canvas_item;

uniform float radius_top_left = 10.;
uniform float radius_top_right = 10.;
uniform float radius_bottom_left = 10.;
uniform float radius_bottom_right = 10.;

uniform float canvas_width;
uniform float canvas_height;

void fragment() {
	float limit = min(canvas_width, canvas_height) / 2.;
	float width_top_left = (radius_top_left > limit) ? limit: radius_top_left;
	float width_top_right = (radius_top_right > limit) ? limit: radius_top_right;
	float width_bottom_left = (radius_bottom_left > limit) ? limit: radius_bottom_left;
	float width_bottom_right = (radius_bottom_right > limit) ? limit: radius_bottom_right;
	
	float px = canvas_width * UV.x;
	float py = canvas_height * UV.y;
	
	float h;

	if ((px <= width_top_left) && (py <= width_top_left)) {
		h = sqrt(pow(width_top_left - px, 2) + pow(width_top_left - py, 2));
		COLOR.a = (step(h, width_top_left) > 0.) ? COLOR.a: 0.;
	} else if ((px >= canvas_width - width_top_right) && (py <= width_top_right)) {
		h = sqrt(pow(px - (canvas_width - width_top_right), 2) + pow(width_top_right - py, 2));
		COLOR.a = (step(h, width_top_right) > 0.) ? COLOR.a: 0.;
	} else if ((px <= width_bottom_left) && (py >= (canvas_height - width_bottom_left))) {
		h = sqrt(pow(width_bottom_left - px, 2) + pow(py - (canvas_height - width_bottom_left), 2));
		COLOR.a = (step(h, width_bottom_left) > 0.) ? COLOR.a: 0.;
	} else if ((px >= canvas_width - width_bottom_right) && (py >= (canvas_height - width_bottom_right))) {
		h = sqrt(pow(px - (canvas_width - width_bottom_right), 2) + pow(py - (canvas_height - width_bottom_right), 2));
		COLOR.a = (step(h, width_bottom_right) > 0.) ? COLOR.a: 0.;
	}
}
