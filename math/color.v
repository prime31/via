module math

pub struct Color {
pub mut:
    value u32 = u32(0xffffffff)
}

pub fn (c Color) str() string { return '${c.r()} ${c.g()} ${c.b()} ${c.a()}' }

pub fn (a Color) eq(b Color) bool { return a.value == b.value }

fn (c Color) r() byte {
	return byte(c.value)
}

fn (c Color) g() byte {
	return byte(c.value >> 8)
}

fn (c Color) b() byte {
	return byte(c.value >> 16)
}

fn (c Color) a() byte {
	return byte(c.value >> 24)
}

fn (c mut Color) set_r(r byte) {
	c.value = (c.value & 0xffffff00) | r
}

fn (c mut Color) set_g(g byte) {
	c.value = (c.value & 0xffff00ff) | g << 8
}

fn (c mut Color) set_b(b byte) {
	c.value = (c.value & 0xff00ffff) | b << 16
}

fn (c mut Color) set_a(a byte) {
	c.value = (c.value & 0x00ffffff) | a << 24
}

fn color_from_bytes(r byte, g byte, b byte, a byte) Color {
    return Color{(r) | (g << 8) | (b << 16) | (a << 24)}
}

fn color_from_floats(r f32, g f32, b f32, a f32) Color {
    return color_from_bytes(byte(r * 255), byte(g * 255), byte(b * 255), byte(a * 255))
}

fn color_from_ints(r int, g int, b int, a int) Color {
    return color_from_bytes(byte(r), byte(g), byte(b), byte(a))
}

pub fn (c Color) scale(scale f32) Color {
	r := int(f32(c.r()) * scale)
	g := int(f32(c.g()) * scale)
	b := int(f32(c.b()) * scale)
	a := int(f32(c.a()) * scale)
	return color_from_ints(r, g, b, a)
}

