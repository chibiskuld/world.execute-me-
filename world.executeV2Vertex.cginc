v2f vert(appdata v)
{
	v2f o;
	o.vertex = v.vertex;
	o.uv = v.uv;
	o.id = v.id;
	o.ids = v.ids;

	frame.o = o;

	frame.vID = v.ids.y;
	frame.triID = v.ids.x;

	//things that must happen every key frame:
	int i = o.uv.x + o.uv.y;
	//generates what two verticies are opposing. Basically, the barycentric coordinates.
	frame.o.barycentric = float2(fmod(i, 2.0), step(2.0, i)); 

	frame.o.vertex.xy = rotate2(frame.o.vertex.xy, _Time.x);

	//adjust time before executing key frame.
	if (_Play != 0) {
		_CurrentTime = _Time.y - _StartTime;
	}

	/******************************************************************************
		Key Frames
			going backwards from end to start. 
			This allows for the routine to escape early and not parse logic, 
			but also Makes it easier to scale.
			Unfortunately, this means logic at start is slower, than at the end
			of the simulation.
	******************************************************************************/
	if (_CurrentTime >= _TrappedInLoveF) {
		_CurrentTime -= _TrappedInLoveF;
		GenericFrameChaos(
			_LoveAlgebraicI,
			_TrappedInLoveI
		);
		return frame.o;
	}
	if (_CurrentTime >= _LoveAlgebraicF) {
		_CurrentTime -= _LoveAlgebraicF;
		GenericFrameChaos(
			_LoveAnswerI,
			_LoveAlgebraicI
		);
		return frame.o;
	}
	if (_CurrentTime >= _LoveAnswerF) {
		_CurrentTime -= _LoveAnswerF;
		GenericFrameChaos(
			_LoveStudiedI,
			_LoveAnswerI
		);
		return frame.o;
	}
	if (_CurrentTime >= _LoveStudiedF) {
		_CurrentTime -= _LoveStudiedF;
		GenericFrameChaos(
			_TrappedI,
			_LoveStudiedI
		);
		return frame.o;
	}
	if (_CurrentTime >= _TrappedF) {
		_CurrentTime -= _TrappedF;
		GenericFrameChaos(
			_Execution3I,
			_TrappedI,
			2, 0
		);
		return frame.o;
	}if (_CurrentTime >= _Execution3F) {
		_CurrentTime -= _Execution3F;
		GenericFrameChaos(
			_CountI,
			_Execution3I,
			0, 2, true
		);
		return frame.o;
	}
	if (_CurrentTime >= _CountF) {//LFM: Read notes. (New Component)
		_CurrentTime -= _CountF;
		GenericFrameChaos(
			_Execution2I,
			_CountI
		);
		return frame.o;
	}
	if (_CurrentTime >= _Execution2F) { //LFM: Read notes. (New Component)
		_CurrentTime -= _Execution2F;
		GenericFrameCorrupted(
			_IllegalI,
			_Execution2I
		);
		return frame.o;
	}
	if (_CurrentTime >= _IllegalF) { //LFM: Read notes.
		_CurrentTime -= _IllegalF;
		GenericFrameCorrupted(
			_God2I,
			_IllegalI
		);
		return frame.o;
	}
	if (_CurrentTime >= _God2F) {
		_CurrentTime -= _God2F;
		GenericFrame(
			_DisheartenedI,
			_God2I
		);
		return frame.o;
	}
	if (_CurrentTime >= _DisheartenedF) {
		_CurrentTime -= _DisheartenedF;
		GenericFrame(
			_IsolationI,
			_DisheartenedI
		);
		return frame.o;
	}
	if (_CurrentTime >= _IsolationF) {//LFM: Read Notes on special behaviour of _EraseF that goes along with this.
		_CurrentTime -= _IsolationF;
		IsolationFrame();
		return frame.o;
	}
	if (_CurrentTime >= _CompletionF) {
		_CurrentTime -= _CompletionF;
		GenericFrame(
			_VibrationI,
			_CompletionI
		);
		return frame.o;
	}
	if (_CurrentTime >= _VibrationF) {
		_CurrentTime -= _VibrationF;
		VibrationFrame();
		return frame.o;
	}
	if (_CurrentTime >= _TranceF) {
		_CurrentTime -= _TranceF;
		GenericFrame(
			_MasocistI,
			_TranceI
		);
		return frame.o;
	}
	if (_CurrentTime >= _MasocistF) {
		_CurrentTime -= _MasocistF;
		GenericFrame(
			_SaddistI,
			_MasocistI
		);
		return frame.o;
	}
	if (_CurrentTime >= _SaddistF) {
		_CurrentTime -= _SaddistF;
		GenericFrame(
			_PMI,
			_SaddistI
		);
		return frame.o;
	}
	if (_CurrentTime >= _PMF) {
		_CurrentTime -= _PMF;
		GenericFrame(
			_AMI,
			_PMI
		);
		return frame.o;
	}
	if (_CurrentTime >= _AMF) {
		_CurrentTime -= _AMF;
		GenericFrame(
			_MaleI,
			_AMI
		);
		return frame.o;
	}
	if (_CurrentTime >= _MaleF) {
		_CurrentTime -= _MaleF;
		GenericFrame(
			_FemaleI,
			_MaleI
		);
		return frame.o;
	}
	if (_CurrentTime >= _FemaleF) {
		_CurrentTime -= _FemaleF;
		GenericFrame(
			_ExistanceI,
			_FemaleI
		);
		return frame.o;
	}
	if (_CurrentTime >= _ExistanceF) {
		_CurrentTime -= _ExistanceF;
		GenericFrame(
			_GodI,
			_ExistanceI
		);
		return frame.o;
	}
	if (_CurrentTime >= _GodF) {
		_CurrentTime -= _GodF;
		GenericFrame(
			_PurrI,
			_GodI
		);
		return frame.o;
	}
	if (_CurrentTime >= _PurrF) {
		_CurrentTime -= _PurrF;
		GenericFrame(
			_TabbyCatI,
			_PurrI
		);
		return frame.o;
	}
	if (_CurrentTime >= _TabbyCatF) {
		_CurrentTime -= _TabbyCatF;
		GenericFrame(
			_AntioxidentsI,
			_TabbyCatI
		);
		return frame.o;
	}
	if (_CurrentTime >= _AntioxidentsF) {
		_CurrentTime -= _AntioxidentsF;
		GenericFrame(
			_TomatoI,
			_AntioxidentsI
		);
		return frame.o;
	}
	if (_CurrentTime >= _TomatoF) {
		_CurrentTime -= _TomatoF;
		GenericFrame(
			_NutrientsI,
			_TomatoI
		);
		return frame.o;
	}
	if (_CurrentTime >= _NutrientsF) {
		_CurrentTime -= _NutrientsF;
		GenericFrame(
			_EggplantI,
			_NutrientsI
		);
		return frame.o;
	}
	if (_CurrentTime >= _EggplantF) {
		_CurrentTime -= _EggplantF;
		GenericFrame(
			_SimulationI,
			_EggplantI
		);
		return frame.o;
	}
	if (_CurrentTime >= _Simulation2F) {
		_CurrentTime -= _Simulation2F;
		GenericFrameChaos(
			_MeI,
			_SimulationI
		);
		return frame.o;
	}
	if (_CurrentTime >= _Me5F) {
		_CurrentTime -= _Me5F;
		GenericFrameChaos(
			_ExecutionI,
			_MeI
		);
		return frame.o;
	}
	if (_CurrentTime >= _ExecutionF) {
		_CurrentTime -= _ExecutionF;
		GenericFrameChaos(
			_ChaosAI,
			_ExecutionI
		);
		return frame.o;
	}
	if (_CurrentTime >= _Me4F) {
		_CurrentTime -= _Me4F;
		GenericFrameChaos(
			_SatisfactionI,
			_ChaosAI
		);
		return frame.o;
	}
	if (_CurrentTime >= _SatisfactionF) {
		_CurrentTime -= _SatisfactionF;
		GenericFrameChaos(
			_BlindI,
			_SatisfactionI
		);
		return frame.o;
	}
	if (_CurrentTime >= _Me3F) {
		_CurrentTime -= _Me3F;
		GenericFrameChaos(
			_StimulationI,
			_BlindI
		);
		return frame.o;
	}
	if (_CurrentTime >= _StimulationF) {
		_CurrentTime -= _StimulationF;
		GenericFrameChaos(
			_ChaosCI,
			_StimulationI
		);
		return frame.o;
	}
	if (_CurrentTime >= _Me2F) {
		_CurrentTime -= _Me2F;
		GenericFrameChaos(
			_SoDeeplyI,
			_ChaosCI
		);
		return frame.o;
	}
	if (_CurrentTime >= _SoDeeplyF) {
		_CurrentTime -= _SoDeeplyF;
		GenericFrame(
			_ChaosCI, //from
			_SoDeeplyI
		);
		return frame.o;
	}
	if (_CurrentTime >= _UniteF) {
		_CurrentTime -= _UniteF;
		GenericFrame(
			_BCI, //from
			_ChaosCI
		);
		return frame.o;
	}
	if (_CurrentTime >= _BCF) {
		_CurrentTime -= _BCF;
		GenericFrame(
			_ADI, //from
			_BCI
		);
		return frame.o;
	}
	if (_CurrentTime >= _ADF) {
		_CurrentTime -= _ADF;
		GenericFrame(
			_TravelTimeI, //from
			_ADI, //to
			0, 0 //spin
		);
		return frame.o;
	}
	if (_CurrentTime >= _TravelTimeF) {
		_CurrentTime -= _TravelTimeF;
		GenericFrame(
			_DizzyI, //from
			_TravelTimeI, //to
			40, 0 //spin
		);
		return frame.o;
	}
	if (_CurrentTime >= _DizzyF) {
		_CurrentTime -= _DizzyF;
		GenericFrame(
			_BlindI, //from
			_DizzyI, //to
			0, 40 //spin
		);
		return frame.o;
	}
	if (_CurrentTime >= _BlindF) {
		_CurrentTime -= _BlindF;
		GenericFrame(
			_DCI, //from
			_BlindI
		);
		return frame.o;
	}
	if (_CurrentTime >= _DCF) {
		_CurrentTime -= _DCF;
		GenericFrame(
			_ACI, //from
			_DCI
		);
		return frame.o;
	}
	if (_CurrentTime >= _ACF) {
		_CurrentTime -= _ACF;
		GenericFrame(
			_CurrentI, //from
			_ACI
		);
		return frame.o;
	}
	if (_CurrentTime >= _CurrentF) {
		_CurrentTime -= _CurrentF;
		GenericFrame(
			_LimitationI, //from
			_CurrentI
		);
		return frame.o;
	}
	if (_CurrentTime >= _LimitationF) {
		_CurrentTime -= _LimitationF;
		FrameLimitation();
		return frame.o;
	}
	if (_CurrentTime >= _InfiniteF) {
		_CurrentTime -= _InfiniteF;
		FrameInifinite();
		return frame.o;
	}
	if (_CurrentTime >= _TangentsF) {
		_CurrentTime -= _TangentsF;
		GenericFrame(
			_SineWaveI, //from
			_TangentsI
		);
		return frame.o;
	}
	if (_CurrentTime >= _SineWaveF) {
		_CurrentTime -= _SineWaveF;
		GenericFrame(
			_CircumferenceI, //from
			_SineWaveI
		);
		return frame.o;
	}
	if (_CurrentTime >= _CircumferenceF) {
		_CurrentTime -= _CircumferenceF;
		GenericFrame(
			_CircleI, //from
			_CircumferenceI
		);
		return frame.o;
	}
	if (_CurrentTime >= _CircleF) {
		_CurrentTime -= _CircleF;
		GenericFrame(
			_PDimensionsI, //from
			_CircleI
		);
		return frame.o;
	}
	if (_CurrentTime >= _PDimensionsF) {
		_CurrentTime -= _PDimensionsF;
		GenericFrame(
			_PointsI,
			_PDimensionsI
		);
		return frame.o;
	}
	if (_CurrentTime >= _PointsF) {
		_CurrentTime -= _PointsF;
		LerpBetweenMeshes( _ChaosCI, _PointsI, 4, 1, 0 );
		return frame.o;
	}
	if (_CurrentTime >= _ChaosF + 10) {
		_CurrentTime -= _ChaosF + 10;
		GenericFrameChaos(_ChaosBI, _ChaosCI, 1, 1);
		return frame.o;
	}
	if (_CurrentTime >= _ChaosF + 5) {
		_CurrentTime -= _ChaosF + 5;
		GenericFrameChaos(_ChaosAI, _ChaosBI, 1, 1);
		return frame.o;
	}
	if (_CurrentTime >= _ChaosF) {
		_CurrentTime -= _ChaosF;
		GenericFrameChaos(_SimulationI, _ChaosAI,0,1);
		return frame.o;
	}
	if (_CurrentTime >= _SimulationF) {
		_CurrentTime -= _SimulationF;
		SlideBetweenMeshes( _WorldI, _SimulationI, 2, 1, 0 );
		return frame.o;
	}
	if (_CurrentTime >= _WorldF) {
		_CurrentTime -= _WorldF;
		LerpBetweenMeshes( _InitializeI, _WorldI, 2, 0, 1 );
		return frame.o;
	}
	if (_CurrentTime >= _InitializeF) {
		_CurrentTime -= _InitializeF;
		LerpBetweenMeshes(_DataI, _InitializeI, 4, 0, 0, true);
		return frame.o;
	}
	if (_CurrentTime >= _DataF) {
		_CurrentTime -= _DataF;
		GenericFrame( _ProcreationI, _DataI );
		return frame.o;
	}
	if (_CurrentTime >= _ProcreationF) {
		_CurrentTime -= _ProcreationF;
		GenericFrame( _PiecesI, _ProcreationI );
		return frame.o;
	}
	if (_CurrentTime >= _PiecesF) {
		_CurrentTime -= _PiecesF;
		FramePieces();
		return frame.o;
	}
	if (_CurrentTime >= _ProtectionF) {
		_CurrentTime -= _ProtectionF;
		GenericFrame( _PowerLineI, _ProtectionI );
		return frame.o;
	}
	if (_CurrentTime >= _PowerLineF) {
		_CurrentTime -= _PowerLineF;
		GenericFrame( _SwitchOnI, _PowerLineI );
		return frame.o;
	}

	if (_CurrentTime >= _SwitchOnF) {
		_CurrentTime -= _SwitchOnF;
		GenericFrame( _SwitchOffI, _SwitchOnI );
		return frame.o;
	}

	FrameStart();
	return frame.o;
}