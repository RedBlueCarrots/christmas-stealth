shader_type canvas_item;

uniform float amount_filled = 0.5;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR == vec4(1.0, 1.0, 1.0, 1.0)) {
		vec2 rUV = floor(UV * vec2(16, 32));
		if (rUV.y > (1.5-amount_filled)*20.0) {
			float actTime = floor(TIME*10.0)/10.0;
			int tim = int(floor(2.0*rand(rUV+vec2(sin(actTime), cos(actTime*2.0)))));
			if (tim%2==0) {
				COLOR = vec4(0.3529, 0.4706, 0.502, 1.0);
			} else {
				COLOR = vec4(0.6588, 0.9294, 0.4667, 1.0);
			}
		} else {
			COLOR = vec4(1.0, 1.0, 1.0, 0.0);
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
