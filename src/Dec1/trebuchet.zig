const std = @import("std");
const utils = @import("../utils.zig");
const allocator = std.heap.page_allocator;

pub fn calibrate() !void {
    std.debug.print("Calibrating...\n", .{});
    const input = try utils.readFile("./src/Dec1/input");
    defer allocator.free(input);

    var result: u16 = 0;
    var iterator = std.mem.splitScalar(u8, input, '\n');

    while (iterator.next()) |line| {
        if (line.len == 0) {
            continue;
        }

        var first_digit: ?u8 = null;
        var second_digit: ?u8 = null;

        for (line) |char| {
            if (!std.ascii.isDigit(char)) {
                continue;
            }

            if (first_digit == null) {
                first_digit = char;
            } else {
                second_digit = char;
            }
        }

        if (first_digit) |first| {
            const number_str = [2]u8{ first, second_digit orelse first };
            const parseResult = try std.fmt.parseUnsigned(u8, &number_str, 10);
            result += parseResult;
        }
    }
    std.debug.print("results: {}\n", .{result});
}
