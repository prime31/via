module math

pub struct Color {
pub mut:
    value u32 = u32(0xffffffff)
}

pub fn (c Color) str() string { return '${c.r()} ${c.g()} ${c.b()} ${c.a()}' }

pub fn (a Color) eq(b Color) bool { return a.value == b.value }

pub fn color_from_bytes(r byte, g byte, b byte, a byte) Color {
    return Color{(r) | (g << 8) | (b << 16) | (a << 24)}
}

pub fn rgb(r f32, g f32, b f32) Color {
    return color_from_bytes(byte(int(r * 255)), byte(int(g * 255)), byte(int(b * 255)), byte(255))
}

pub fn rgba(r f32, g f32, b f32, a f32) Color {
    return color_from_bytes(byte(int(r * 255)), byte(int(g * 255)), byte(int(b * 255)), byte(int(a * 255)))
}

pub fn color_from_ints(r int, g int, b int, a int) Color {
    return color_from_bytes(byte(r), byte(g), byte(b), byte(a))
}

pub fn (c Color) r() byte {
	return byte(c.value)
}

pub fn (c Color) g() byte {
	return byte(c.value >> 8)
}

pub fn (c Color) b() byte {
	return byte(c.value >> 16)
}

pub fn (c Color) a() byte {
	return byte(c.value >> 24)
}

pub fn (c Color) r_f() f32 {
	return f32(c.r()) / 255
}

pub fn (c Color) g_f() f32 {
	return f32(c.g()) / 255
}

pub fn (c Color) b_f() f32 {
	return f32(c.b()) / 255
}

pub fn (c Color) a_f() f32 {
	return f32(c.a()) / 255
}

pub fn (mut c Color) set_r(r byte) {
	c.value = (c.value & 0xffffff00) | r
}

pub fn (mut c Color) set_g(g byte) {
	c.value = (c.value & 0xffff00ff) | g << 8
}

pub fn (mut c Color) set_b(b byte) {
	c.value = (c.value & 0xff00ffff) | b << 16
}

pub fn (mut c Color) set_a(a byte) {
	c.value = (c.value & 0x00ffffff) | a << 24
}

pub fn (c Color) mul(scale f32) Color {
	r := int(f32(c.r()) * scale)
	g := int(f32(c.g()) * scale)
	b := int(f32(c.b()) * scale)
	a := int(f32(c.a()) * scale)
	return color_from_ints(r, g, b, a)
}

