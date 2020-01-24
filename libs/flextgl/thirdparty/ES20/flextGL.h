#ifndef __gl_h_
#define __gl_h_
/*
    This file was generated using https://github.com/mosra/flextgl:

        path/to/flextGLgen.py profile.txt

    Do not edit directly, modify the template or profile and regenerate.
*/

#include <KHR/khrplatform.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Function declaration macros - to move into glplatform.h */

#if defined(_WIN32) && !defined(APIENTRY) && !defined(__CYGWIN__) && !defined(__SCITECH_SNAP__)
#define WIN32_LEAN_AND_MEAN 1
#ifndef WINAPI
#define WINAPI __stdcall
#endif
#define APIENTRY WINAPI
#endif

#ifndef APIENTRY
#define APIENTRY
#endif
#ifndef APIENTRYP
#define APIENTRYP APIENTRY *
#endif
#ifndef GLAPI
#define GLAPI extern
#endif

/* -------------------------------- DATA TYPES ------------------------------- */

typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef void GLvoid;
typedef khronos_uint8_t GLubyte;
typedef int GLint;
typedef unsigned int GLuint;
typedef int GLsizei;
typedef khronos_float_t GLfloat;
typedef char GLchar;
typedef khronos_intptr_t GLintptr;
typedef khronos_ssize_t GLsizeiptr;

/* ----------------------------------- ENUMS --------------------------------- */

/* GL_ES_VERSION_2_0 */

