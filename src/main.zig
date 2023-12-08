const std = @import("std");
const Dec1 = @import("Dec1/trebuchet.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Running AoC 2023 solutions ...\n", .{});
    try Dec1.calibrate();
}
