const std = @import("std");
const Dec1 = @import("Dec1/trebuchet.zig");
const Dec2 = @import("Dec2/cubes.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Running AoC 2023 solutions ...\n", .{});
    //try Dec1.calibrate();
    try Dec2.possible_games();
}
