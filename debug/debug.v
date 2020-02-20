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
}

enum DebugDrawKind {
	point
	line
	hollow_rect
	hollow_circle
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

//#endregion

const (
	d = &Debug{}
)

pub fn setup() {
	graphics.set_debug_render_fn(render)
}

//#region Drawing

fn add_item(item DebugDrawItem) {
	mut dd := d
	dd.items << item
}

fn render() {
	if d.items.len == 0 { return }
	mut tribatch := graphics.tribatch()

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
				tribatch.draw_hollow_circle(item.circle.r, 10, {x:item.circle.x y:item.circle.y})
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

pub fn draw_hollow_rect(x, y, width, height, thickness f32, color math.Color) {
	add_item(DebugDrawItem(DebugRect{DebugDrawKind.hollow_rect, x, y, width, height, thickness, color}))
}

pub fn draw_hollow_circle(x, y, radius f32, color math.Color) {
	add_item(DebugDrawItem(DebugCircle{DebugDrawKind.hollow_circle, x, y, radius, color}))
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