pub fn alice_blue() Color { return Color{0xfffff8f0} }
pub fn antique_white() Color { return Color{0xffd7ebfa} }
pub fn aqua() Color { return Color{0xffffff00} }
pub fn aquamarine() Color { return Color{0xffd4ff7f} }
pub fn azure() Color { return Color{0xfffffff0} }
pub fn beige() Color { return Color{0xffdcf5f5} }
pub fn bisque() Color { return Color{0xffc4e4ff} }
pub fn black() Color { return Color{0xff000000} }
pub fn blanched_almond() Color { return Color{0xffcdebff} }
pub fn blue() Color { return Color{0xffff0000} }
pub fn blue_violet() Color { return Color{0xffe22b8a} }
pub fn brown() Color { return Color{0xff2a2aa5} }
pub fn burly_wood() Color { return Color{0xff87b8de} }
pub fn cadet_blue() Color { return Color{0xffa09e5f} }
pub fn chartreuse() Color { return Color{0xff00ff7f} }
pub fn chocolate() Color { return Color{0xff1e69d2} }
pub fn coral() Color { return Color{0xff507fff} }
pub fn cornflower_blue() Color { return Color{0xffed9564} }
pub fn cornsilk() Color { return Color{0xffdcf8ff} }
pub fn crimson() Color { return Color{0xff3c14dc} }
pub fn cyan() Color { return Color{0xffffff00} }
pub fn dark_blue() Color { return Color{0xff8b0000} }
pub fn dark_cyan() Color { return Color{0xff8b8b00} }
pub fn dark_goldenrod() Color { return Color{0xff0b86b8} }
pub fn dark_gray() Color { return Color{0xffa9a9a9} }
pub fn dark_green() Color { return Color{0xff006400} }
pub fn dark_khaki() Color { return Color{0xff6bb7bd} }
pub fn dark_magenta() Color { return Color{0xff8b008b} }
pub fn dark_olive_green() Color { return Color{0xff2f6b55} }
pub fn dark_orange() Color { return Color{0xff008cff} }
pub fn dark_orchid() Color { return Color{0xffcc3299} }
pub fn dark_red() Color { return Color{0xff00008b} }
pub fn dark_salmon() Color { return Color{0xff7a96e9} }
pub fn dark_sea_green() Color { return Color{0xff8bbc8f} }
pub fn dark_slate_blue() Color { return Color{0xff8b3d48} }
pub fn dark_slate_gray() Color { return Color{0xff4f4f2f} }
pub fn dark_turquoise() Color { return Color{0xffd1ce00} }
pub fn dark_violet() Color { return Color{0xffd30094} }
pub fn deep_pink() Color { return Color{0xff9314ff} }
pub fn deep_sky_blue() Color { return Color{0xffffbf00} }
pub fn dim_gray() Color { return Color{0xff696969} }
pub fn dodger_blue() Color { return Color{0xffff901e} }
pub fn firebrick() Color { return Color{0xff2222b2} }
pub fn floral_white() Color { return Color{0xfff0faff} }
pub fn forest_green() Color { return Color{0xff228b22} }
pub fn fuchsia() Color { return Color{0xffff00ff} }
pub fn gainsboro() Color { return Color{0xffdcdcdc} }
pub fn ghost_white() Color { return Color{0xfffff8f8} }
pub fn gold() Color { return Color{0xff00d7ff} }
pub fn goldenrod() Color { return Color{0xff20a5da} }
pub fn gray() Color { return Color{0xff808080} }
pub fn green() Color { return Color{0xff008000} }
pub fn green_yellow() Color { return Color{0xff2fffad} }
pub fn honeydew() Color { return Color{0xfff0fff0} }
pub fn hot_pink() Color { return Color{0xffb469ff} }
pub fn indian_red() Color { return Color{0xff5c5ccd} }
pub fn indigo() Color { return Color{0xff82004b} }
pub fn ivory() Color { return Color{0xfff0ffff} }
pub fn khaki() Color { return Color{0xff8ce6f0} }
pub fn lavender() Color { return Color{0xfffae6e6} }
pub fn lavender_blush() Color { return Color{0xfff5f0ff} }
pub fn lawn_green() Color { return Color{0xff00fc7c} }
pub fn lemon_chiffon() Color { return Color{0xffcdfaff} }
pub fn light_blue() Color { return Color{0xffe6d8ad} }
pub fn light_coral() Color { return Color{0xff8080f0} }
pub fn light_cyan() Color { return Color{0xffffffe0} }
pub fn light_goldenrod_yellow() Color { return Color{0xffd2fafa} }
pub fn light_gray() Color { return Color{0xffd3d3d3} }
pub fn light_green() Color { return Color{0xff90ee90} }
pub fn light_pink() Color { return Color{0xffc1b6ff} }
pub fn light_salmon() Color { return Color{0xff7aa0ff} }
pub fn light_sea_green() Color { return Color{0xffaab220} }
pub fn light_sky_blue() Color { return Color{0xffface87} }
pub fn light_slate_gray() Color { return Color{0xff998877} }
pub fn light_steel_blue() Color { return Color{0xffdec4b0} }
pub fn light_yellow() Color { return Color{0xffe0ffff} }
pub fn lime() Color { return Color{0xff00ff00} }
pub fn lime_green() Color { return Color{0xff32cd32} }
pub fn linen() Color { return Color{0xffe6f0fa} }
pub fn magenta() Color { return Color{0xffff00ff} }
pub fn maroon() Color { return Color{0xff000080} }
pub fn medium_aquamarine() Color { return Color{0xffaacd66} }
pub fn medium_blue() Color { return Color{0xffcd0000} }
pub fn medium_orchid() Color { return Color{0xffd355ba} }
pub fn medium_purple() Color { return Color{0xffdb7093} }
pub fn medium_sea_green() Color { return Color{0xff71b33c} }
pub fn medium_slate_blue() Color { return Color{0xffee687b} }
pub fn medium_spring_green() Color { return Color{0xff9afa00} }
pub fn medium_turquoise() Color { return Color{0xffccd148} }
pub fn medium_violet_red() Color { return Color{0xff8515c7} }
pub fn midnight_blue() Color { return Color{0xff701919} }
pub fn mint_cream() Color { return Color{0xfffafff5} }
pub fn misty_rose() Color { return Color{0xffe1e4ff} }
pub fn moccasin() Color { return Color{0xffb5e4ff} }
pub fn mono_game_orange() Color { return Color{0xff003ce7} }
pub fn navajo_white() Color { return Color{0xffaddeff} }
pub fn navy() Color { return Color{0xff800000} }
pub fn old_lace() Color { return Color{0xffe6f5fd} }
pub fn olive() Color { return Color{0xff008080} }
pub fn olive_drab() Color { return Color{0xff238e6b} }
pub fn orange() Color { return Color{0xff00a5ff} }
pub fn orange_red() Color { return Color{0xff0045ff} }
pub fn orchid() Color { return Color{0xffd670da} }
pub fn pale_goldenrod() Color { return Color{0xffaae8ee} }
pub fn pale_green() Color { return Color{0xff98fb98} }
pub fn pale_turquoise() Color { return Color{0xffeeeeaf} }
pub fn pale_violet_red() Color { return Color{0xff9370db} }
pub fn papaya_whip() Color { return Color{0xffd5efff} }
pub fn peach_puff() Color { return Color{0xffb9daff} }
pub fn peru() Color { return Color{0xff3f85cd} }
pub fn pink() Color { return Color{0xffcbc0ff} }
pub fn plum() Color { return Color{0xffdda0dd} }
pub fn powder_blue() Color { return Color{0xffe6e0b0} }
pub fn purple() Color { return Color{0xff800080} }
pub fn red() Color { return Color{0xff0000ff} }
pub fn rosy_brown() Color { return Color{0xff8f8fbc} }
pub fn royal_blue() Color { return Color{0xffe16941} }
pub fn saddle_brown() Color { return Color{0xff13458b} }
pub fn salmon() Color { return Color{0xff7280fa} }
pub fn sandy_brown() Color { return Color{0xff60a4f4} }
pub fn sea_green() Color { return Color{0xff578b2e} }
pub fn sea_shell() Color { return Color{0xffeef5ff} }
pub fn sienna() Color { return Color{0xff2d52a0} }
pub fn silver() Color { return Color{0xffc0c0c0} }
pub fn sky_blue() Color { return Color{0xffebce87} }
pub fn slate_blue() Color { return Color{0xffcd5a6a} }
pub fn slate_gray() Color { return Color{0xff908070} }
pub fn snow() Color { return Color{0xfffafaff} }
pub fn spring_green() Color { return Color{0xff7fff00} }
pub fn steel_blue() Color { return Color{0xffb48246} }
pub fn teal() Color { return Color{0xff808000} }
pub fn thistle() Color { return Color{0xffd8bfd8} }
pub fn tomato() Color { return Color{0xff4763ff} }
pub fn turquoise() Color { return Color{0xffd0e040} }
pub fn violet() Color { return Color{0xffee82ee} }
pub fn wheat() Color { return Color{0xffb3def5} }
pub fn white() Color { return Color{} }
pub fn white_smoke() Color { return Color{0xfff5f5f5} }
pub fn yellow() Color { return Color{0xff00ffff} }
pub fn yellow_green() Color { return Color{0xff32cd9a} }