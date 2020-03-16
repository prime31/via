module debug
import via.math
import via.graphics

struct Debug {
mut:
	items []DebugDrawItem
}

//#region Debug Draw Items

union DebugDrawItem {
	kind DebugDrawKind
	pt DebugPoint
	line DebugLine
	rect DebugRect
	circle DebugCircle
	text DebugText
}

enum DebugDrawKind {
	point
	line
	hollow_rect
	hollow_circle
	text
}

struct DebugPoint {
	kind DebugDrawKind
	x f32
	y f32
	size f32
	color math.Color
}

struct DebugLine {
	kind DebugDrawKind
	x1 f32
	y1 f32
	x2 f32
	y2 f32
	thickness f32
	color math.Color
}

struct DebugRect {
	kind DebugDrawKind
	x f32
	y f32
	w f32
	h f32
	thickness f32
	color math.Color
}

struct DebugCircle {
	kind DebugDrawKind
	x f32
	y f32
	r f32
	color math.Color
}

struct DebugText {
	kind DebugDrawKind
	text string
	x f32
	y f32
	color math.Color
}

//#endregion

__global d Debug

pub fn setup() {
	d = Debug{}
	graphics.set_debug_render_fn(render)
}

//#region Drawing

fn add_item(item DebugDrawItem) {
	d.items << item
}

fn render() {
	if d.items.len == 0 { return }
	mut tribatch := graphics.tribatch()
	mut quadbatch := graphics.spritebatch()

	for item in d.items {
		match item.kind {
			.point {
				tribatch.draw_point(item.pt.x, item.pt.y, item.pt.size, item.pt.color)
			}
			.line {
				tribatch.draw_line(item.line.x1, item.line.y1, item.line.x2, item.line.y2, item.line.thickness, item.line.color)
			}
			.hollow_rect {
				tribatch.draw_hollow_rect(item.rect.x, item.rect.y, item.rect.w, item.rect.h, item.rect.thickness, item.rect.color)
			}
			.hollow_circle {
				tribatch.draw_hollow_circle(item.circle.r, 12, {x:item.circle.x y:item.circle.y})
			}
			.text {
				quadbatch.draw_text(item.text.text, {x:item.text.x y:item.text.y color:item.text.color fontbook:0})
				// TODO: why does this panic?
				//unsafe { item.text.text.free() }
			}
			else {}
		}
	}

	mut dd := d
	dd.items.clear()
	graphics.flush()
}

pub fn draw_point(x, y, size f32, color math.Color) {
	add_item(DebugDrawItem(DebugPoint{DebugDrawKind.point, x, y, size, color}))
}

pub fn draw_line(x1, y1, x2, y2, thickness f32, color math.Color) {
	add_item(DebugDrawItem(DebugLine{DebugDrawKind.line, x1, y1, x2, y2, thickness, color}))
}

pub fn draw_linev(pt1, pt2 math.Vec2, thickness f32, color math.Color) {
	add_item(DebugDrawItem(DebugLine{DebugDrawKind.line, pt1.x, pt1.y, pt2.x, pt2.y, thickness, color}))
}

pub fn draw_hollow_rect(x, y, width, height, thickness f32, color math.Color) {
	add_item(DebugDrawItem(DebugRect{DebugDrawKind.hollow_rect, x, y, width, height, thickness, color}))
}

pub fn draw_hollow_circle(x, y, radius f32, color math.Color) {
	add_item(DebugDrawItem(DebugCircle{DebugDrawKind.hollow_circle, x, y, radius, color}))
}

pub fn draw_hollow_circlev(pos math.Vec2, radius f32, color math.Color) {
	add_item(DebugDrawItem(DebugCircle{DebugDrawKind.hollow_circle, pos.x, pos.y, radius, color}))
}

pub fn draw_text(text string, x, y int, color math.Color) {
	add_item(DebugDrawItem(DebugText{DebugDrawKind.text, text, x, y, color}))
}

//#endregion

//#region Logging

pub fn info(msg string) {
	print('\x1b[100m \x1b[49m ')
	println(msg)
}

pub fn log(msg string) {
	print('\x1b[42m \x1b[49m ')
	println(msg)
}

pub fn warn(msg string) {
	print('\x1b[43m \x1b[49m ')
	println(msg)
}

pub fn error(msg string) {
	print('\x1b[41m \x1b[49m ')
	println(msg)
}

//#endregion