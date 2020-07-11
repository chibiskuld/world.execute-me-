void FrameStart() {
	v2f o = frame.o;

	float4 oVertex = getVertexFromTexture(_ButtonI);

	float4 fVertex = getVertexFromTextureOrOriginal(_SwitchOffI, o.vertex);
	float l = saturate(_CurrentTime * 4);

	o.vertex = lerp(oVertex, fVertex, l);
	o.color = o.vertex.w;

	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}


void FramePieces() {
	v2f o = frame.o;

	float4 oVertex = getVertexFromTextureOrOriginal(_ProtectionI, o.vertex);
	float4 fVertex = getVertexFromTextureOrOriginal(_PiecesI, o.vertex);
	float l = saturate(_CurrentTime * 4);
	o.vertex = lerp(oVertex, fVertex, l);
	if (o.vertex.w > 0) {
		float s = 1 - ((_CurrentTime - .75f) * 4);
		o.vertex.z += saturate(s)*.01;
	}
	o.color = o.vertex.w;

	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}

void FrameInifinite() {
	v2f o = frame.o;
	o.vertex.w = 0;
	uint i = frame.vID % 3;

	if ((float)frame.triID < (float)_CurrentTime * (float)100.0f) {
		float s = 2.0f / ((float)frame.triID + 1.0f);
		s = min(1.4f, s);
		s /= 10.0f;
		//s += .0001f;
		float x = 0;
		float z = 0;
		switch (i) {
			case 0:
				x = -s;
				z = -s;
				break;
			case 1:
				x = s;
				z = -s;
				break;
			case 2:
				x = 0;
				z = s;
				break;
		}
		float y = (float)frame.triID / 1000.0f;
		float4 iVertex = float4(x, z, y, 1);

		float l = _CurrentTime - ((float)frame.triID / 100.0f);
		l = saturate(l * 4.0f);
		o.vertex = lerp(o.vertex, iVertex, l);
	}

	o.color = o.vertex.w;
	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}

void FrameLimitation() {
	uint x = _LimitationI % 32;
	uint y = _LimitationI / 32;
	float4 md = _MeshIndicies.Load(int3(x, y, 0));
	uint size = md.a * 2048 + md.b;

	v2f o = frame.o;
	o.vertex.w = 0;
	float t = _CurrentF - _LimitationF - .5f;
	uint i = frame.vID % 3;

	if (frame.vID > size) {
		float tid = frame.triID - (size / 3.0f);
		if (tid < (t - _CurrentTime)*400.0f) {
			float s = 2.0f / ((float)tid + 1.0f);
			s = min(1.4f, s);
			s /= 10.0f;
			//s += .0001f;
			float x = 0;
			float z = 0;
			switch (i) {
			case 0:
				x = -s;
				z = -s;
				break;
			case 1:
				x = s;
				z = -s;
				break;
			case 2:
				x = 0;
				z = s;
				break;
			}
			float y = tid / 1000.0f;
			float4 iVertex = float4(x, z, y, 1);

			o.vertex = iVertex;
		}
	}
	else {
		o.vertex.w = 0;
		float4 fVertex = getVertexFromTextureOrOriginal(_LimitationI, o.vertex);
		if (fVertex.w > 0) {
			t = (t - _CurrentTime);
			t /= 2;
			fVertex.z += t;
		}
		float l = saturate(_CurrentTime* 4.0f);

		o.vertex = lerp(o.vertex, fVertex, l);
	}
	o.color = o.vertex.w;
	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}

void IsolationFrame() {
	v2f o = frame.o;
	float4 pVertex = getVertexFromTextureOrOriginal(_CompletionI, o.vertex);
	float4 fVertex = getVertexFromTextureOrOriginal(_IsolationI, o.vertex);
	if (fVertex.w > 0) {
		float t = _EraseF - _IsolationF;
		fVertex.y *= min(1, (_CurrentTime / t)) / _Scale;
		if (_CurrentTime >= t) {
			t = saturate( (_CurrentTime - t)/2 );
			fVertex = lerp(fVertex, frame.o.vertex, t);
			fVertex.w = 1-t;
		}
	}
	float l = saturate(_CurrentTime*4);
	o.vertex = lerp(pVertex, fVertex, l);
	o.color = o.vertex.w;
	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}

void VibrationFrame() {
	v2f o = frame.o;
	float4 pVertex = getVertexFromTextureOrOriginal(_TranceI, o.vertex);
	float4 fVertex = getVertexFromTextureOrOriginal(_VibrationI, o.vertex);
	if (_CurrentTime > 2.0f) {
		if (fVertex.w > 0) {
			fVertex.x += cos((fVertex.z + _Time.x) * 10000) / 1000;
		}
	}
	float l = saturate(_CurrentTime);
	o.vertex = lerp(pVertex, fVertex,l);
	o.color = o.vertex.w;
	o.vertex = UnityObjectToClipPos(o.vertex);
	frame.o = o;
}


void GenericFrameChaos(uint ptex, uint tex, float pspin = 0, float spin = 0, bool blink = false) {
	uint x = tex % 32;
	uint y = tex / 32;

	float4 md = _MeshIndicies.Load(int3(x, y, 0));
	float s = (float)md.y / 3.0f;

	float n = frame.triID % s;
	float triFloat = n / s;
	triFloat = 6.283185f * triFloat;
	triFloat = cos(triFloat*100.0f + _Time.x / 10.0f) / 2.0f + .5f;
	triFloat = saturate(triFloat * 3);

	uint i = frame.o.id % 3;
	LerpBetweenMeshesWithChaos(
		ptex,
		tex,
		2, triFloat,
		pspin, spin, blink
	);
}

void GenericFrame(uint ptex, uint tex, float pspin = 0, float spin = 0)
{
	/*
		I was going to get rid of the generic frames, but in case I ever reuse/expand this, 
		it may end up having logic added just like GenericFrameChaos. So as a just in case 
		there is ever custom logic needed here before accessing the lerp method, I will 
		let this remain.
	*/
	LerpBetweenMeshes(
		ptex,
		tex,
		4,
		pspin, spin
	);
}

void GenericFrameCorrupted(uint ptex, uint tex, float pspin = 0, float spin = 0)
{
	LerpBetweenMeshesCorrupted(
		ptex,
		tex,
		4,
		pspin, spin
	);
}