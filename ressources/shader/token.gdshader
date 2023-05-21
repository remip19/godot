shader_type spatial;
uniform float tokenId : hint_range(1.0, 2.0, 1.0);

void fragment() {
	ALBEDO = vec3(1.,tokenId-1.0,0.);
}