#define GL_DEPTH_BUFFER_BIT 0x00000100
#define GL_STENCIL_BUFFER_BIT 0x00000400
#define GL_COLOR_BUFFER_BIT 0x00004000
#define GL_FALSE 0
#define GL_TRUE 1
#define GL_POINTS 0x0000
#define GL_LINES 0x0001
#define GL_LINE_LOOP 0x0002
#define GL_LINE_STRIP 0x0003
#define GL_TRIANGLES 0x0004
#define GL_TRIANGLE_STRIP 0x0005
#define GL_TRIANGLE_FAN 0x0006
#define GL_ZERO 0
#define GL_ONE 1
#define GL_SRC_COLOR 0x0300
#define GL_ONE_MINUS_SRC_COLOR 0x0301
#define GL_SRC_ALPHA 0x0302
#define GL_ONE_MINUS_SRC_ALPHA 0x0303
#define GL_DST_ALPHA 0x0304
#define GL_ONE_MINUS_DST_ALPHA 0x0305
#define GL_DST_COLOR 0x0306
#define GL_ONE_MINUS_DST_COLOR 0x0307
#define GL_SRC_ALPHA_SATURATE 0x0308
#define GL_FUNC_ADD 0x8006
#define GL_BLEND_EQUATION 0x8009
#define GL_BLEND_EQUATION_RGB 0x8009
#define GL_BLEND_EQUATION_ALPHA 0x883D
#define GL_FUNC_SUBTRACT 0x800A
#define GL_FUNC_REVERSE_SUBTRACT 0x800B
#define GL_BLEND_DST_RGB 0x80C8
#define GL_BLEND_SRC_RGB 0x80C9
#define GL_BLEND_DST_ALPHA 0x80CA
#define GL_BLEND_SRC_ALPHA 0x80CB
#define GL_CONSTANT_COLOR 0x8001
#define GL_ONE_MINUS_CONSTANT_COLOR 0x8002
#define GL_CONSTANT_ALPHA 0x8003
#define GL_ONE_MINUS_CONSTANT_ALPHA 0x8004
#define GL_BLEND_COLOR 0x8005
#define GL_ARRAY_BUFFER 0x8892
#define GL_ELEMENT_ARRAY_BUFFER 0x8893
#define GL_ARRAY_BUFFER_BINDING 0x8894
#define GL_ELEMENT_ARRAY_BUFFER_BINDING 0x8895
#define GL_STREAM_DRAW 0x88E0
#define GL_STATIC_DRAW 0x88E4
#define GL_DYNAMIC_DRAW 0x88E8
#define GL_BUFFER_SIZE 0x8764
#define GL_BUFFER_USAGE 0x8765
#define GL_CURRENT_VERTEX_ATTRIB 0x8626
#define GL_FRONT 0x0404
#define GL_BACK 0x0405
#define GL_FRONT_AND_BACK 0x0408
#define GL_TEXTURE_2D 0x0DE1
#define GL_CULL_FACE 0x0B44
#define GL_BLEND 0x0BE2
#define GL_DITHER 0x0BD0
#define GL_STENCIL_TEST 0x0B90
#define GL_DEPTH_TEST 0x0B71
#define GL_SCISSOR_TEST 0x0C11
#define GL_POLYGON_OFFSET_FILL 0x8037
#define GL_SAMPLE_ALPHA_TO_COVERAGE 0x809E
#define GL_SAMPLE_COVERAGE 0x80A0
#define GL_NO_ERROR 0
#define GL_INVALID_ENUM 0x0500
#define GL_INVALID_VALUE 0x0501
#define GL_INVALID_OPERATION 0x0502
#define GL_OUT_OF_MEMORY 0x0505
#define GL_CW 0x0900
#define GL_CCW 0x0901
#define GL_LINE_WIDTH 0x0B21
#define GL_ALIASED_POINT_SIZE_RANGE 0x846D
#define GL_ALIASED_LINE_WIDTH_RANGE 0x846E
#define GL_CULL_FACE_MODE 0x0B45
#define GL_FRONT_FACE 0x0B46
#define GL_DEPTH_RANGE 0x0B70
#define GL_DEPTH_WRITEMASK 0x0B72
#define GL_DEPTH_CLEAR_VALUE 0x0B73
#define GL_DEPTH_FUNC 0x0B74
#define GL_STENCIL_CLEAR_VALUE 0x0B91
#define GL_STENCIL_FUNC 0x0B92
#define GL_STENCIL_FAIL 0x0B94
#define GL_STENCIL_PASS_DEPTH_FAIL 0x0B95
#define GL_STENCIL_PASS_DEPTH_PASS 0x0B96
#define GL_STENCIL_REF 0x0B97
#define GL_STENCIL_VALUE_MASK 0x0B93
#define GL_STENCIL_WRITEMASK 0x0B98
#define GL_STENCIL_BACK_FUNC 0x8800
#define GL_STENCIL_BACK_FAIL 0x8801
#define GL_STENCIL_BACK_PASS_DEPTH_FAIL 0x8802
#define GL_STENCIL_BACK_PASS_DEPTH_PASS 0x8803
#define GL_STENCIL_BACK_REF 0x8CA3
#define GL_STENCIL_BACK_VALUE_MASK 0x8CA4
#define GL_STENCIL_BACK_WRITEMASK 0x8CA5
#define GL_VIEWPORT 0x0BA2
#define GL_SCISSOR_BOX 0x0C10
#define GL_COLOR_CLEAR_VALUE 0x0C22
#define GL_COLOR_WRITEMASK 0x0C23
#define GL_UNPACK_ALIGNMENT 0x0CF5
#define GL_PACK_ALIGNMENT 0x0D05
#define GL_MAX_TEXTURE_SIZE 0x0D33
#define GL_MAX_VIEWPORT_DIMS 0x0D3A
#define GL_SUBPIXEL_BITS 0x0D50
#define GL_RED_BITS 0x0D52
#define GL_GREEN_BITS 0x0D53
#define GL_BLUE_BITS 0x0D54
#define GL_ALPHA_BITS 0x0D55
#define GL_DEPTH_BITS 0x0D56
#define GL_STENCIL_BITS 0x0D57
#define GL_POLYGON_OFFSET_UNITS 0x2A00
#define GL_POLYGON_OFFSET_FACTOR 0x8038
#define GL_TEXTURE_BINDING_2D 0x8069
#define GL_SAMPLE_BUFFERS 0x80A8
#define GL_SAMPLES 0x80A9
#define GL_SAMPLE_COVERAGE_VALUE 0x80AA
#define GL_SAMPLE_COVERAGE_INVERT 0x80AB
#define GL_NUM_COMPRESSED_TEXTURE_FORMATS 0x86A2
#define GL_COMPRESSED_TEXTURE_FORMATS 0x86A3
#define GL_DONT_CARE 0x1100
#define GL_FASTEST 0x1101
#define GL_NICEST 0x1102
#define GL_GENERATE_MIPMAP_HINT 0x8192
#define GL_BYTE 0x1400
#define GL_UNSIGNED_BYTE 0x1401
#define GL_SHORT 0x1402
#define GL_UNSIGNED_SHORT 0x1403
#define GL_INT 0x1404
#define GL_UNSIGNED_INT 0x1405
#define GL_FLOAT 0x1406
#define GL_FIXED 0x140C
#define GL_DEPTH_COMPONENT 0x1902
#define GL_ALPHA 0x1906
#define GL_RGB 0x1907
#define GL_RGBA 0x1908
#define GL_LUMINANCE 0x1909
#define GL_LUMINANCE_ALPHA 0x190A
#define GL_UNSIGNED_SHORT_4_4_4_4 0x8033
#define GL_UNSIGNED_SHORT_5_5_5_1 0x8034
#define GL_UNSIGNED_SHORT_5_6_5 0x8363
#define GL_FRAGMENT_SHADER 0x8B30
#define GL_VERTEX_SHADER 0x8B31
#define GL_MAX_VERTEX_ATTRIBS 0x8869
#define GL_MAX_VERTEX_UNIFORM_VECTORS 0x8DFB
#define GL_MAX_VARYING_VECTORS 0x8DFC
#define GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS 0x8B4D
#define GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS 0x8B4C
#define GL_MAX_TEXTURE_IMAGE_UNITS 0x8872
#define GL_MAX_FRAGMENT_UNIFORM_VECTORS 0x8DFD
#define GL_SHADER_TYPE 0x8B4F
#define GL_DELETE_STATUS 0x8B80
#define GL_LINK_STATUS 0x8B82
#define GL_VALIDATE_STATUS 0x8B83
#define GL_ATTACHED_SHADERS 0x8B85
#define GL_ACTIVE_UNIFORMS 0x8B86
#define GL_ACTIVE_UNIFORM_MAX_LENGTH 0x8B87
#define GL_ACTIVE_ATTRIBUTES 0x8B89
#define GL_ACTIVE_ATTRIBUTE_MAX_LENGTH 0x8B8A
#define GL_SHADING_LANGUAGE_VERSION 0x8B8C
#define GL_CURRENT_PROGRAM 0x8B8D
#define GL_NEVER 0x0200
#define GL_LESS 0x0201
#define GL_EQUAL 0x0202
#define GL_LEQUAL 0x0203
#define GL_GREATER 0x0204
#define GL_NOTEQUAL 0x0205
#define GL_GEQUAL 0x0206
#define GL_ALWAYS 0x0207
#define GL_KEEP 0x1E00
#define GL_REPLACE 0x1E01
#define GL_INCR 0x1E02
#define GL_DECR 0x1E03
#define GL_INVERT 0x150A
#define GL_INCR_WRAP 0x8507
#define GL_DECR_WRAP 0x8508
#define GL_VENDOR 0x1F00
#define GL_RENDERER 0x1F01
#define GL_VERSION 0x1F02
#define GL_EXTENSIONS 0x1F03
#define GL_NEAREST 0x2600
#define GL_LINEAR 0x2601
#define GL_NEAREST_MIPMAP_NEAREST 0x2700
#define GL_LINEAR_MIPMAP_NEAREST 0x2701
#define GL_NEAREST_MIPMAP_LINEAR 0x2702
#define GL_LINEAR_MIPMAP_LINEAR 0x2703
#define GL_TEXTURE_MAG_FILTER 0x2800
#define GL_TEXTURE_MIN_FILTER 0x2801
#define GL_TEXTURE_WRAP_S 0x2802
#define GL_TEXTURE_WRAP_T 0x2803
#define GL_TEXTURE 0x1702
#define GL_TEXTURE_CUBE_MAP 0x8513
#define GL_TEXTURE_BINDING_CUBE_MAP 0x8514
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X 0x8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X 0x8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y 0x8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y 0x8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z 0x8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z 0x851A
#define GL_MAX_CUBE_MAP_TEXTURE_SIZE 0x851C
#define GL_TEXTURE0 0x84C0
#define GL_TEXTURE1 0x84C1
#define GL_TEXTURE2 0x84C2
#define GL_TEXTURE3 0x84C3
#define GL_TEXTURE4 0x84C4
#define GL_TEXTURE5 0x84C5
#define GL_TEXTURE6 0x84C6
#define GL_TEXTURE7 0x84C7
#define GL_TEXTURE8 0x84C8
#define GL_TEXTURE9 0x84C9
#define GL_TEXTURE10 0x84CA
#define GL_TEXTURE11 0x84CB
#define GL_TEXTURE12 0x84CC
#define GL_TEXTURE13 0x84CD
#define GL_TEXTURE14 0x84CE
#define GL_TEXTURE15 0x84CF
#define GL_TEXTURE16 0x84D0
#define GL_TEXTURE17 0x84D1
#define GL_TEXTURE18 0x84D2
#define GL_TEXTURE19 0x84D3
#define GL_TEXTURE20 0x84D4
#define GL_TEXTURE21 0x84D5
#define GL_TEXTURE22 0x84D6
#define GL_TEXTURE23 0x84D7
#define GL_TEXTURE24 0x84D8
#define GL_TEXTURE25 0x84D9
#define GL_TEXTURE26 0x84DA
#define GL_TEXTURE27 0x84DB
#define GL_TEXTURE28 0x84DC
#define GL_TEXTURE29 0x84DD
#define GL_TEXTURE30 0x84DE
#define GL_TEXTURE31 0x84DF
#define GL_ACTIVE_TEXTURE 0x84E0
#define GL_REPEAT 0x2901
#define GL_CLAMP_TO_EDGE 0x812F
#define GL_MIRRORED_REPEAT 0x8370
#define GL_FLOAT_VEC2 0x8B50
#define GL_FLOAT_VEC3 0x8B51
#define GL_FLOAT_VEC4 0x8B52
#define GL_INT_VEC2 0x8B53
#define GL_INT_VEC3 0x8B54
#define GL_INT_VEC4 0x8B55
#define GL_BOOL 0x8B56
#define GL_BOOL_VEC2 0x8B57
#define GL_BOOL_VEC3 0x8B58
#define GL_BOOL_VEC4 0x8B59
#define GL_FLOAT_MAT2 0x8B5A
#define GL_FLOAT_MAT3 0x8B5B
#define GL_FLOAT_MAT4 0x8B5C
#define GL_SAMPLER_2D 0x8B5E
#define GL_SAMPLER_CUBE 0x8B60
#define GL_VERTEX_ATTRIB_ARRAY_ENABLED 0x8622
#define GL_VERTEX_ATTRIB_ARRAY_SIZE 0x8623
#define GL_VERTEX_ATTRIB_ARRAY_STRIDE 0x8624
#define GL_VERTEX_ATTRIB_ARRAY_TYPE 0x8625
#define GL_VERTEX_ATTRIB_ARRAY_NORMALIZED 0x886A
#define GL_VERTEX_ATTRIB_ARRAY_POINTER 0x8645
#define GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING 0x889F
#define GL_IMPLEMENTATION_COLOR_READ_TYPE 0x8B9A
#define GL_IMPLEMENTATION_COLOR_READ_FORMAT 0x8B9B
#define GL_COMPILE_STATUS 0x8B81
#define GL_INFO_LOG_LENGTH 0x8B84
#define GL_SHADER_SOURCE_LENGTH 0x8B88
#define GL_SHADER_COMPILER 0x8DFA
#define GL_SHADER_BINARY_FORMATS 0x8DF8
#define GL_NUM_SHADER_BINARY_FORMATS 0x8DF9
#define GL_LOW_FLOAT 0x8DF0
#define GL_MEDIUM_FLOAT 0x8DF1
#define GL_HIGH_FLOAT 0x8DF2
#define GL_LOW_INT 0x8DF3
#define GL_MEDIUM_INT 0x8DF4
#define GL_HIGH_INT 0x8DF5
#define GL_FRAMEBUFFER 0x8D40
#define GL_RENDERBUFFER 0x8D41
#define GL_RGBA4 0x8056
#define GL_RGB5_A1 0x8057
#define GL_RGB565 0x8D62
#define GL_DEPTH_COMPONENT16 0x81A5
#define GL_STENCIL_INDEX8 0x8D48
#define GL_RENDERBUFFER_WIDTH 0x8D42
#define GL_RENDERBUFFER_HEIGHT 0x8D43
#define GL_RENDERBUFFER_INTERNAL_FORMAT 0x8D44
#define GL_RENDERBUFFER_RED_SIZE 0x8D50
#define GL_RENDERBUFFER_GREEN_SIZE 0x8D51
#define GL_RENDERBUFFER_BLUE_SIZE 0x8D52
#define GL_RENDERBUFFER_ALPHA_SIZE 0x8D53
#define GL_RENDERBUFFER_DEPTH_SIZE 0x8D54
#define GL_RENDERBUFFER_STENCIL_SIZE 0x8D55
#define GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE 0x8CD0
#define GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME 0x8CD1
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL 0x8CD2
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE 0x8CD3
#define GL_COLOR_ATTACHMENT0 0x8CE0
#define GL_DEPTH_ATTACHMENT 0x8D00
#define GL_STENCIL_ATTACHMENT 0x8D20
#define GL_NONE 0
#define GL_FRAMEBUFFER_COMPLETE 0x8CD5
#define GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT 0x8CD6
#define GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT 0x8CD7
#define GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS 0x8CD9
#define GL_FRAMEBUFFER_UNSUPPORTED 0x8CDD
#define GL_FRAMEBUFFER_BINDING 0x8CA6
#define GL_RENDERBUFFER_BINDING 0x8CA7
#define GL_MAX_RENDERBUFFER_SIZE 0x84E8
#define GL_INVALID_FRAMEBUFFER_OPERATION 0x0506

