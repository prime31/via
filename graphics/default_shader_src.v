module graphics

const (
	default_vert = '#version 330
uniform vec3 TransformMatrix[2];

layout (location=0) in vec2 VertPosition;
layout (location=1) in vec2 VertTexCoord;
layout (location=2) in vec4 VertColor;

out vec2 VaryingTexCoord;
out vec4 VaryingColor;

vec4 position(mat3x2 transMat, vec2 localPosition);

void main() {
	VaryingTexCoord = VertTexCoord;
	VaryingColor = VertColor;
	mat3x2 mat = mat3x2(TransformMatrix[0].x, TransformMatrix[0].y, TransformMatrix[0].z, TransformMatrix[1].x, TransformMatrix[1].y, TransformMatrix[1].z);
	gl_Position = position(mat, VertPosition);
}'
	default_vert_main = '
vec4 position(mat3x2 transMat, vec2 localPosition) {
	return vec4(transMat * vec3(localPosition, 0), 0, 1);
}'

	default_frag = '#version 330
uniform sampler2D MainTex;
uniform vec4 via_ScreenSize;

in vec2 VaryingTexCoord;
in vec4 VaryingColor;

// See Shader::updateScreenParams in Shader.cpp
#define via_PixelCoord (vec2(gl_FragCoord.x, (gl_FragCoord.y * via_ScreenSize.z) + via_ScreenSize.w))
vec4 effect(vec4 vcolor, sampler2D tex, vec2 texcoord);

layout (location=0) out vec4 frag_color;
void main() {
	frag_color = effect(VaryingColor, MainTex, VaryingTexCoord.st);
}'
	default_frag_main = '
vec4 effect(vec4 vcolor, sampler2D tex, vec2 texcoord) {
	return texture(tex, texcoord) * vcolor;
}'

	default_text_frag_main = '
vec4 effect(vec4 vcolor, sampler2D tex, vec2 texcoord) {
	return vec4(1, 1, 1, texture(tex, texcoord).r) * vcolor;
}'
)