pub fn color_alice_blue() Color { return Color{0xfffff8f0} }
pub fn color_antique_white() Color { return Color{0xffd7ebfa} }
pub fn color_aqua() Color { return Color{0xffffff00} }
pub fn color_aquamarine() Color { return Color{0xffd4ff7f} }
pub fn color_azure() Color { return Color{0xfffffff0} }
pub fn color_beige() Color { return Color{0xffdcf5f5} }
pub fn color_bisque() Color { return Color{0xffc4e4ff} }
pub fn color_black() Color { return Color{0xff000000} }
pub fn color_blanched_almond() Color { return Color{0xffcdebff} }
pub fn color_blue() Color { return Color{0xffff0000} }
pub fn color_blue_violet() Color { return Color{0xffe22b8a} }
pub fn color_brown() Color { return Color{0xff2a2aa5} }
pub fn color_burly_wood() Color { return Color{0xff87b8de} }
pub fn color_cadet_blue() Color { return Color{0xffa09e5f} }
pub fn color_chartreuse() Color { return Color{0xff00ff7f} }
pub fn color_chocolate() Color { return Color{0xff1e69d2} }
pub fn color_coral() Color { return Color{0xff507fff} }
pub fn color_cornflower_blue() Color { return Color{0xffed9564} }
pub fn color_cornsilk() Color { return Color{0xffdcf8ff} }
pub fn color_crimson() Color { return Color{0xff3c14dc} }
pub fn color_cyan() Color { return Color{0xffffff00} }
pub fn color_dark_blue() Color { return Color{0xff8b0000} }
pub fn color_dark_cyan() Color { return Color{0xff8b8b00} }
pub fn color_dark_goldenrod() Color { return Color{0xff0b86b8} }
pub fn color_dark_gray() Color { return Color{0xffa9a9a9} }
pub fn color_dark_green() Color { return Color{0xff006400} }
pub fn color_dark_khaki() Color { return Color{0xff6bb7bd} }
pub fn color_dark_magenta() Color { return Color{0xff8b008b} }
pub fn color_dark_olive_green() Color { return Color{0xff2f6b55} }
pub fn color_dark_orange() Color { return Color{0xff008cff} }
pub fn color_dark_orchid() Color { return Color{0xffcc3299} }
pub fn color_dark_red() Color { return Color{0xff00008b} }
pub fn color_dark_salmon() Color { return Color{0xff7a96e9} }
pub fn color_dark_sea_green() Color { return Color{0xff8bbc8f} }
pub fn color_dark_slate_blue() Color { return Color{0xff8b3d48} }
pub fn color_dark_slate_gray() Color { return Color{0xff4f4f2f} }
pub fn color_dark_turquoise() Color { return Color{0xffd1ce00} }
pub fn color_dark_violet() Color { return Color{0xffd30094} }
pub fn color_deep_pink() Color { return Color{0xff9314ff} }
pub fn color_deep_sky_blue() Color { return Color{0xffffbf00} }
pub fn color_dim_gray() Color { return Color{0xff696969} }
pub fn color_dodger_blue() Color { return Color{0xffff901e} }
pub fn color_firebrick() Color { return Color{0xff2222b2} }
pub fn color_floral_white() Color { return Color{0xfff0faff} }
pub fn color_forest_green() Color { return Color{0xff228b22} }
pub fn color_fuchsia() Color { return Color{0xffff00ff} }
pub fn color_gainsboro() Color { return Color{0xffdcdcdc} }
pub fn color_ghost_white() Color { return Color{0xfffff8f8} }
pub fn color_gold() Color { return Color{0xff00d7ff} }
pub fn color_goldenrod() Color { return Color{0xff20a5da} }
pub fn color_gray() Color { return Color{0xff808080} }
pub fn color_green() Color { return Color{0xff008000} }
pub fn color_green_yellow() Color { return Color{0xff2fffad} }
pub fn color_honeydew() Color { return Color{0xfff0fff0} }
pub fn color_hot_pink() Color { return Color{0xffb469ff} }
pub fn color_indian_red() Color { return Color{0xff5c5ccd} }
pub fn color_indigo() Color { return Color{0xff82004b} }
pub fn color_ivory() Color { return Color{0xfff0ffff} }
pub fn color_khaki() Color { return Color{0xff8ce6f0} }
pub fn color_lavender() Color { return Color{0xfffae6e6} }
pub fn color_lavender_blush() Color { return Color{0xfff5f0ff} }
pub fn color_lawn_green() Color { return Color{0xff00fc7c} }
pub fn color_lemon_chiffon() Color { return Color{0xffcdfaff} }
pub fn color_light_blue() Color { return Color{0xffe6d8ad} }
pub fn color_light_coral() Color { return Color{0xff8080f0} }
pub fn color_light_cyan() Color { return Color{0xffffffe0} }
pub fn color_light_goldenrod_yellow() Color { return Color{0xffd2fafa} }
pub fn color_light_gray() Color { return Color{0xffd3d3d3} }
pub fn color_light_green() Color { return Color{0xff90ee90} }
pub fn color_light_pink() Color { return Color{0xffc1b6ff} }
pub fn color_light_salmon() Color { return Color{0xff7aa0ff} }
pub fn color_light_sea_green() Color { return Color{0xffaab220} }
pub fn color_light_sky_blue() Color { return Color{0xffface87} }
pub fn color_light_slate_gray() Color { return Color{0xff998877} }
pub fn color_light_steel_blue() Color { return Color{0xffdec4b0} }
pub fn color_light_yellow() Color { return Color{0xffe0ffff} }
pub fn color_lime() Color { return Color{0xff00ff00} }
pub fn color_lime_green() Color { return Color{0xff32cd32} }
pub fn color_linen() Color { return Color{0xffe6f0fa} }
pub fn color_magenta() Color { return Color{0xffff00ff} }
pub fn color_maroon() Color { return Color{0xff000080} }
pub fn color_medium_aquamarine() Color { return Color{0xffaacd66} }
pub fn color_medium_blue() Color { return Color{0xffcd0000} }
pub fn color_medium_orchid() Color { return Color{0xffd355ba} }
pub fn color_medium_purple() Color { return Color{0xffdb7093} }
pub fn color_medium_sea_green() Color { return Color{0xff71b33c} }
pub fn color_medium_slate_blue() Color { return Color{0xffee687b} }
pub fn color_medium_spring_green() Color { return Color{0xff9afa00} }
pub fn color_medium_turquoise() Color { return Color{0xffccd148} }
pub fn color_medium_violet_red() Color { return Color{0xff8515c7} }
pub fn color_midnight_blue() Color { return Color{0xff701919} }
pub fn color_mint_cream() Color { return Color{0xfffafff5} }
pub fn color_misty_rose() Color { return Color{0xffe1e4ff} }
pub fn color_moccasin() Color { return Color{0xffb5e4ff} }
pub fn color_mono_game_orange() Color { return Color{0xff003ce7} }
pub fn color_navajo_white() Color { return Color{0xffaddeff} }
pub fn color_navy() Color { return Color{0xff800000} }
pub fn color_old_lace() Color { return Color{0xffe6f5fd} }
pub fn color_olive() Color { return Color{0xff008080} }
pub fn color_olive_drab() Color { return Color{0xff238e6b} }
pub fn color_orange() Color { return Color{0xff00a5ff} }
pub fn color_orange_red() Color { return Color{0xff0045ff} }
pub fn color_orchid() Color { return Color{0xffd670da} }
pub fn color_pale_goldenrod() Color { return Color{0xffaae8ee} }
pub fn color_pale_green() Color { return Color{0xff98fb98} }
pub fn color_pale_turquoise() Color { return Color{0xffeeeeaf} }
pub fn color_pale_violet_red() Color { return Color{0xff9370db} }
pub fn color_papaya_whip() Color { return Color{0xffd5efff} }
pub fn color_peach_puff() Color { return Color{0xffb9daff} }
pub fn color_peru() Color { return Color{0xff3f85cd} }
pub fn color_pink() Color { return Color{0xffcbc0ff} }
pub fn color_plum() Color { return Color{0xffdda0dd} }
pub fn color_powder_blue() Color { return Color{0xffe6e0b0} }
pub fn color_purple() Color { return Color{0xff800080} }
pub fn color_red() Color { return Color{0xff0000ff} }
pub fn color_rosy_brown() Color { return Color{0xff8f8fbc} }
pub fn color_royal_blue() Color { return Color{0xffe16941} }
pub fn color_saddle_brown() Color { return Color{0xff13458b} }
pub fn color_salmon() Color { return Color{0xff7280fa} }
pub fn color_sandy_brown() Color { return Color{0xff60a4f4} }
pub fn color_sea_green() Color { return Color{0xff578b2e} }
pub fn color_sea_shell() Color { return Color{0xffeef5ff} }
pub fn color_sienna() Color { return Color{0xff2d52a0} }
pub fn color_silver() Color { return Color{0xffc0c0c0} }
pub fn color_sky_blue() Color { return Color{0xffebce87} }
pub fn color_slate_blue() Color { return Color{0xffcd5a6a} }
pub fn color_slate_gray() Color { return Color{0xff908070} }
pub fn color_snow() Color { return Color{0xfffafaff} }
pub fn color_spring_green() Color { return Color{0xff7fff00} }
pub fn color_steel_blue() Color { return Color{0xffb48246} }
pub fn color_tan() Color { return Color{0xff8cb4d2} }
pub fn color_teal() Color { return Color{0xff808000} }
pub fn color_thistle() Color { return Color{0xffd8bfd8} }
pub fn color_tomato() Color { return Color{0xff4763ff} }
pub fn color_turquoise() Color { return Color{0xffd0e040} }
pub fn color_violet() Color { return Color{0xffee82ee} }
pub fn color_wheat() Color { return Color{0xffb3def5} }
pub fn color_white() Color { return Color{} }
pub fn color_white_smoke() Color { return Color{0xfff5f5f5} }
pub fn color_yellow() Color { return Color{0xff00ffff} }
pub fn color_yellow_green() Color { return Color{0xff32cd9a} }