/* --------------------------- FUNCTION PROTOTYPES --------------------------- */


/* GL_ES_VERSION_2_0 */

typedef void (APIENTRY PFNGLACTIVETEXTURE_PROC (GLenum texture));
typedef void (APIENTRY PFNGLATTACHSHADER_PROC (GLuint program, GLuint shader));
typedef void (APIENTRY PFNGLBINDATTRIBLOCATION_PROC (GLuint program, GLuint index, const GLchar * name));
typedef void (APIENTRY PFNGLBINDBUFFER_PROC (GLenum target, GLuint buffer));
typedef void (APIENTRY PFNGLBINDFRAMEBUFFER_PROC (GLenum target, GLuint framebuffer));
typedef void (APIENTRY PFNGLBINDRENDERBUFFER_PROC (GLenum target, GLuint renderbuffer));
typedef void (APIENTRY PFNGLBINDTEXTURE_PROC (GLenum target, GLuint texture));
typedef void (APIENTRY PFNGLBLENDCOLOR_PROC (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha));
typedef void (APIENTRY PFNGLBLENDEQUATION_PROC (GLenum mode));
typedef void (APIENTRY PFNGLBLENDEQUATIONSEPARATE_PROC (GLenum modeRGB, GLenum modeAlpha));
typedef void (APIENTRY PFNGLBLENDFUNC_PROC (GLenum sfactor, GLenum dfactor));
typedef void (APIENTRY PFNGLBLENDFUNCSEPARATE_PROC (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha));
typedef void (APIENTRY PFNGLBUFFERDATA_PROC (GLenum target, GLsizeiptr size, const void * data, GLenum usage));
typedef void (APIENTRY PFNGLBUFFERSUBDATA_PROC (GLenum target, GLintptr offset, GLsizeiptr size, const void * data));
typedef GLenum (APIENTRY PFNGLCHECKFRAMEBUFFERSTATUS_PROC (GLenum target));
typedef void (APIENTRY PFNGLCLEAR_PROC (GLbitfield mask));
typedef void (APIENTRY PFNGLCLEARCOLOR_PROC (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha));
typedef void (APIENTRY PFNGLCLEARDEPTHF_PROC (GLfloat d));
typedef void (APIENTRY PFNGLCLEARSTENCIL_PROC (GLint s));
typedef void (APIENTRY PFNGLCOLORMASK_PROC (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha));
typedef void (APIENTRY PFNGLCOMPILESHADER_PROC (GLuint shader));
typedef void (APIENTRY PFNGLCOMPRESSEDTEXIMAGE2D_PROC (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void * data));
typedef void (APIENTRY PFNGLCOMPRESSEDTEXSUBIMAGE2D_PROC (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void * data));
typedef void (APIENTRY PFNGLCOPYTEXIMAGE2D_PROC (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border));
typedef void (APIENTRY PFNGLCOPYTEXSUBIMAGE2D_PROC (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height));
typedef GLuint (APIENTRY PFNGLCREATEPROGRAM_PROC (void));
typedef GLuint (APIENTRY PFNGLCREATESHADER_PROC (GLenum type));
typedef void (APIENTRY PFNGLCULLFACE_PROC (GLenum mode));
typedef void (APIENTRY PFNGLDELETEBUFFERS_PROC (GLsizei n, const GLuint * buffers));
typedef void (APIENTRY PFNGLDELETEFRAMEBUFFERS_PROC (GLsizei n, const GLuint * framebuffers));
typedef void (APIENTRY PFNGLDELETEPROGRAM_PROC (GLuint program));
typedef void (APIENTRY PFNGLDELETERENDERBUFFERS_PROC (GLsizei n, const GLuint * renderbuffers));
typedef void (APIENTRY PFNGLDELETESHADER_PROC (GLuint shader));
typedef void (APIENTRY PFNGLDELETETEXTURES_PROC (GLsizei n, const GLuint * textures));
typedef void (APIENTRY PFNGLDEPTHFUNC_PROC (GLenum func));
typedef void (APIENTRY PFNGLDEPTHMASK_PROC (GLboolean flag));
typedef void (APIENTRY PFNGLDEPTHRANGEF_PROC (GLfloat n, GLfloat f));
typedef void (APIENTRY PFNGLDETACHSHADER_PROC (GLuint program, GLuint shader));
typedef void (APIENTRY PFNGLDISABLE_PROC (GLenum cap));
typedef void (APIENTRY PFNGLDISABLEVERTEXATTRIBARRAY_PROC (GLuint index));
typedef void (APIENTRY PFNGLDRAWARRAYS_PROC (GLenum mode, GLint first, GLsizei count));
typedef void (APIENTRY PFNGLDRAWELEMENTS_PROC (GLenum mode, GLsizei count, GLenum type, const void * indices));
typedef void (APIENTRY PFNGLENABLE_PROC (GLenum cap));
typedef void (APIENTRY PFNGLENABLEVERTEXATTRIBARRAY_PROC (GLuint index));
typedef void (APIENTRY PFNGLFINISH_PROC (void));
typedef void (APIENTRY PFNGLFLUSH_PROC (void));
typedef void (APIENTRY PFNGLFRAMEBUFFERRENDERBUFFER_PROC (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer));
typedef void (APIENTRY PFNGLFRAMEBUFFERTEXTURE2D_PROC (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level));
typedef void (APIENTRY PFNGLFRONTFACE_PROC (GLenum mode));
typedef void (APIENTRY PFNGLGENBUFFERS_PROC (GLsizei n, GLuint * buffers));
typedef void (APIENTRY PFNGLGENFRAMEBUFFERS_PROC (GLsizei n, GLuint * framebuffers));
typedef void (APIENTRY PFNGLGENRENDERBUFFERS_PROC (GLsizei n, GLuint * renderbuffers));
typedef void (APIENTRY PFNGLGENTEXTURES_PROC (GLsizei n, GLuint * textures));
typedef void (APIENTRY PFNGLGENERATEMIPMAP_PROC (GLenum target));
typedef void (APIENTRY PFNGLGETACTIVEATTRIB_PROC (GLuint program, GLuint index, GLsizei bufSize, GLsizei * length, GLint * size, GLenum * type, GLchar * name));
typedef void (APIENTRY PFNGLGETACTIVEUNIFORM_PROC (GLuint program, GLuint index, GLsizei bufSize, GLsizei * length, GLint * size, GLenum * type, GLchar * name));
typedef void (APIENTRY PFNGLGETATTACHEDSHADERS_PROC (GLuint program, GLsizei maxCount, GLsizei * count, GLuint * shaders));
typedef GLint (APIENTRY PFNGLGETATTRIBLOCATION_PROC (GLuint program, const GLchar * name));
typedef void (APIENTRY PFNGLGETBOOLEANV_PROC (GLenum pname, GLboolean * data));
typedef void (APIENTRY PFNGLGETBUFFERPARAMETERIV_PROC (GLenum target, GLenum pname, GLint * params));
typedef GLenum (APIENTRY PFNGLGETERROR_PROC (void));
typedef void (APIENTRY PFNGLGETFLOATV_PROC (GLenum pname, GLfloat * data));
typedef void (APIENTRY PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIV_PROC (GLenum target, GLenum attachment, GLenum pname, GLint * params));
typedef void (APIENTRY PFNGLGETINTEGERV_PROC (GLenum pname, GLint * data));
typedef void (APIENTRY PFNGLGETPROGRAMINFOLOG_PROC (GLuint program, GLsizei bufSize, GLsizei * length, GLchar * infoLog));
typedef void (APIENTRY PFNGLGETPROGRAMIV_PROC (GLuint program, GLenum pname, GLint * params));
typedef void (APIENTRY PFNGLGETRENDERBUFFERPARAMETERIV_PROC (GLenum target, GLenum pname, GLint * params));
typedef void (APIENTRY PFNGLGETSHADERINFOLOG_PROC (GLuint shader, GLsizei bufSize, GLsizei * length, GLchar * infoLog));
typedef void (APIENTRY PFNGLGETSHADERPRECISIONFORMAT_PROC (GLenum shadertype, GLenum precisiontype, GLint * range, GLint * precision));
typedef void (APIENTRY PFNGLGETSHADERSOURCE_PROC (GLuint shader, GLsizei bufSize, GLsizei * length, GLchar * source));
typedef void (APIENTRY PFNGLGETSHADERIV_PROC (GLuint shader, GLenum pname, GLint * params));
typedef const GLubyte * (APIENTRY PFNGLGETSTRING_PROC (GLenum name));
typedef void (APIENTRY PFNGLGETTEXPARAMETERFV_PROC (GLenum target, GLenum pname, GLfloat * params));
typedef void (APIENTRY PFNGLGETTEXPARAMETERIV_PROC (GLenum target, GLenum pname, GLint * params));
typedef GLint (APIENTRY PFNGLGETUNIFORMLOCATION_PROC (GLuint program, const GLchar * name));
typedef void (APIENTRY PFNGLGETUNIFORMFV_PROC (GLuint program, GLint location, GLfloat * params));
typedef void (APIENTRY PFNGLGETUNIFORMIV_PROC (GLuint program, GLint location, GLint * params));
typedef void (APIENTRY PFNGLGETVERTEXATTRIBPOINTERV_PROC (GLuint index, GLenum pname, void ** pointer));
typedef void (APIENTRY PFNGLGETVERTEXATTRIBFV_PROC (GLuint index, GLenum pname, GLfloat * params));
typedef void (APIENTRY PFNGLGETVERTEXATTRIBIV_PROC (GLuint index, GLenum pname, GLint * params));
typedef void (APIENTRY PFNGLHINT_PROC (GLenum target, GLenum mode));
typedef GLboolean (APIENTRY PFNGLISBUFFER_PROC (GLuint buffer));
typedef GLboolean (APIENTRY PFNGLISENABLED_PROC (GLenum cap));
typedef GLboolean (APIENTRY PFNGLISFRAMEBUFFER_PROC (GLuint framebuffer));
typedef GLboolean (APIENTRY PFNGLISPROGRAM_PROC (GLuint program));
typedef GLboolean (APIENTRY PFNGLISRENDERBUFFER_PROC (GLuint renderbuffer));
typedef GLboolean (APIENTRY PFNGLISSHADER_PROC (GLuint shader));
typedef GLboolean (APIENTRY PFNGLISTEXTURE_PROC (GLuint texture));
typedef void (APIENTRY PFNGLLINEWIDTH_PROC (GLfloat width));
typedef void (APIENTRY PFNGLLINKPROGRAM_PROC (GLuint program));
typedef void (APIENTRY PFNGLPIXELSTOREI_PROC (GLenum pname, GLint param));
typedef void (APIENTRY PFNGLPOLYGONOFFSET_PROC (GLfloat factor, GLfloat units));
typedef void (APIENTRY PFNGLREADPIXELS_PROC (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, void * pixels));
typedef void (APIENTRY PFNGLRELEASESHADERCOMPILER_PROC (void));
typedef void (APIENTRY PFNGLRENDERBUFFERSTORAGE_PROC (GLenum target, GLenum internalformat, GLsizei width, GLsizei height));
typedef void (APIENTRY PFNGLSAMPLECOVERAGE_PROC (GLfloat value, GLboolean invert));
typedef void (APIENTRY PFNGLSCISSOR_PROC (GLint x, GLint y, GLsizei width, GLsizei height));
typedef void (APIENTRY PFNGLSHADERBINARY_PROC (GLsizei count, const GLuint * shaders, GLenum binaryformat, const void * binary, GLsizei length));
typedef void (APIENTRY PFNGLSHADERSOURCE_PROC (GLuint shader, GLsizei count, const GLchar *const* string, const GLint * length));
typedef void (APIENTRY PFNGLSTENCILFUNC_PROC (GLenum func, GLint ref, GLuint mask));
typedef void (APIENTRY PFNGLSTENCILFUNCSEPARATE_PROC (GLenum face, GLenum func, GLint ref, GLuint mask));
typedef void (APIENTRY PFNGLSTENCILMASK_PROC (GLuint mask));
typedef void (APIENTRY PFNGLSTENCILMASKSEPARATE_PROC (GLenum face, GLuint mask));
typedef void (APIENTRY PFNGLSTENCILOP_PROC (GLenum fail, GLenum zfail, GLenum zpass));
typedef void (APIENTRY PFNGLSTENCILOPSEPARATE_PROC (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass));
typedef void (APIENTRY PFNGLTEXIMAGE2D_PROC (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void * pixels));
typedef void (APIENTRY PFNGLTEXPARAMETERF_PROC (GLenum target, GLenum pname, GLfloat param));
typedef void (APIENTRY PFNGLTEXPARAMETERFV_PROC (GLenum target, GLenum pname, const GLfloat * params));
typedef void (APIENTRY PFNGLTEXPARAMETERI_PROC (GLenum target, GLenum pname, GLint param));
typedef void (APIENTRY PFNGLTEXPARAMETERIV_PROC (GLenum target, GLenum pname, const GLint * params));
typedef void (APIENTRY PFNGLTEXSUBIMAGE2D_PROC (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void * pixels));
typedef void (APIENTRY PFNGLUNIFORM1F_PROC (GLint location, GLfloat v0));
typedef void (APIENTRY PFNGLUNIFORM1FV_PROC (GLint location, GLsizei count, const GLfloat * value));
typedef void (APIENTRY PFNGLUNIFORM1I_PROC (GLint location, GLint v0));
typedef void (APIENTRY PFNGLUNIFORM1IV_PROC (GLint location, GLsizei count, const GLint * value));
typedef void (APIENTRY PFNGLUNIFORM2F_PROC (GLint location, GLfloat v0, GLfloat v1));
typedef void (APIENTRY PFNGLUNIFORM2FV_PROC (GLint location, GLsizei count, const GLfloat * value));
typedef void (APIENTRY PFNGLUNIFORM2I_PROC (GLint location, GLint v0, GLint v1));
typedef void (APIENTRY PFNGLUNIFORM2IV_PROC (GLint location, GLsizei count, const GLint * value));
typedef void (APIENTRY PFNGLUNIFORM3F_PROC (GLint location, GLfloat v0, GLfloat v1, GLfloat v2));
typedef void (APIENTRY PFNGLUNIFORM3FV_PROC (GLint location, GLsizei count, const GLfloat * value));
typedef void (APIENTRY PFNGLUNIFORM3I_PROC (GLint location, GLint v0, GLint v1, GLint v2));
typedef void (APIENTRY PFNGLUNIFORM3IV_PROC (GLint location, GLsizei count, const GLint * value));
typedef void (APIENTRY PFNGLUNIFORM4F_PROC (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3));
typedef void (APIENTRY PFNGLUNIFORM4FV_PROC (GLint location, GLsizei count, const GLfloat * value));
typedef void (APIENTRY PFNGLUNIFORM4I_PROC (GLint location, GLint v0, GLint v1, GLint v2, GLint v3));
typedef void (APIENTRY PFNGLUNIFORM4IV_PROC (GLint location, GLsizei count, const GLint * value));
typedef void (APIENTRY PFNGLUNIFORMMATRIX2FV_PROC (GLint location, GLsizei count, GLboolean transpose, const GLfloat * value));
typedef void (APIENTRY PFNGLUNIFORMMATRIX3FV_PROC (GLint location, GLsizei count, GLboolean transpose, const GLfloat * value));
typedef void (APIENTRY PFNGLUNIFORMMATRIX4FV_PROC (GLint location, GLsizei count, GLboolean transpose, const GLfloat * value));
typedef void (APIENTRY PFNGLUSEPROGRAM_PROC (GLuint program));
typedef void (APIENTRY PFNGLVALIDATEPROGRAM_PROC (GLuint program));
typedef void (APIENTRY PFNGLVERTEXATTRIB1F_PROC (GLuint index, GLfloat x));
typedef void (APIENTRY PFNGLVERTEXATTRIB1FV_PROC (GLuint index, const GLfloat * v));
typedef void (APIENTRY PFNGLVERTEXATTRIB2F_PROC (GLuint index, GLfloat x, GLfloat y));
typedef void (APIENTRY PFNGLVERTEXATTRIB2FV_PROC (GLuint index, const GLfloat * v));
typedef void (APIENTRY PFNGLVERTEXATTRIB3F_PROC (GLuint index, GLfloat x, GLfloat y, GLfloat z));
typedef void (APIENTRY PFNGLVERTEXATTRIB3FV_PROC (GLuint index, const GLfloat * v));
typedef void (APIENTRY PFNGLVERTEXATTRIB4F_PROC (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w));
typedef void (APIENTRY PFNGLVERTEXATTRIB4FV_PROC (GLuint index, const GLfloat * v));
typedef void (APIENTRY PFNGLVERTEXATTRIBPOINTER_PROC (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void * pointer));
typedef void (APIENTRY PFNGLVIEWPORT_PROC (GLint x, GLint y, GLsizei width, GLsizei height));

