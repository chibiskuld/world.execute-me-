Shader "world.executeV2(Quest);"
{
    //song: 130bpm
    //world.execute.fbx either has 194,877 verts

	Properties
	{
		_EdgeWidth("Edge Width", float) = .1
		_StartTime("Start Time", int) = 0
		_CurrentTime("Force Current Time (For Debug)",int) = 0
        [Toggle]_Play("Play animation", int) = 0
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Source Blend", Float) = 1                 // "One"
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Destination Blend", Float) = 0            // "Zero"
		[Enum(UnityEngine.Rendering.CullMode)] _CullMode("Cull Mode", Float) = 2                     // "Back"
		[Toggle] _ZWrite("Z-Write",Float) = 1

		_Meshes("Meshes", 2D) = "white" {}
		_MeshIndicies("MeshIndicies", 2D) = "white" {}

		_ButtonI("Button",int) = 0
		_ButtonF("Button Frame Time",float) = 0

        _SwitchOffI("Switch Off", int) = 0
        _SwitchOffF("Switch Off Frame Time",float) = 0

        _SwitchOnI("Switch On Shape", int) = 0
        _SwitchOnF("Switch On Frame Time",float) = 0

        _PowerLineI("Power Line Shape", int) = 0
        _PowerLineF("Power Line Frame Time",float) = 0

        _ProtectionI("Protection Shape", int) = 0
        _ProtectionF("Protection Frame Time",float) = 0

        _PiecesI("Pieces Shape", int) = 0
        _PiecesF("Pieces Frame Time",float) = 0

        _ProcreationI("Procreation Shape", int) = 0
        _ProcreationF("Procreation Frame Time",float) = 0

        _DataI("Data Shape", int) = 0
        _DataF("Data Frame Time",float) = 0

        _InitializeI("Initialize Shape", int) = 0
        _InitializeF("Initialize Frame Time",float) = 0

        _WorldI("World Shape", int) = 0
        _WorldF("World Frame Time",float) = 0

        _SimulationI("Simulation Shape", int) = 0
        _SimulationF("Simulation Frame Time",float) = 0

        _ChaosAI("Chaos A Shape", int) = 0

        _ChaosBI("Chaos B Shape", int) = 0

        _ChaosCI("Chaos C Shape", int) = 0

        _ChaosDI("Chaos D Shape", int) = 0
        _ChaosF("Chaos Frame Time",float) = 0

        _PointsI("Points Shape", int) = 0
        _PointsF("Points Frame Time",float) = 0

        _PDimensionsI("Dimensions Shape", int) = 0
        _PDimensionsF("Dimensions Frame Time",float) = 0

        _CircleI("Circle Shape", int) = 0
        _CircleF("Circle Frame Time",float) = 0

        _CircumferenceI("Circumference Shape", int) = 0
        _CircumferenceF("Circumference Frame Time",float) = 0

        _SineWaveI("Sine Wave Shape", int) = 0
        _SineWaveF("Sine Wave Frame Time",float) = 0

        _TangentsI("Tangents Shape", int) = 0
        _TangentsF("Tangents Frame Time",float) = 0

        //infinite
        _InfiniteF("Infinite Frame Time",float) = 0

        _LimitationI("Limitation Shape", int) = 0
        _LimitationF("Limitation Frame Time",float) = 0

        _CurrentI("Current Shape", int) = 0
        _CurrentF("Current Frame Time",float) = 0

        _ACI("AC Shape", int) = 0
        _ACF("AC Frame Time",float) = 0

        _DCI("DC Shape", int) = 0
        _DCF("DC Frame Time",float) = 0

        _BlindI("Blind Shape", int) = 0
        _BlindF("Blind Frame Time",float) = 0

        _DizzyI("Dizzy Shape", int) = 0
        _DizzyF("Dizzy Frame Time",float) = 0

        _TravelTimeI("TravelTime Shape", int) = 0
        _TravelTimeF("TravelTime Frame Time",float) = 0

        _ADI("AD Shape", int) = 0
        _ADF("AD Frame Time",float) = 0

        _BCI("BC Shape", int) = 0
        _BCF("BC Frame Time",float) = 0

        //Unite
        _UniteF("Unite Frame Time",float) = 0

        _SoDeeplyI("SoDeeply Shape", int) = 0
        _SoDeeplyF("SoDeeply Frame Time",float) = 0

        //me
        _Me2F("Me Frame Time", float) = 0

        _StimulationI("Stimulation Shape", int) = 0
        _StimulationF("Stimulation Frame Time", float) = 0
        //me
        _Me3F("Me Frame Time", float) = 0

        _SatisfactionI("Satisfaction Shape", int) = 0
        _SatisfactionF("Satisfaction Frame Time", float) = 0

        //me
        _Me4F("Me Frame Time", float) = 0

        _ExecutionI("Execution Shape", int) = 0
        _ExecutionF("Execution Frame Time", float) = 0

        _Me5F("Me Frame Time", float) = 0

        _Simulation2F("Simulation Frame Time", float) = 0

        _EggplantI("Eggplant Shape", int) = 0
        _EggplantF("Eggplant Frame Time", float) = 0

        _NutrientsI("Nutrients Shape", int) = 0
        _NutrientsF("Nutrients Frame Time", float) = 0

        _TomatoI("Tomato Shape", int) = 0
        _TomatoF("Tomato Frame Time", float) = 0

        _AntioxidentsI("Antioxidents Shape", int) = 0
        _AntioxidentsF("Antioxidents Frame Time", float) = 0

        _TabbyCatI("Tabby Cat Shape", int) = 0
        _TabbyCatF("Tabbybat Frame Time", float) = 0

        _PurrI("Purr Shape", int) = 0
        _PurrF("Purr Frame Time", float) = 0

        _GodI("God Shape", int) = 0
        _GodF("God Frame Time", float) = 0

        _ExistanceI("Existance Shape", int) = 0
        _ExistanceF("Existance Frame Time", float) = 0

        _FemaleI("Female Shape", int) = 0
        _FemaleF("Female Frame Time", float) = 0

        _MaleI("Male Shape", int) = 0
        _MaleF("Male Frame Time", float) = 0

        _AMI("AM Shape", int) = 0
        _AMF("AM Frame Time", float) = 0

        _PMI("PM Shape", int) = 0
        _PMF("PM Frame Time", float) = 0

        _SaddistI("Saddist Shape", int) = 0
        _SaddistF("Saddist Frame Time", float) = 0

        _MasocistI("Masocist Shape", int) = 0
        _MasocistF("Masocist Frame Time", float) = 0

        _TranceI("Trance Shape", int) = 0
        _TranceF("Trance Frame Time", float) = 0

        _VibrationI("Vibration Shape", int) = 0
        _VibrationF("Vibration Frame Time", float) = 0

        _CompletionI("Completion Shape", int) = 0
        _CompletionF("Completion Frame Time", float) = 0

        _IsolationI("Isolation Shape", int) = 0
        _IsolationF("Isolation Frame Time", float) = 0
        _EraseF("Erase Frame Time", float) = 0

        _DisheartenedI("Disheartened Shape", int) = 0
        _DisheartenedF("Disheartened Frame Time", float) = 0

        _God2I("God2 Shape", int) = 0
        _God2F("God2 Frame Time", float) = 0

        _IllegalI("Illegal Shape", int) = 0
        _IllegalF("Illegal Frame Time", float) = 0

        _Execution2I("Execution2 Shape", int) = 0
        _Execution2F("Execution2 Frame Time", float) = 0

		_CountI("Count Shape", int) = 0
		_CountF("Count Frame Time", float) = 0

        _Execution3I("Execution3 Shape", int) = 0
        _Execution3F("Execution3 Frame Time", float) = 0

        _TrappedI("Trapped Shape", int) = 0
        _TrappedF("Trapped Frame Time", float) = 0

        _LoveStudiedI("LoveStudied Shape", int) = 0
        _LoveStudiedF("LoveStudied Frame Time", float) = 0

        _LoveAnswerI("LoveAnswer Shape", int) = 0
        _LoveAnswerF("LoveAnswer Frame Time", float) = 0

        _LoveAlgebraicI("Love Algebraic Shape", int) = 0
        _LoveAlgebraicF("Love Algebraic Frame Time", float) = 0

        _TrappedInLoveI("TrappedInLove Shape", int) = 0
        _TrappedInLoveF("TrappedInLove Frame Time", float) = 0

        _HeartI("Heart Shape", int) = 0
        _HeartF("Heart Frame Time", float) = 0

        //the end
        _MeI("My Shape", int) = 0
        _MeF("My Frame Time",float) = 0
    }

    SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}

        Cull off
        Lighting Off
        SeparateSpecular Off
		Blend[_SrcBlend][_DstBlend]
		Cull[_CullMode]
		ZWrite[_ZWrite]

        Pass
        {
            CGPROGRAM
			#pragma target 4.0
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "world.executeV2Core.cginc"
            ENDCG
        }
    }
}
