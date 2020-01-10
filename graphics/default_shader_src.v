module graphics

const (
	default_vert = '#version 330
uniform mat4 TransformProjectionMatrix;

layout (location=0) in vec2 VertPosition;
layout (location=1) in vec2 VertTexCoord;
layout (location=2) in vec4 VertColor;

out vec2 VaryingTexCoord;
out vec4 VaryingColor;

vec4 position(mat4 TransformProjectionMatrix, vec4 localPosition);

void main() {
	VaryingTexCoord = VertTexCoord;
	VaryingColor = VertColor;
	gl_Position = position(TransformProjectionMatrix, vec4(VertPosition, 0, 1));
}'
	default_vert_main = '
vec4 position(mat4 transformProjectionMatrix, vec4 localPosition) {
	return transformProjectionMatrix * localPosition;
}'

	default_frag = '#version 330
uniform sampler2D MainTex;

uniform mat4 TransformProjectionMatrix;
uniform vec4 via_ScreenSize;

in vec2 VaryingTexCoord;
in vec4 VaryingColor;

// See Shader::updateScreenParams in Shader.cpp.
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
)