GLAPI PFNGLACTIVETEXTURE_PROC *glpfActiveTexture;
GLAPI PFNGLATTACHSHADER_PROC *glpfAttachShader;
GLAPI PFNGLBINDATTRIBLOCATION_PROC *glpfBindAttribLocation;
GLAPI PFNGLBINDBUFFER_PROC *glpfBindBuffer;
GLAPI PFNGLBINDFRAMEBUFFER_PROC *glpfBindFramebuffer;
GLAPI PFNGLBINDRENDERBUFFER_PROC *glpfBindRenderbuffer;
GLAPI PFNGLBINDTEXTURE_PROC *glpfBindTexture;
GLAPI PFNGLBLENDCOLOR_PROC *glpfBlendColor;
GLAPI PFNGLBLENDEQUATION_PROC *glpfBlendEquation;
GLAPI PFNGLBLENDEQUATIONSEPARATE_PROC *glpfBlendEquationSeparate;
GLAPI PFNGLBLENDFUNC_PROC *glpfBlendFunc;
GLAPI PFNGLBLENDFUNCSEPARATE_PROC *glpfBlendFuncSeparate;
GLAPI PFNGLBUFFERDATA_PROC *glpfBufferData;
GLAPI PFNGLBUFFERSUBDATA_PROC *glpfBufferSubData;
GLAPI PFNGLCHECKFRAMEBUFFERSTATUS_PROC *glpfCheckFramebufferStatus;
GLAPI PFNGLCLEAR_PROC *glpfClear;
GLAPI PFNGLCLEARCOLOR_PROC *glpfClearColor;
GLAPI PFNGLCLEARDEPTHF_PROC *glpfClearDepthf;
GLAPI PFNGLCLEARSTENCIL_PROC *glpfClearStencil;
GLAPI PFNGLCOLORMASK_PROC *glpfColorMask;
GLAPI PFNGLCOMPILESHADER_PROC *glpfCompileShader;
GLAPI PFNGLCOMPRESSEDTEXIMAGE2D_PROC *glpfCompressedTexImage2D;
GLAPI PFNGLCOMPRESSEDTEXSUBIMAGE2D_PROC *glpfCompressedTexSubImage2D;
GLAPI PFNGLCOPYTEXIMAGE2D_PROC *glpfCopyTexImage2D;
GLAPI PFNGLCOPYTEXSUBIMAGE2D_PROC *glpfCopyTexSubImage2D;
GLAPI PFNGLCREATEPROGRAM_PROC *glpfCreateProgram;
GLAPI PFNGLCREATESHADER_PROC *glpfCreateShader;
GLAPI PFNGLCULLFACE_PROC *glpfCullFace;
GLAPI PFNGLDELETEBUFFERS_PROC *glpfDeleteBuffers;
GLAPI PFNGLDELETEFRAMEBUFFERS_PROC *glpfDeleteFramebuffers;
GLAPI PFNGLDELETEPROGRAM_PROC *glpfDeleteProgram;
GLAPI PFNGLDELETERENDERBUFFERS_PROC *glpfDeleteRenderbuffers;
GLAPI PFNGLDELETESHADER_PROC *glpfDeleteShader;
GLAPI PFNGLDELETETEXTURES_PROC *glpfDeleteTextures;
GLAPI PFNGLDEPTHFUNC_PROC *glpfDepthFunc;
GLAPI PFNGLDEPTHMASK_PROC *glpfDepthMask;
GLAPI PFNGLDEPTHRANGEF_PROC *glpfDepthRangef;
GLAPI PFNGLDETACHSHADER_PROC *glpfDetachShader;
GLAPI PFNGLDISABLE_PROC *glpfDisable;
GLAPI PFNGLDISABLEVERTEXATTRIBARRAY_PROC *glpfDisableVertexAttribArray;
GLAPI PFNGLDRAWARRAYS_PROC *glpfDrawArrays;
GLAPI PFNGLDRAWELEMENTS_PROC *glpfDrawElements;
GLAPI PFNGLENABLE_PROC *glpfEnable;
GLAPI PFNGLENABLEVERTEXATTRIBARRAY_PROC *glpfEnableVertexAttribArray;
GLAPI PFNGLFINISH_PROC *glpfFinish;
GLAPI PFNGLFLUSH_PROC *glpfFlush;
GLAPI PFNGLFRAMEBUFFERRENDERBUFFER_PROC *glpfFramebufferRenderbuffer;
GLAPI PFNGLFRAMEBUFFERTEXTURE2D_PROC *glpfFramebufferTexture2D;
GLAPI PFNGLFRONTFACE_PROC *glpfFrontFace;
GLAPI PFNGLGENBUFFERS_PROC *glpfGenBuffers;
GLAPI PFNGLGENFRAMEBUFFERS_PROC *glpfGenFramebuffers;
GLAPI PFNGLGENRENDERBUFFERS_PROC *glpfGenRenderbuffers;
GLAPI PFNGLGENTEXTURES_PROC *glpfGenTextures;
GLAPI PFNGLGENERATEMIPMAP_PROC *glpfGenerateMipmap;
GLAPI PFNGLGETACTIVEATTRIB_PROC *glpfGetActiveAttrib;
GLAPI PFNGLGETACTIVEUNIFORM_PROC *glpfGetActiveUniform;
GLAPI PFNGLGETATTACHEDSHADERS_PROC *glpfGetAttachedShaders;
GLAPI PFNGLGETATTRIBLOCATION_PROC *glpfGetAttribLocation;
GLAPI PFNGLGETBOOLEANV_PROC *glpfGetBooleanv;
GLAPI PFNGLGETBUFFERPARAMETERIV_PROC *glpfGetBufferParameteriv;
GLAPI PFNGLGETERROR_PROC *glpfGetError;
GLAPI PFNGLGETFLOATV_PROC *glpfGetFloatv;
GLAPI PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIV_PROC *glpfGetFramebufferAttachmentParameteriv;
GLAPI PFNGLGETINTEGERV_PROC *glpfGetIntegerv;
GLAPI PFNGLGETPROGRAMINFOLOG_PROC *glpfGetProgramInfoLog;
GLAPI PFNGLGETPROGRAMIV_PROC *glpfGetProgramiv;
GLAPI PFNGLGETRENDERBUFFERPARAMETERIV_PROC *glpfGetRenderbufferParameteriv;
GLAPI PFNGLGETSHADERINFOLOG_PROC *glpfGetShaderInfoLog;
GLAPI PFNGLGETSHADERPRECISIONFORMAT_PROC *glpfGetShaderPrecisionFormat;
GLAPI PFNGLGETSHADERSOURCE_PROC *glpfGetShaderSource;
GLAPI PFNGLGETSHADERIV_PROC *glpfGetShaderiv;
GLAPI PFNGLGETSTRING_PROC *glpfGetString;
GLAPI PFNGLGETTEXPARAMETERFV_PROC *glpfGetTexParameterfv;
GLAPI PFNGLGETTEXPARAMETERIV_PROC *glpfGetTexParameteriv;
GLAPI PFNGLGETUNIFORMLOCATION_PROC *glpfGetUniformLocation;
GLAPI PFNGLGETUNIFORMFV_PROC *glpfGetUniformfv;
GLAPI PFNGLGETUNIFORMIV_PROC *glpfGetUniformiv;
GLAPI PFNGLGETVERTEXATTRIBPOINTERV_PROC *glpfGetVertexAttribPointerv;
GLAPI PFNGLGETVERTEXATTRIBFV_PROC *glpfGetVertexAttribfv;
GLAPI PFNGLGETVERTEXATTRIBIV_PROC *glpfGetVertexAttribiv;
GLAPI PFNGLHINT_PROC *glpfHint;
GLAPI PFNGLISBUFFER_PROC *glpfIsBuffer;
GLAPI PFNGLISENABLED_PROC *glpfIsEnabled;
GLAPI PFNGLISFRAMEBUFFER_PROC *glpfIsFramebuffer;
GLAPI PFNGLISPROGRAM_PROC *glpfIsProgram;
GLAPI PFNGLISRENDERBUFFER_PROC *glpfIsRenderbuffer;
GLAPI PFNGLISSHADER_PROC *glpfIsShader;
GLAPI PFNGLISTEXTURE_PROC *glpfIsTexture;
GLAPI PFNGLLINEWIDTH_PROC *glpfLineWidth;
GLAPI PFNGLLINKPROGRAM_PROC *glpfLinkProgram;
GLAPI PFNGLPIXELSTOREI_PROC *glpfPixelStorei;
GLAPI PFNGLPOLYGONOFFSET_PROC *glpfPolygonOffset;
GLAPI PFNGLREADPIXELS_PROC *glpfReadPixels;
GLAPI PFNGLRELEASESHADERCOMPILER_PROC *glpfReleaseShaderCompiler;
GLAPI PFNGLRENDERBUFFERSTORAGE_PROC *glpfRenderbufferStorage;
GLAPI PFNGLSAMPLECOVERAGE_PROC *glpfSampleCoverage;
GLAPI PFNGLSCISSOR_PROC *glpfScissor;
GLAPI PFNGLSHADERBINARY_PROC *glpfShaderBinary;
GLAPI PFNGLSHADERSOURCE_PROC *glpfShaderSource;
GLAPI PFNGLSTENCILFUNC_PROC *glpfStencilFunc;
GLAPI PFNGLSTENCILFUNCSEPARATE_PROC *glpfStencilFuncSeparate;
GLAPI PFNGLSTENCILMASK_PROC *glpfStencilMask;
GLAPI PFNGLSTENCILMASKSEPARATE_PROC *glpfStencilMaskSeparate;
GLAPI PFNGLSTENCILOP_PROC *glpfStencilOp;
GLAPI PFNGLSTENCILOPSEPARATE_PROC *glpfStencilOpSeparate;
GLAPI PFNGLTEXIMAGE2D_PROC *glpfTexImage2D;
GLAPI PFNGLTEXPARAMETERF_PROC *glpfTexParameterf;
GLAPI PFNGLTEXPARAMETERFV_PROC *glpfTexParameterfv;
GLAPI PFNGLTEXPARAMETERI_PROC *glpfTexParameteri;
GLAPI PFNGLTEXPARAMETERIV_PROC *glpfTexParameteriv;
GLAPI PFNGLTEXSUBIMAGE2D_PROC *glpfTexSubImage2D;
GLAPI PFNGLUNIFORM1F_PROC *glpfUniform1f;
GLAPI PFNGLUNIFORM1FV_PROC *glpfUniform1fv;
GLAPI PFNGLUNIFORM1I_PROC *glpfUniform1i;
GLAPI PFNGLUNIFORM1IV_PROC *glpfUniform1iv;
GLAPI PFNGLUNIFORM2F_PROC *glpfUniform2f;
GLAPI PFNGLUNIFORM2FV_PROC *glpfUniform2fv;
GLAPI PFNGLUNIFORM2I_PROC *glpfUniform2i;
GLAPI PFNGLUNIFORM2IV_PROC *glpfUniform2iv;
GLAPI PFNGLUNIFORM3F_PROC *glpfUniform3f;
GLAPI PFNGLUNIFORM3FV_PROC *glpfUniform3fv;
GLAPI PFNGLUNIFORM3I_PROC *glpfUniform3i;
GLAPI PFNGLUNIFORM3IV_PROC *glpfUniform3iv;
GLAPI PFNGLUNIFORM4F_PROC *glpfUniform4f;
GLAPI PFNGLUNIFORM4FV_PROC *glpfUniform4fv;
GLAPI PFNGLUNIFORM4I_PROC *glpfUniform4i;
GLAPI PFNGLUNIFORM4IV_PROC *glpfUniform4iv;
GLAPI PFNGLUNIFORMMATRIX2FV_PROC *glpfUniformMatrix2fv;
GLAPI PFNGLUNIFORMMATRIX3FV_PROC *glpfUniformMatrix3fv;
GLAPI PFNGLUNIFORMMATRIX4FV_PROC *glpfUniformMatrix4fv;
GLAPI PFNGLUSEPROGRAM_PROC *glpfUseProgram;
GLAPI PFNGLVALIDATEPROGRAM_PROC *glpfValidateProgram;
GLAPI PFNGLVERTEXATTRIB1F_PROC *glpfVertexAttrib1f;
GLAPI PFNGLVERTEXATTRIB1FV_PROC *glpfVertexAttrib1fv;
GLAPI PFNGLVERTEXATTRIB2F_PROC *glpfVertexAttrib2f;
GLAPI PFNGLVERTEXATTRIB2FV_PROC *glpfVertexAttrib2fv;
GLAPI PFNGLVERTEXATTRIB3F_PROC *glpfVertexAttrib3f;
GLAPI PFNGLVERTEXATTRIB3FV_PROC *glpfVertexAttrib3fv;
GLAPI PFNGLVERTEXATTRIB4F_PROC *glpfVertexAttrib4f;
GLAPI PFNGLVERTEXATTRIB4FV_PROC *glpfVertexAttrib4fv;
GLAPI PFNGLVERTEXATTRIBPOINTER_PROC *glpfVertexAttribPointer;
GLAPI PFNGLVIEWPORT_PROC *glpfViewport;

