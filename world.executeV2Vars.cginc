struct appdata
{
	float4 vertex : POSITION;
	float4 color : COLOR;
	float2 uv : TEXCOORD0;
	float2 ids : TEXCOORD1;
	uint id : SV_VertexID;
};

struct v2f
{
	float4 color : COLOR;
	float2 uv : TEXCOORD0;
	float4 vertex : SV_POSITION;
	float2 barycentric : BARYCENTRIC;
	float2 ids : TEXCOORD1;
	uint id : ID;
};

struct FrameData
{
	uint triID;
	uint vID;
	v2f o;
};

float _EdgeWidth;
uint _StartTime;
float _CurrentTime;
bool _Play;
float timePosition;
float _Scale;
bool _Loop;
uint _LoopTime;

static const float bpm = 13.613568165555770700004787994211; // formula: 130bpm / 60secs * pi * 2

FrameData frame;

Texture2D<float4> _Meshes;
Texture2D<float4> _MeshIndicies;

//Animation Meshes
uint _ButtonI;
float _ButtonF;

uint _SwitchOffI;
float _SwitchOffF;

uint _SwitchOnI;
float _SwitchOnF;

uint _PowerLineI;
float _PowerLineF;

uint _ProtectionI;
float _ProtectionF;

uint _PiecesI;
float _PiecesF;

uint _ProcreationI;
float _ProcreationF;

uint _DataI;
float _DataF;

uint _InitializeI;
float _InitializeF;

uint _WorldI;
float _WorldF;

uint _SimulationI;
float _SimulationF;

uint _ChaosAI;

uint _ChaosBI;

uint _ChaosCI;

uint _ChaosDI;

float _ChaosF;

uint _PointsI;
float _PointsF;

uint _PDimensionsI;
float _PDimensionsF;

uint _CircleI;
float _CircleF;

uint _CircumferenceI;
float _CircumferenceF;

uint _SineWaveI;
float _SineWaveF;

uint _TangentsI;
float _TangentsF;

float _InfiniteF;

uint _LimitationI;
float _LimitationF;

uint _CurrentI;
float _CurrentF;

uint _ACI;
float _ACF;

uint _DCI;
float _DCF;

uint _BlindI;
float _BlindF;

uint _DizzyI;
float _DizzyF;

uint _TravelTimeI;
float _TravelTimeF;

uint _ADI;
float _ADF;

uint _BCI;
float _BCF;

float _UniteF;

uint _SoDeeplyI;
float _SoDeeplyF;

float _Me2F;

uint _StimulationI;
float _StimulationF;

float _Me3F;

uint _SatisfactionI;
float _SatisfactionF;

float _Me4F;

uint _ExecutionI;
float _ExecutionF;

float _Me5F;

float _Simulation2F;

uint _EggplantI;
float _EggplantF;

uint _NutrientsI;
float _NutrientsF;

uint _TomatoI;
float _TomatoF;

uint _AntioxidentsI;
float _AntioxidentsF;

uint _TabbyCatI;
float _TabbyCatF;

uint _PurrI;
float _PurrF;

uint _GodI;
float _GodF;

uint _ExistanceI;
float _ExistanceF;

uint _FemaleI;
float _FemaleF;

uint _MaleI;
float _MaleF;

uint _AMI;
float _AMF;

uint _PMI;
float _PMF;

uint _SaddistI;
float _SaddistF;

uint _MasocistI;
float _MasocistF;

uint _TranceI;
float _TranceF;

uint _VibrationI;
float _VibrationF;

uint _CompletionI;
float _CompletionF;

uint _IsolationI;
float _IsolationF;

uint _EraseI;
float _EraseF;

uint _DisheartenedI;
float _DisheartenedF;

uint _God2I;
float _God2F;

uint _IllegalI;
float _IllegalF;

uint _CorruptionI;
float _CorruptionF;

uint _Execution2I;
float _Execution2F;

uint _CountI;
float _CountF;

uint _Execution3I;
float _Execution3F;

uint _TrappedI;
float _TrappedF;

uint _LoveStudiedI;
float _LoveStudiedF;

uint _LoveAnswerI;
float _LoveAnswerF;

uint _LoveAlgebraicI;
float _LoveAlgebraicF;

uint _TrappedInLoveI;
float _TrappedInLoveF;

uint _HeartI;
float _HeartF;

uint _MeI;
float _MeF;