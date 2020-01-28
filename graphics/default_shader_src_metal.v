module graphics

const (
	default_vert_metal = '#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct main0_out
{
    float2 VaryingTexCoord [[user(locn0)]];
    float4 VaryingColor [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float2 VertPosition [[attribute(0)]];
    float2 VertTexCoord [[attribute(1)]];
    float4 VertColor [[attribute(2)]];
};

static inline __attribute__((always_inline))
float4 position(thread const float3x2& transMat, thread const float2& localPosition)
{
    return float4(transMat * float3(localPosition, 1.0), 0.0, 1.0);
}

vertex main0_out _main(main0_in in [[stage_in]], constant spvUnsafeArray<float3, 2>& TransformMatrix [[buffer(0)]])
{
    main0_out out = {};
    out.VaryingTexCoord = in.VertTexCoord;
    out.VaryingColor = in.VertColor;
    float3x2 param = float3x2(float2(TransformMatrix[0].x, TransformMatrix[0].y), float2(TransformMatrix[0].z, TransformMatrix[1].x), float2(TransformMatrix[1].y, TransformMatrix[1].z));
    float2 param_1 = in.VertPosition;
    out.gl_Position = position(param, param_1);
    return out;
}'
	default_vert_main_metal = ''

	default_frag_metal = '#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 frag_color [[color(0)]];
};

struct main0_in
{
    float2 VaryingTexCoord [[user(locn0)]];
    float4 VaryingColor [[user(locn1)]];
};

static inline __attribute__((always_inline))
float4 effect(thread const float4& vcolor, thread const texture2d<float> tex, thread const sampler texSmplr, thread const float2& texcoord)
{
    return tex.sample(texSmplr, texcoord) * vcolor;
}

fragment main0_out _main(main0_in in [[stage_in]], texture2d<float> MainTex [[texture(0)]], sampler MainTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 param = in.VaryingColor;
    float2 param_1 = in.VaryingTexCoord;
    out.frag_color = effect(param, MainTex, MainTexSmplr, param_1);
    return out;
}'
	default_frag_main_metal = ''

	default_text_frag_main_metal = ''
)