#define glActiveTexture glpfActiveTexture
#define glAttachShader glpfAttachShader
#define glBindAttribLocation glpfBindAttribLocation
#define glBindBuffer glpfBindBuffer
#define glBindFramebuffer glpfBindFramebuffer
#define glBindRenderbuffer glpfBindRenderbuffer
#define glBindTexture glpfBindTexture
#define glBlendColor glpfBlendColor
#define glBlendEquation glpfBlendEquation
#define glBlendEquationSeparate glpfBlendEquationSeparate
#define glBlendFunc glpfBlendFunc
#define glBlendFuncSeparate glpfBlendFuncSeparate
#define glBufferData glpfBufferData
#define glBufferSubData glpfBufferSubData
#define glCheckFramebufferStatus glpfCheckFramebufferStatus
#define glClear glpfClear
#define glClearColor glpfClearColor
#define glClearDepthf glpfClearDepthf
#define glClearStencil glpfClearStencil
#define glColorMask glpfColorMask
#define glCompileShader glpfCompileShader
#define glCompressedTexImage2D glpfCompressedTexImage2D
#define glCompressedTexSubImage2D glpfCompressedTexSubImage2D
#define glCopyTexImage2D glpfCopyTexImage2D
#define glCopyTexSubImage2D glpfCopyTexSubImage2D
#define glCreateProgram glpfCreateProgram
#define glCreateShader glpfCreateShader
#define glCullFace glpfCullFace
#define glDeleteBuffers glpfDeleteBuffers
#define glDeleteFramebuffers glpfDeleteFramebuffers
#define glDeleteProgram glpfDeleteProgram
#define glDeleteRenderbuffers glpfDeleteRenderbuffers
#define glDeleteShader glpfDeleteShader
#define glDeleteTextures glpfDeleteTextures
#define glDepthFunc glpfDepthFunc
#define glDepthMask glpfDepthMask
#define glDepthRangef glpfDepthRangef
#define glDetachShader glpfDetachShader
#define glDisable glpfDisable
#define glDisableVertexAttribArray glpfDisableVertexAttribArray
#define glDrawArrays glpfDrawArrays
#define glDrawElements glpfDrawElements
#define glEnable glpfEnable
#define glEnableVertexAttribArray glpfEnableVertexAttribArray
#define glFinish glpfFinish
#define glFlush glpfFlush
#define glFramebufferRenderbuffer glpfFramebufferRenderbuffer
#define glFramebufferTexture2D glpfFramebufferTexture2D
#define glFrontFace glpfFrontFace
#define glGenBuffers glpfGenBuffers
#define glGenFramebuffers glpfGenFramebuffers
#define glGenRenderbuffers glpfGenRenderbuffers
#define glGenTextures glpfGenTextures
#define glGenerateMipmap glpfGenerateMipmap
#define glGetActiveAttrib glpfGetActiveAttrib
#define glGetActiveUniform glpfGetActiveUniform
#define glGetAttachedShaders glpfGetAttachedShaders
#define glGetAttribLocation glpfGetAttribLocation
#define glGetBooleanv glpfGetBooleanv
#define glGetBufferParameteriv glpfGetBufferParameteriv
#define glGetError glpfGetError
#define glGetFloatv glpfGetFloatv
#define glGetFramebufferAttachmentParameteriv glpfGetFramebufferAttachmentParameteriv
#define glGetIntegerv glpfGetIntegerv
#define glGetProgramInfoLog glpfGetProgramInfoLog
#define glGetProgramiv glpfGetProgramiv
#define glGetRenderbufferParameteriv glpfGetRenderbufferParameteriv
#define glGetShaderInfoLog glpfGetShaderInfoLog
#define glGetShaderPrecisionFormat glpfGetShaderPrecisionFormat
#define glGetShaderSource glpfGetShaderSource
#define glGetShaderiv glpfGetShaderiv
#define glGetString glpfGetString
#define glGetTexParameterfv glpfGetTexParameterfv
#define glGetTexParameteriv glpfGetTexParameteriv
#define glGetUniformLocation glpfGetUniformLocation
#define glGetUniformfv glpfGetUniformfv
#define glGetUniformiv glpfGetUniformiv
#define glGetVertexAttribPointerv glpfGetVertexAttribPointerv
#define glGetVertexAttribfv glpfGetVertexAttribfv
#define glGetVertexAttribiv glpfGetVertexAttribiv
#define glHint glpfHint
#define glIsBuffer glpfIsBuffer
#define glIsEnabled glpfIsEnabled
#define glIsFramebuffer glpfIsFramebuffer
#define glIsProgram glpfIsProgram
#define glIsRenderbuffer glpfIsRenderbuffer
#define glIsShader glpfIsShader
#define glIsTexture glpfIsTexture
#define glLineWidth glpfLineWidth
#define glLinkProgram glpfLinkProgram
#define glPixelStorei glpfPixelStorei
#define glPolygonOffset glpfPolygonOffset
#define glReadPixels glpfReadPixels
#define glReleaseShaderCompiler glpfReleaseShaderCompiler
#define glRenderbufferStorage glpfRenderbufferStorage
#define glSampleCoverage glpfSampleCoverage
#define glScissor glpfScissor
#define glShaderBinary glpfShaderBinary
#define glShaderSource glpfShaderSource
#define glStencilFunc glpfStencilFunc
#define glStencilFuncSeparate glpfStencilFuncSeparate
#define glStencilMask glpfStencilMask
#define glStencilMaskSeparate glpfStencilMaskSeparate
#define glStencilOp glpfStencilOp
#define glStencilOpSeparate glpfStencilOpSeparate
#define glTexImage2D glpfTexImage2D
#define glTexParameterf glpfTexParameterf
#define glTexParameterfv glpfTexParameterfv
#define glTexParameteri glpfTexParameteri
#define glTexParameteriv glpfTexParameteriv
#define glTexSubImage2D glpfTexSubImage2D
#define glUniform1f glpfUniform1f
#define glUniform1fv glpfUniform1fv
#define glUniform1i glpfUniform1i
#define glUniform1iv glpfUniform1iv
#define glUniform2f glpfUniform2f
#define glUniform2fv glpfUniform2fv
#define glUniform2i glpfUniform2i
#define glUniform2iv glpfUniform2iv
#define glUniform3f glpfUniform3f
#define glUniform3fv glpfUniform3fv
#define glUniform3i glpfUniform3i
#define glUniform3iv glpfUniform3iv
#define glUniform4f glpfUniform4f
#define glUniform4fv glpfUniform4fv
#define glUniform4i glpfUniform4i
#define glUniform4iv glpfUniform4iv
#define glUniformMatrix2fv glpfUniformMatrix2fv
#define glUniformMatrix3fv glpfUniformMatrix3fv
#define glUniformMatrix4fv glpfUniformMatrix4fv
#define glUseProgram glpfUseProgram
#define glValidateProgram glpfValidateProgram
#define glVertexAttrib1f glpfVertexAttrib1f
#define glVertexAttrib1fv glpfVertexAttrib1fv
#define glVertexAttrib2f glpfVertexAttrib2f
#define glVertexAttrib2fv glpfVertexAttrib2fv
#define glVertexAttrib3f glpfVertexAttrib3f
#define glVertexAttrib3fv glpfVertexAttrib3fv
#define glVertexAttrib4f glpfVertexAttrib4f
#define glVertexAttrib4fv glpfVertexAttrib4fv
#define glVertexAttribPointer glpfVertexAttribPointer
#define glViewport glpfViewport


/* --------------------------- CATEGORY DEFINES ------------------------------ */

#define GL_ES_VERSION_2_0

/* ---------------------- Flags for optional extensions ---------------------- */


int flextInit(void);

#define FLEXT_MAJOR_VERSION 2
#define FLEXT_MINOR_VERSION 0
#define FLEXT_CORE_PROFILE 0

#ifdef __cplusplus
}
#endif

#endif /* _gl_h_ */
