Shader "Custom/Terrain" {
    Properties {
        _GrassColour ("Grass Colour", Color) = (0,1,0,1)
        _RockColour ("Rock Colour", Color) = (1,1,1,1)
        _GrassSlopeThreshold ("Grass Slope Threshold", Range(0,1)) = .5
        _GrassBlendAmount ("Grass Blend Amount", Range(0,1)) = .5

        _RimColour ("Rim Colour", Color) = (0,1,0,1)
        _RimPower ("Rim Power", Float) = .5
        _RimFac ("Rim Fac", Range(0,1)) = 1
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        struct Input {
            float3 worldPos;
            float3 worldNormal;
            float3 viewDir;
        };

        half _MaxHeight;
        half _GrassSlopeThreshold;
        half _GrassBlendAmount;
        fixed4 _GrassColour;
        fixed4 _RockColour;

        half _RimFac;
        half _RimPower;
        fixed4 _RimColour;


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o) {
            float slope = 1-IN.worldNormal.y; // slope = 0 when terrain is completely flat
            float grassBlendHeight = _GrassSlopeThreshold * (1-_GrassBlendAmount);
            float grassWeight = 1-saturate((slope-grassBlendHeight)/(_GrassSlopeThreshold-grassBlendHeight));

            half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
            float rimWeight =  pow (rim, _RimPower) * _RimFac;

            float3 colA = _GrassColour * grassWeight + _RockColour * (1-grassWeight);
            float3 colB = rimWeight*_RimColour + colA * (1-rimWeight);
            o.Albedo = colB;
            o.Alpha = 1;
            o.Metallic = 0;
            o.Smoothness = 0;
        }
        ENDCG
    }
}
