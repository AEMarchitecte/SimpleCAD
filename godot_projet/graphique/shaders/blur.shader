shader_type canvas_item;

uniform float amount: hint_range(0.0, 5.0);

void fragment() {
	COLOR.rgba = textureLod(SCREEN_TEXTURE, SCREEN_UV, amount).rgba;
}
