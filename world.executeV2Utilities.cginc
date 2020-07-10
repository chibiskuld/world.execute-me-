float2 rotate2(float2 inCoords, float rot)
{
	float sinRot;
	float cosRot;
	sincos(rot, sinRot, cosRot);
	return mul(float2x2(cosRot, -sinRot, sinRot, cosRot), inCoords);
}

float4 getVertexFromTextureOrOriginal(uint meshIndex, float4 original, float rotate = 0) {
	//retrieve mesh header information.
	uint x = meshIndex % 32;
	uint y = meshIndex / 32;

	float4 md = _MeshIndicies.Load(int3(x, y, 0));
	uint pos = md.g * 2048 + md.r;
	uint size = md.a * 2048 + md.b;

	//then retrieve mesh data.
	if (frame.vID < size) {
		pos += frame.vID;
		x = pos % 2048;
		y = pos / 2048;
		float4 vertex = _Meshes.Load(int3(x, y, 0));
		vertex.xyz *= _Scale;
		vertex.w = 1;
		if (rotate > 0) {
			vertex.xy = rotate2(vertex.xy, -(_Time.y / 4) * rotate);
		}
		return vertex;
	}
	else {
		original.w = 0;
		return original;
	}
}

float4 getVertexFromTexture(uint meshIndex, float rotate = 0) {
	//retrieve mesh header.
	uint x = meshIndex % 32;
	uint y = meshIndex / 32;

	float4 md = _MeshIndicies.Load(int3(x, y, 0));
	uint pos = md.g * 2048 + md.r;
	uint size = md.a * 2048 + md.b;

	//then retrieve mesh data.
	if (frame.vID < size) {
		pos += frame.vID;
		x = pos % 2048;
		y = pos / 2048;
		float4 vertex = _Meshes.Load(int3(x, y, 0));
		vertex.xyz *= _Scale;
		vertex.w = 1;
		if (rotate > 0) {
			vertex.xy = rotate2(vertex.xy, -(_Time.y / 4) * rotate);
		}
		return vertex;
	}
	else {
		float4 output = float4(0, 0, 0, 0);
		return output;
	}
}

void LerpBetweenMeshes(uint frameA, uint frameB, float speed = 4, float rotateO = 0, float rotateF = 0, bool blink = false)
{
	v2f o = frame.o;

	float4 oVertex = getVertexFromTextureOrOriginal(frameA, o.vertex, rotateO);
	float4 fVertex = getVertexFromTextureOrOriginal(frameB, o.vertex, rotateF);
	float l = saturate(_CurrentTime * speed);

	if (blink && _CurrentTime >= 1/speed ) {
		float bt = cos(_Time.y * 15);
		if (bt >= 0) {
			o.vertex = fVertex;
		}
		else {
			o.vertex.w = 0;
		}
	}
	else {
		o.vertex = lerp(oVertex, fVertex, l);
	}

	o.color = o.vertex.w;
	o.vertex = UnityObjectToClipPos(o.vertex);

	frame.o = o;
}

void LerpBetweenMeshesCorrupted(uint frameA, uint frameB, float speed, float rotateO = 0, float rotateF = 0)
{
	v2f o = frame.o;
	uint i = frame.vID % 3;
	float4 oVertex = getVertexFromTextureOrOriginal(frameA, o.vertex, rotateO);
	float4 fVertex = getVertexFromTextureOrOriginal(frameB, o.vertex, rotateF);
	if (fVertex.w > 0) {
		if (i == 0) {
			float n = _Time.y + frame.triID;
			fVertex.x += cos(n * 33) / 100;
			fVertex.y += sin(n * 66) / 100;
			fVertex.z += cos(n * 100) / 100;
			fVertex.w = 0;
		}
	}
	float l = saturate(_CurrentTime * speed);
	o.vertex = lerp(oVertex, fVertex, l);
	o.color = o.vertex.w;

	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}

void LerpBetweenMeshesWithChaos(uint frameA, uint frameB, float speed, float triFloat, float rotateO = 0, float rotateF = 0, bool blink = false)
{
	uint id = frame.vID;

	v2f o = frame.o;

	float4 oVertex = getVertexFromTexture(frameA, rotateO);
	float4 fVertex = getVertexFromTexture(frameB, rotateF);
	float l = saturate(_CurrentTime * speed);

	float4 sVertex = lerp(oVertex, fVertex, l);
	if (sVertex.w > 0 && blink) {
		float blinkt = cos(_CurrentTime * 10);
		if (blinkt >= 0) {
			sVertex = fVertex;
		}
		else {
			sVertex = o.vertex;
			sVertex.w = 0;
		}
	}

	//add chaos.
	o.vertex.w = 0;

	o.vertex = lerp(o.vertex, sVertex, triFloat);
	o.color = o.vertex.w;

	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}

void SlideBetweenMeshes(uint frameA, uint frameB, float speed, uint i, float rotateO = 0, float rotateF = 0)
{
	uint x = frameA % 32;
	uint y = frameA / 32;

	float4 md = _MeshIndicies.Load(int3(x, y, 0));
	uint posA = md.x;
	uint sizeA = md.y;

	float s = sizeA / 3;
	float n = frame.triID % s;
	float triFloat = 1 - (n / s);

	uint id = frame.vID;

	v2f o = frame.o;

	float4 oVertex = getVertexFromTextureOrOriginal(frameA, o.vertex, rotateO);
	float4 fVertex = getVertexFromTextureOrOriginal(frameB, o.vertex, rotateF);
	float l = saturate((_CurrentTime * speed) + triFloat);
	o.vertex = lerp(oVertex, fVertex, l);
	o.color = o.vertex.w;

	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}