// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Xuqi/HologramUnlit"
{
	Properties
	{
		[Header(_____Main_____)]_Texture_Main("Texture_Main", 2D) = "white" {}
		_FinalTransparency("FinalTransparency", Range( 0 , 1)) = 1
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		_MainTextureColorIntensity("MainTextureColorIntensity", Range( 0 , 5)) = 1
		[Header(_____Emission_____)]_Texture_Emission("Texture_Emission", 2D) = "black" {}
		[HDR]_EmissionColor("EmissionColor", Color) = (1,1,1,1)
		[Header(_____ScanType_____)][Toggle]_ColorScanMultiplyOrAdd("ColorScanMultiplyOrAdd", Float) = 1
		[Header(_____Scan1_____)][Toggle(_SCAN1SWITCH_ON)] _Scan1Switch("Scan1Switch", Float) = 0
		_Texture_Scan1("Texture_Scan1", 2D) = "black" {}
		_Scan1ColorValue0("Scan1ColorValue0", Color) = (1,1,1,1)
		_Scan1ColorValue1("Scan1ColorValue1", Color) = (1,1,1,1)
		_Scan1Speed("Scan1Speed", Vector) = (0,0,0,0)
		_Scan1Scale("Scan1Scale", Range( 0 , 2)) = 1
		_Scan1Offset("Scan1Offset", Range( -1 , 1)) = 0
		[Toggle]_Scan1CancelGradient("Scan1CancelGradient", Float) = 0
		_Scan1ColorIntensity("Scan1ColorIntensity", Range( 0 , 10)) = 1
		_Scan1TillingAndOffset("Scan1TillingAndOffset", Vector) = (1,1,0,0)
		[Toggle]_Scan1WithUV("Scan1WithUV", Float) = 0
		[Toggle]_Scan1NoiseSwitch("Scan1NoiseSwitch", Float) = 0
		_Scan1Noise("Scan1Noise", 2D) = "black" {}
		_Scan1NoiseTillingAndOffset("Scan1NoiseTillingAndOffset", Vector) = (1,1,0,0)
		_Scan1NoiseScaleAndOffset("Scan1NoiseScaleAndOffset", Vector) = (3,0,0,0)
		_Scan1NoiseSpeed("Scan1NoiseSpeed", Vector) = (0,0,0,0)
		_Scan1BreathSpeed("Scan1BreathSpeed", Range( 0 , 10)) = 0
		_Scan1BreathShapeValue("Scan1BreathShapeValue", Range( -1 , 1)) = 0
		_Scan1BreathAlphaValue("Scan1BreathAlphaValue", Range( -1 , 1)) = 0
		[Header(_____Scan2_____)][Toggle(_SCAN2SWITCH_ON)] _Scan2Switch("Scan2Switch", Float) = 0
		_Texture_Scan2("Texture_Scan2", 2D) = "white" {}
		_Scan2ColorValue0("Scan2ColorValue0", Color) = (1,1,1,1)
		_Scan2ColorValue1("Scan2ColorValue1", Color) = (1,1,1,1)
		_Scan2Speed("Scan2Speed", Vector) = (0,0,0,0)
		_Scan2Scale("Scan2Scale", Range( 0 , 2)) = 1
		_Scan2Offset("Scan2Offset", Range( -1 , 1)) = 0
		[Toggle]_Scan2CancelGradient("Scan2CancelGradient", Float) = 0
		_Scan2ColorIntensity("Scan2ColorIntensity", Range( 0 , 10)) = 1
		_Scan2TillingAndOffset("Scan2TillingAndOffset", Vector) = (1,1,0,0)
		[Toggle]_Scan2WithUV("Scan2WithUV", Float) = 0
		[Toggle]_Scan2NoiseSwitch("Scan2NoiseSwitch", Float) = 0
		_Scan2Noise("Scan2Noise", 2D) = "black" {}
		_Scan2NoiseTillingAndOffset("Scan2NoiseTillingAndOffset", Vector) = (1,1,0,0)
		_Scan2NoiseScaleAndOffset("Scan2NoiseScaleAndOffset", Vector) = (3,0,0,0)
		_Scan2NoiseSpeed("Scan2NoiseSpeed", Vector) = (0,0,0,0)
		_Scan2BreathSpeed("Scan2BreathSpeed", Range( 0 , 10)) = 0
		_Scan2BreathShapeValue("Scan2BreathShapeValue", Range( -1 , 1)) = 0
		_Scan2BreathAlphaValue("Scan2BreathAlphaValue", Range( -1 , 1)) = 0
		[Header(_____Fresnel_____)][Toggle(_FRESNELSWITCH_ON)] _FresnelSwitch("FresnelSwitch", Float) = 0
		_FresnelBias("FresnelBias", Range( 0 , 1)) = 0
		_FresnelPower("FresnelPower", Range( 0 , 10)) = 2
		_FresnelScale("FresnelScale", Range( 0 , 20)) = 1
		[HDR]_FresnelColor("FresnelColor", Color) = (1,1,1,1)
		[Toggle(_FRESNELCENTERTRANSPARENT_ON)] _FresnelCenterTransparent("FresnelCenterTransparent", Float) = 0
		[Header(_____VertexOffset_____)][Toggle]_VertexOffsetSwitch("VertexOffsetSwitch", Float) = 0
		_Texture_VertexNoise("Texture_VertexNoise", 2D) = "white" {}
		_VertexSpeed("VertexSpeed", Vector) = (0,0,0,0)
		_VertexNoiseOffset("VertexNoiseOffset", Range( -1 , 1)) = 0
		_VertexNoiseScale("VertexNoiseScale", Range( 0 , 2)) = 1
		_VertexTillingAndOffset("VertexTillingAndOffset", Vector) = (1,1,0,0)
		_VertexOffsetIntensity("VertexOffsetIntensity", Range( 0 , 1)) = 1
		_GlitchRatio("GlitchRatio", Range( 0 , 1)) = 0
		_GlitchTimeScale("GlitchTimeScale", Range( 0 , 10)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _FRESNELCENTERTRANSPARENT_ON
		#pragma shader_feature_local _FRESNELSWITCH_ON
		#pragma shader_feature_local _SCAN1SWITCH_ON
		#pragma shader_feature_local _SCAN2SWITCH_ON
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 worldNormal;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _VertexOffsetSwitch;
		uniform sampler2D _Texture_VertexNoise;
		uniform float2 _VertexSpeed;
		uniform float4 _VertexTillingAndOffset;
		uniform float _VertexNoiseScale;
		uniform float _VertexNoiseOffset;
		uniform float _GlitchTimeScale;
		uniform float _GlitchRatio;
		uniform float _VertexOffsetIntensity;
		uniform sampler2D _Texture_Emission;
		uniform float4 _Texture_Emission_ST;
		uniform float4 _EmissionColor;
		uniform float _FinalTransparency;
		uniform float _FresnelBias;
		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform float _ColorScanMultiplyOrAdd;
		uniform sampler2D _Texture_Main;
		uniform float4 _Texture_Main_ST;
		uniform float4 _MainColor;
		uniform float _MainTextureColorIntensity;
		uniform float _Scan1ColorIntensity;
		uniform float _Scan1BreathAlphaValue;
		uniform float _Scan1BreathSpeed;
		uniform float4 _Scan1ColorValue0;
		uniform float4 _Scan1ColorValue1;
		uniform float _Scan1CancelGradient;
		uniform sampler2D _Texture_Scan1;
		uniform float _Scan1NoiseSwitch;
		uniform sampler2D _Scan1Noise;
		uniform float2 _Scan1NoiseSpeed;
		uniform float4 _Scan1NoiseTillingAndOffset;
		uniform float2 _Scan1NoiseScaleAndOffset;
		uniform float2 _Scan1Speed;
		uniform float _Scan1WithUV;
		uniform float4 _Scan1TillingAndOffset;
		uniform float4 _Texture_Scan1_ST;
		uniform float _Scan1Scale;
		uniform float _Scan1BreathShapeValue;
		uniform float _Scan1Offset;
		uniform float4 _Scan2ColorValue0;
		uniform float4 _Scan2ColorValue1;
		uniform float _Scan2CancelGradient;
		uniform sampler2D _Texture_Scan2;
		uniform float2 _Scan2Speed;
		uniform float _Scan2WithUV;
		uniform float4 _Scan2TillingAndOffset;
		uniform float4 _Texture_Scan2_ST;
		uniform float _Scan2NoiseSwitch;
		uniform sampler2D _Scan2Noise;
		uniform float2 _Scan2NoiseSpeed;
		uniform float4 _Scan2NoiseTillingAndOffset;
		uniform float2 _Scan2NoiseScaleAndOffset;
		uniform float _Scan2Scale;
		uniform float _Scan2BreathSpeed;
		uniform float _Scan2BreathShapeValue;
		uniform float _Scan2Offset;
		uniform float _Scan2ColorIntensity;
		uniform float _Scan2BreathAlphaValue;
		uniform float4 _FresnelColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult106 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 appendResult120 = (float2(_VertexTillingAndOffset.x , _VertexTillingAndOffset.y));
			float2 appendResult119 = (float2(_VertexTillingAndOffset.z , _VertexTillingAndOffset.w));
			float2 panner39 = ( 1.0 * _Time.y * _VertexSpeed + (appendResult106*appendResult120 + appendResult119));
			float mulTime136 = _Time.y * _GlitchTimeScale;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 appendResult127 = (float3(ase_vertexNormal.x , 0.0 , ase_vertexNormal.z));
			v.vertex.xyz += (( _VertexOffsetSwitch )?( ( saturate( (tex2Dlod( _Texture_VertexNoise, float4( panner39, 0, 0.0) ).r*_VertexNoiseScale + _VertexNoiseOffset) ) * ( (sin( mulTime136 )*0.5 + 0.5) < _GlitchRatio ? _VertexOffsetIntensity : 0.0 ) * appendResult127 ) ):( float3( 0,0,0 ) ));
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float temp_output_102_0 = ( _FinalTransparency * 1.0 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV6 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode6 = ( _FresnelBias + _FresnelScale * pow( 1.0 - fresnelNdotV6, _FresnelPower ) );
			#ifdef _FRESNELSWITCH_ON
				float staticSwitch36 = saturate( fresnelNode6 );
			#else
				float staticSwitch36 = 0.0;
			#endif
			#ifdef _FRESNELSWITCH_ON
				float staticSwitch116 = ( staticSwitch36 * temp_output_102_0 );
			#else
				float staticSwitch116 = temp_output_102_0;
			#endif
			#ifdef _FRESNELCENTERTRANSPARENT_ON
				float staticSwitch79 = staticSwitch116;
			#else
				float staticSwitch79 = temp_output_102_0;
			#endif
			float2 uv_Texture_Main = i.uv_texcoord * _Texture_Main_ST.xy + _Texture_Main_ST.zw;
			float4 temp_output_3_0 = ( tex2D( _Texture_Main, uv_Texture_Main ) * _MainColor * _MainTextureColorIntensity );
			float mulTime169 = _Time.y * _Scan1BreathSpeed;
			float temp_output_176_0 = abs( sin( mulTime169 ) );
			float2 appendResult150 = (float2(_Scan1NoiseTillingAndOffset.x , _Scan1NoiseTillingAndOffset.y));
			float2 appendResult151 = (float2(_Scan1NoiseTillingAndOffset.z , _Scan1NoiseTillingAndOffset.w));
			float2 uv_TexCoord148 = i.uv_texcoord * appendResult150 + appendResult151;
			float2 panner145 = ( 1.0 * _Time.y * _Scan1NoiseSpeed + uv_TexCoord148);
			float2 appendResult106 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 appendResult20 = (float2(_Scan1TillingAndOffset.x , _Scan1TillingAndOffset.y));
			float2 appendResult21 = (float2(_Scan1TillingAndOffset.z , _Scan1TillingAndOffset.w));
			float2 uv_Texture_Scan1 = i.uv_texcoord * _Texture_Scan1_ST.xy + _Texture_Scan1_ST.zw;
			float2 panner14 = ( 1.0 * _Time.y * _Scan1Speed + (( _Scan1WithUV )?( uv_Texture_Scan1 ):( (appendResult106*appendResult20 + appendResult21) )));
			float temp_output_72_0 = saturate( (tex2D( _Texture_Scan1, ( (( _Scan1NoiseSwitch )?( (tex2D( _Scan1Noise, panner145 ).r*_Scan1NoiseScaleAndOffset.x + _Scan1NoiseScaleAndOffset.y) ):( 0.0 )) + panner14 ) ).r*_Scan1Scale + ( ( temp_output_176_0 * _Scan1BreathShapeValue ) + _Scan1Offset )) );
			float4 lerpResult32 = lerp( _Scan1ColorValue0 , _Scan1ColorValue1 , (( _Scan1CancelGradient )?( ( temp_output_72_0 > 0.0 ? 1.0 : 0.0 ) ):( temp_output_72_0 )));
			#ifdef _SCAN1SWITCH_ON
				float4 staticSwitch69 = ( ( _Scan1ColorIntensity + ( ( _Scan1BreathAlphaValue * temp_output_176_0 ) * _Scan1ColorIntensity ) ) * lerpResult32 );
			#else
				float4 staticSwitch69 = float4( 0,0,0,0 );
			#endif
			float2 appendResult113 = (float2(_Scan2TillingAndOffset.x , _Scan2TillingAndOffset.y));
			float2 appendResult115 = (float2(_Scan2TillingAndOffset.z , _Scan2TillingAndOffset.w));
			float2 uv_Texture_Scan2 = i.uv_texcoord * _Texture_Scan2_ST.xy + _Texture_Scan2_ST.zw;
			float2 panner47 = ( 1.0 * _Time.y * _Scan2Speed + (( _Scan2WithUV )?( uv_Texture_Scan2 ):( (appendResult106*appendResult113 + appendResult115) )));
			float2 appendResult154 = (float2(_Scan2NoiseTillingAndOffset.x , _Scan2NoiseTillingAndOffset.y));
			float2 appendResult155 = (float2(_Scan2NoiseTillingAndOffset.z , _Scan2NoiseTillingAndOffset.w));
			float2 uv_TexCoord156 = i.uv_texcoord * appendResult154 + appendResult155;
			float2 panner157 = ( 1.0 * _Time.y * _Scan2NoiseSpeed + uv_TexCoord156);
			float mulTime181 = _Time.y * _Scan2BreathSpeed;
			float temp_output_183_0 = abs( sin( mulTime181 ) );
			float temp_output_71_0 = saturate( (tex2D( _Texture_Scan2, ( panner47 + (( _Scan2NoiseSwitch )?( (tex2D( _Scan2Noise, panner157 ).r*_Scan2NoiseScaleAndOffset.x + _Scan2NoiseScaleAndOffset.y) ):( 0.0 )) ) ).r*_Scan2Scale + ( ( temp_output_183_0 * _Scan2BreathShapeValue ) + _Scan2Offset )) );
			float4 lerpResult54 = lerp( _Scan2ColorValue0 , _Scan2ColorValue1 , (( _Scan2CancelGradient )?( ( temp_output_71_0 > 0.0 ? 1.0 : 0.0 ) ):( temp_output_71_0 )));
			#ifdef _SCAN2SWITCH_ON
				float4 staticSwitch70 = ( lerpResult54 * ( _Scan2ColorIntensity + ( _Scan2ColorIntensity * ( _Scan2BreathAlphaValue * temp_output_183_0 ) ) ) );
			#else
				float4 staticSwitch70 = float4( 0,0,0,0 );
			#endif
			float4 temp_output_62_0 = ( staticSwitch69 + staticSwitch70 );
			float4 temp_output_66_0 = ( (( _ColorScanMultiplyOrAdd )?( ( temp_output_3_0 * temp_output_62_0 ) ):( ( temp_output_3_0 + temp_output_62_0 ) )) + float4( 0,0,0,0 ) );
			float4 lerpResult67 = lerp( temp_output_66_0 , _FresnelColor , staticSwitch36);
			#ifdef _FRESNELSWITCH_ON
				float4 staticSwitch117 = ( ( staticSwitch36 * _FresnelColor ) + temp_output_66_0 );
			#else
				float4 staticSwitch117 = lerpResult67;
			#endif
			#ifdef _FRESNELCENTERTRANSPARENT_ON
				float4 staticSwitch84 = staticSwitch117;
			#else
				float4 staticSwitch84 = lerpResult67;
			#endif
			c.rgb = staticSwitch84.rgb;
			c.a = staticSwitch79;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			float2 uv_Texture_Emission = i.uv_texcoord * _Texture_Emission_ST.xy + _Texture_Emission_ST.zw;
			o.Emission = ( tex2D( _Texture_Emission, uv_Texture_Emission ) * _EmissionColor ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18934
7;72;1906;947;2063.426;998.8283;1.529102;True;False
Node;AmplifyShaderEditor.Vector4Node;149;-3728.657,-1585.564;Inherit;False;Property;_Scan1NoiseTillingAndOffset;Scan1NoiseTillingAndOffset;21;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;153;-4380.371,1106.059;Inherit;False;Property;_Scan2NoiseTillingAndOffset;Scan2NoiseTillingAndOffset;40;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;150;-3437.748,-1523.288;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;151;-3430.748,-1437.288;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;154;-4089.463,1168.335;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;155;-4082.463,1254.336;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;114;-4299.7,-79.82463;Inherit;False;Property;_Scan2TillingAndOffset;Scan2TillingAndOffset;36;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;148;-3235.344,-1496.006;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;105;-3806.301,-607.7351;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;156;-3887.059,1195.617;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;19;-3852.17,-1057.524;Inherit;False;Property;_Scan1TillingAndOffset;Scan1TillingAndOffset;17;0;Create;True;0;0;0;False;0;False;1,1,0,0;12,25.1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;147;-3209.789,-1333.632;Inherit;False;Property;_Scan1NoiseSpeed;Scan1NoiseSpeed;23;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;158;-3861.504,1357.991;Inherit;False;Property;_Scan2NoiseSpeed;Scan2NoiseSpeed;42;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;145;-2958.351,-1382.73;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-3437.949,-1148.375;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;113;-3956.099,5.875277;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-2046.335,-988.0634;Inherit;False;Property;_Scan1BreathSpeed;Scan1BreathSpeed;24;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;157;-3610.066,1308.893;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;115;-3970.798,164.8753;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;106;-3562.169,-576.4462;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-3452.648,-989.375;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-2000.836,987.1921;Inherit;False;Property;_Scan2BreathSpeed;Scan2BreathSpeed;43;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;152;-3278.815,1134.073;Inherit;True;Property;_Scan2Noise;Scan2Noise;39;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;45;-3393.774,548.1686;Inherit;False;0;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;181;-1876.836,1104.192;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;112;-3534.572,-149.3484;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;169;-1922.335,-871.0634;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;143;-2747.783,-1123.203;Inherit;False;Property;_Scan1NoiseScaleAndOffset;Scan1NoiseScaleAndOffset;22;0;Create;True;0;0;0;False;0;False;3,0;3,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;160;-3313.57,1342.777;Inherit;False;Property;_Scan2NoiseScaleAndOffset;Scan2NoiseScaleAndOffset;41;0;Create;True;0;0;0;False;0;False;3,0;3,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;139;-2627.1,-1557.55;Inherit;True;Property;_Scan1Noise;Scan1Noise;20;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-2957.246,-431.8585;Inherit;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;109;-3145.344,-777.6049;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;182;-1715.836,1096.192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;171;-1761.335,-879.0634;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;161;-2889.57,1300.777;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;107;-2544.369,-594.6535;Inherit;False;Property;_Scan1WithUV;Scan1WithUV;18;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;108;-3013.247,472.3204;Inherit;False;Property;_Scan2WithUV;Scan2WithUV;37;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;142;-2345.846,-1183.895;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;23;-2650.903,-373.2759;Inherit;False;Property;_Scan1Speed;Scan1Speed;12;0;Create;True;0;0;0;False;0;False;0,0;0,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;46;-2439.763,528.6664;Inherit;False;Property;_Scan2Speed;Scan2Speed;31;0;Create;True;0;0;0;False;0;False;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;14;-2231.691,-522.7526;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;163;-2573.38,1266.601;Inherit;False;Property;_Scan2NoiseSwitch;Scan2NoiseSwitch;38;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;162;-2226.654,-911.5179;Inherit;False;Property;_Scan1NoiseSwitch;Scan1NoiseSwitch;19;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;183;-1594.455,1060.74;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;47;-2246.363,400.0597;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;188;-1885.836,1188.192;Inherit;False;Property;_Scan2BreathShapeValue;Scan2BreathShapeValue;44;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-1931.335,-787.0634;Inherit;False;Property;_Scan1BreathShapeValue;Scan1BreathShapeValue;25;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;176;-1639.954,-914.5153;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;-1554.836,1186.192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-1600.335,-789.0634;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-2112.612,-745.7043;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-1972.404,609.6832;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1916.512,-636.2405;Inherit;False;Property;_Scan1Offset;Scan1Offset;14;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1707.611,898.9518;Inherit;False;Property;_Scan2Offset;Scan2Offset;33;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1967.629,-318.8562;Inherit;False;Property;_Scan1Scale;Scan1Scale;13;0;Create;True;0;0;0;False;0;False;1;0.031;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-1932.522,-533.3518;Inherit;True;Property;_Texture_Scan1;Texture_Scan1;9;0;Create;True;0;0;0;False;0;False;-1;None;bab07bea0290bee4483411ee80c7a87f;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1687.311,304.9442;Inherit;True;Property;_Texture_Scan2;Texture_Scan2;28;0;Create;True;0;0;0;False;0;False;-1;None;e3933cb2e2577fb4ab81423186807589;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;187;-1348.736,825.7919;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1538.026,119.8196;Inherit;False;Property;_Scan2Scale;Scan2Scale;32;0;Create;True;0;0;0;False;0;False;1;0.992;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;175;-1598.335,-671.0634;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;27;-1484.257,-587.7074;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;53;-1251.961,269.0095;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;185;-1457.444,1009.357;Inherit;False;Property;_Scan2BreathAlphaValue;Scan2BreathAlphaValue;45;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-1502.943,-965.8988;Inherit;False;Property;_Scan1BreathAlphaValue;Scan1BreathAlphaValue;26;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;71;-1060.573,267.6548;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;72;-1309.82,-637.3842;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1188.089,719.0189;Inherit;False;Property;_Scan2ColorIntensity;Scan2ColorIntensity;35;0;Create;True;0;0;0;False;0;False;1;4.8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;186;-1066.413,1018.968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1441.201,-41.03621;Inherit;False;Property;_Scan1ColorIntensity;Scan1ColorIntensity;16;0;Create;True;0;0;0;False;0;False;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;166;-1192.328,77.05836;Inherit;False;2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;165;-1294.311,-487.849;Inherit;False;2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-1316.912,-819.2881;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-1447.496,458.1566;Inherit;False;Property;_Scan2ColorValue0;Scan2ColorValue0;29;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;26;-1679.589,-155.805;Inherit;False;Property;_Scan1ColorValue1;Scan1ColorValue1;11;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;31;-1582.892,-400.8909;Inherit;False;Property;_Scan1ColorValue0;Scan1ColorValue0;10;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.3207547,0.3207547,0.3207547,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;164;-1161.943,-637.9269;Inherit;False;Property;_Scan1CancelGradient;Scan1CancelGradient;15;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-890.171,914.9875;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;51;-1699.839,658.929;Inherit;False;Property;_Scan2ColorValue1;Scan2ColorValue1;30;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-1238.487,-162.7037;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;167;-1003.741,25.08755;Inherit;False;Property;_Scan2CancelGradient;Scan2CancelGradient;34;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;32;-1100.051,-321.9594;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;54;-1036.071,497.3552;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;177;-1057.788,-200.998;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;193;-763.5965,798.6262;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-920.4034,-460.8259;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-794.9116,285.0156;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;118;-2950.993,1641.304;Inherit;False;Property;_VertexTillingAndOffset;VertexTillingAndOffset;57;0;Create;True;0;0;0;False;0;False;1,1,0,0;0.1,-0.03,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1962.937,-1363.028;Inherit;False;Property;_FresnelScale;FresnelScale;49;0;Create;True;0;0;0;False;0;False;1;1.77;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;69;-746.9906,-425.4323;Inherit;False;Property;_Scan1Switch;Scan1Switch;8;0;Create;True;0;0;0;False;1;Header(_____Scan1_____);False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;119;-2494.456,1789.499;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;120;-2479.757,1630.499;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1950.937,-1260.027;Inherit;False;Property;_FresnelPower;FresnelPower;48;0;Create;True;0;0;0;False;0;False;2;2.99;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;70;-674.2659,53.72595;Inherit;False;Property;_Scan2Switch;Scan2Switch;27;0;Create;True;0;0;0;False;1;Header(_____Scan2_____);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1967.522,-1456.399;Inherit;False;Property;_FresnelBias;FresnelBias;47;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1033.95,-1846.359;Inherit;False;Property;_MainColor;MainColor;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.7490196,0.5921569,0.627451,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1068.286,-2043.097;Inherit;True;Property;_Texture_Main;Texture_Main;1;0;Create;True;0;0;0;False;1;Header(_____Main_____);False;-1;None;da355b0402676cb48af6e4a6d6bd41f8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1008.282,-1652.359;Inherit;False;Property;_MainTextureColorIntensity;MainTextureColorIntensity;4;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-568.145,-247.9147;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;121;-2058.23,1475.275;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;6;-1567.332,-1216.472;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-619.8885,-1826.48;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-955.2051,1152.322;Inherit;False;Property;_GlitchTimeScale;GlitchTimeScale;61;0;Create;True;0;0;0;False;0;False;1;5.72;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;37;-1447.509,2045.818;Inherit;False;Property;_VertexSpeed;VertexSpeed;54;0;Create;True;0;0;0;False;0;False;0,0;0,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-404.0046,-463.8517;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;-294.833,-319.4116;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;68;-1090.532,-1059.948;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;39;-1022.197,1830.841;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;136;-622.2051,1169.322;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;36;-774.4976,-994.475;Inherit;False;Property;_FresnelSwitch;FresnelSwitch;46;0;Create;True;0;0;0;False;1;Header(_____Fresnel_____);False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;336.9059,-382.7484;Inherit;False;Property;_FinalTransparency;FinalTransparency;2;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;199;-234.2548,-453.9479;Inherit;False;Property;_ColorScanMultiplyOrAdd;ColorScanMultiplyOrAdd;7;0;Create;True;0;0;0;False;1;Header(_____ScanType_____);False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;42;-621.4052,1839.778;Inherit;True;Property;_Texture_VertexNoise;Texture_VertexNoise;53;0;Create;True;0;0;0;False;0;False;-1;None;52a7ec02aaabc7346986ba316c45e8cf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-430.9625,1695.605;Inherit;False;Property;_VertexNoiseOffset;VertexNoiseOffset;55;0;Create;True;0;0;0;False;0;False;0;-0.456;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-684.2484,-800.4091;Inherit;False;Property;_FresnelColor;FresnelColor;50;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.3592438,2.144237,1.529497,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;137;-431.2051,1082.322;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-406.9431,1600.558;Inherit;False;Property;_VertexNoiseScale;VertexNoiseScale;56;0;Create;True;0;0;0;False;0;False;1;0.965;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-90.26,-102.1897;Inherit;False;Constant;_Float0;Float 0;36;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-33.59216,-718.9207;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-514.6067,1329.987;Inherit;False;Property;_GlitchRatio;GlitchRatio;60;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;133;-292.6067,1143.987;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;126;-165.3077,2089.033;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;123;-432.1455,1486.665;Inherit;False;Property;_VertexOffsetIntensity;VertexOffsetIntensity;59;0;Create;True;0;0;0;False;0;False;1;0.092;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;8.756289,-425.5808;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;43;-196.4465,1849.584;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;572.0775,-223.5327;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;577.7147,3.435459;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;287.5814,-1031.159;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;131;-76.60669,1288.987;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;305.2396,-600.9341;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;128;100.3035,1906.647;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;127;84.69226,2119.033;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;333.2504,1711.879;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;197;1653.165,-437.1418;Inherit;True;Property;_Texture_Emission;Texture_Emission;5;0;Create;True;0;0;0;False;1;Header(_____Emission_____);False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;116;769.7459,-63.07533;Inherit;False;Property;_FresnelSwitch1;FresnelSwitch;46;0;Create;True;0;0;0;False;1;Header(_____Fresnel_____);False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;36;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;196;1740.837,-219.8144;Inherit;False;Property;_EmissionColor;EmissionColor;6;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;117;534.8338,-778.7161;Inherit;False;Property;_FresnelSwitch2;FresnelSwitch;46;0;Create;True;0;0;0;False;1;Header(_____Fresnel_____);False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;36;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;93;-2752.678,92.46916;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;88;-3048.492,-155.1122;Inherit;False;Property;_Scan1Speed1;Scan1Speed1;58;0;Create;True;0;0;0;False;0;False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;96;-2192.718,0.5987082;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-2699.578,318.1606;Inherit;False;Constant;_Float1;Float 1;33;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;44;113.5819,1155.511;Inherit;False;Property;_VertexOffsetSwitch;VertexOffsetSwitch;52;0;Create;True;0;0;0;False;1;Header(_____VertexOffset_____);False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-1587.253,1794.635;Inherit;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;97;-2023.205,-1.91019;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;84;880.943,-740.2065;Inherit;False;Property;_FresnelTypeMultiplyOrLerp;FresnelTypeMultiplyOrLerp;51;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;79;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;1995.209,-279.0855;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;79;1016.255,-134.1694;Inherit;True;Property;_FresnelCenterTransparent;FresnelCenterTransparent;51;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;91;-2762.592,-182.8036;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;89;-2379.724,-96.80059;Inherit;False;2;4;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;-1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;94;-2367.578,96.16057;Inherit;False;2;4;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;-1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1405.327,-320.2664;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Xuqi/HologramUnlit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;150;0;149;1
WireConnection;150;1;149;2
WireConnection;151;0;149;3
WireConnection;151;1;149;4
WireConnection;154;0;153;1
WireConnection;154;1;153;2
WireConnection;155;0;153;3
WireConnection;155;1;153;4
WireConnection;148;0;150;0
WireConnection;148;1;151;0
WireConnection;156;0;154;0
WireConnection;156;1;155;0
WireConnection;145;0;148;0
WireConnection;145;2;147;0
WireConnection;20;0;19;1
WireConnection;20;1;19;2
WireConnection;113;0;114;1
WireConnection;113;1;114;2
WireConnection;157;0;156;0
WireConnection;157;2;158;0
WireConnection;115;0;114;3
WireConnection;115;1;114;4
WireConnection;106;0;105;1
WireConnection;106;1;105;2
WireConnection;21;0;19;3
WireConnection;21;1;19;4
WireConnection;152;1;157;0
WireConnection;181;0;180;0
WireConnection;112;0;106;0
WireConnection;112;1;113;0
WireConnection;112;2;115;0
WireConnection;169;0;172;0
WireConnection;139;1;145;0
WireConnection;109;0;106;0
WireConnection;109;1;20;0
WireConnection;109;2;21;0
WireConnection;182;0;181;0
WireConnection;171;0;169;0
WireConnection;161;0;152;1
WireConnection;161;1;160;1
WireConnection;161;2;160;2
WireConnection;107;0;109;0
WireConnection;107;1;15;0
WireConnection;108;0;112;0
WireConnection;108;1;45;0
WireConnection;142;0;139;1
WireConnection;142;1;143;1
WireConnection;142;2;143;2
WireConnection;14;0;107;0
WireConnection;14;2;23;0
WireConnection;163;1;161;0
WireConnection;162;1;142;0
WireConnection;183;0;182;0
WireConnection;47;0;108;0
WireConnection;47;2;46;0
WireConnection;176;0;171;0
WireConnection;184;0;183;0
WireConnection;184;1;188;0
WireConnection;174;0;176;0
WireConnection;174;1;173;0
WireConnection;140;0;162;0
WireConnection;140;1;14;0
WireConnection;159;0;47;0
WireConnection;159;1;163;0
WireConnection;13;1;140;0
WireConnection;50;1;159;0
WireConnection;187;0;184;0
WireConnection;187;1;48;0
WireConnection;175;0;174;0
WireConnection;175;1;29;0
WireConnection;27;0;13;1
WireConnection;27;1;28;0
WireConnection;27;2;175;0
WireConnection;53;0;50;1
WireConnection;53;1;49;0
WireConnection;53;2;187;0
WireConnection;71;0;53;0
WireConnection;72;0;27;0
WireConnection;186;0;185;0
WireConnection;186;1;183;0
WireConnection;166;0;71;0
WireConnection;165;0;72;0
WireConnection;179;0;178;0
WireConnection;179;1;176;0
WireConnection;164;0;72;0
WireConnection;164;1;165;0
WireConnection;194;0;55;0
WireConnection;194;1;186;0
WireConnection;195;0;179;0
WireConnection;195;1;33;0
WireConnection;167;0;71;0
WireConnection;167;1;166;0
WireConnection;32;0;31;0
WireConnection;32;1;26;0
WireConnection;32;2;164;0
WireConnection;54;0;52;0
WireConnection;54;1;51;0
WireConnection;54;2;167;0
WireConnection;177;0;33;0
WireConnection;177;1;195;0
WireConnection;193;0;55;0
WireConnection;193;1;194;0
WireConnection;25;0;177;0
WireConnection;25;1;32;0
WireConnection;56;0;54;0
WireConnection;56;1;193;0
WireConnection;69;0;25;0
WireConnection;119;0;118;3
WireConnection;119;1;118;4
WireConnection;120;0;118;1
WireConnection;120;1;118;2
WireConnection;70;0;56;0
WireConnection;62;0;69;0
WireConnection;62;1;70;0
WireConnection;121;0;106;0
WireConnection;121;1;120;0
WireConnection;121;2;119;0
WireConnection;6;1;7;0
WireConnection;6;2;8;0
WireConnection;6;3;9;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;3;2;5;0
WireConnection;34;0;3;0
WireConnection;34;1;62;0
WireConnection;200;0;3;0
WireConnection;200;1;62;0
WireConnection;68;0;6;0
WireConnection;39;0;121;0
WireConnection;39;2;37;0
WireConnection;136;0;138;0
WireConnection;36;0;68;0
WireConnection;199;0;34;0
WireConnection;199;1;200;0
WireConnection;42;1;39;0
WireConnection;137;0;136;0
WireConnection;86;0;36;0
WireConnection;86;1;12;0
WireConnection;133;0;137;0
WireConnection;66;0;199;0
WireConnection;43;0;42;1
WireConnection;43;1;40;0
WireConnection;43;2;41;0
WireConnection;102;0;2;0
WireConnection;102;1;104;0
WireConnection;83;0;36;0
WireConnection;83;1;102;0
WireConnection;67;0;66;0
WireConnection;67;1;12;0
WireConnection;67;2;36;0
WireConnection;131;0;133;0
WireConnection;131;1;134;0
WireConnection;131;2;123;0
WireConnection;85;0;86;0
WireConnection;85;1;66;0
WireConnection;128;0;43;0
WireConnection;127;0;126;1
WireConnection;127;2;126;3
WireConnection;122;0;128;0
WireConnection;122;1;131;0
WireConnection;122;2;127;0
WireConnection;116;1;102;0
WireConnection;116;0;83;0
WireConnection;117;1;67;0
WireConnection;117;0;85;0
WireConnection;93;0;88;2
WireConnection;96;0;89;0
WireConnection;96;1;94;0
WireConnection;44;1;122;0
WireConnection;97;1;96;0
WireConnection;84;1;67;0
WireConnection;84;0;117;0
WireConnection;198;0;197;0
WireConnection;198;1;196;0
WireConnection;79;1;102;0
WireConnection;79;0;116;0
WireConnection;91;0;88;1
WireConnection;89;0;91;0
WireConnection;89;1;95;0
WireConnection;89;3;91;0
WireConnection;94;0;93;0
WireConnection;94;1;95;0
WireConnection;94;3;91;0
WireConnection;0;2;198;0
WireConnection;0;9;79;0
WireConnection;0;13;84;0
WireConnection;0;11;44;0
ASEEND*/
//CHKSM=4EECDDCDAED55465E26992C77FA70237CAA3384A