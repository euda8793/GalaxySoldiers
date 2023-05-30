shader_type canvas_item;

uniform vec3 reticle_color : source_color = vec3( 0.1, 0.6, 1.0 );

void fragment() {
	vec4 current = texture(TEXTURE, UV);
	if(current.a == 1.0){
		COLOR.rgb = reticle_color;
	}
}
