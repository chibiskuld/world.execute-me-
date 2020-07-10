//******************************************
//The Fragment Shader
//******************************************
fixed4 frag(v2f i) : SV_Target
{
	float t = _Time.y - _StartTime;
	float s = max(cos(t * bpm), 0) + .75f;
	float w = _EdgeWidth * s;

	float3 coord = float3(i.barycentric.x, i.barycentric.y, 1.0 - i.barycentric.x - i.barycentric.y);//gets intensity of color based on barycentric position. Is the gpu morphing this for us?
	coord = smoothstep(fwidth(coord)*w, fwidth(coord)*w + fwidth(coord), coord);//clamp the color to a solid white line.
	float e = 1 - min(coord.x, min(coord.y, coord.z));//take lowest value, invert because we want white.
	float4 col = lerp(float4(.1f, 0.0f, .2f, e), float4(1, 1, 1, e), i.color.a);

#ifndef UNITY_COLORSPACE_GAMMA
	col.rgb = GammaToLinearSpace(col.rgb);
#endif
#ifdef MODE_TCUT
	clip(col.a - .5);
#endif
	return col;
}