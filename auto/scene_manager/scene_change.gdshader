shader_type canvas_item;
render_mode unshaded;

uniform float cutoff: hint_range(0.0, 1.0, 0.1);

void fragment() {
	if (distance(0, UV.x) < cutoff) {
		COLOR.a = 0.0;
	}
}
