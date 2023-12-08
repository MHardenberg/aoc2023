const std = @import("std");
const utils = @import("../utils.zig");

pub fn calibrate() !void {
    std.debug.print("Calibrating...\n", .{});
    const input_string = try utils.readFile("./src/Dec1/input");

    std.debug.print("Input {s}\n", .{input_string});
}
