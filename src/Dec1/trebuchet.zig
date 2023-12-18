const std = @import("std");
const utils = @import("../utils.zig");
const digits = [_]u8{ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
const line_break = '\n';

pub fn calibrate() !void {
    std.debug.print("Calibrating...\n", .{});

    const input_string = try utils.readFile("./src/Dec1/input");

    var in_digits: [2]u8 = undefined;
    var current_idx: u8 = 0;
    var line_sum: u16 = 0;

    for (input_string) |in_char| {
        if (in_char == line_break) {
            var out = try std.fmt.parseInt(u8, &in_digits, 10);
            line_sum += out;
            current_idx = 0;
        }

        const is_digit = utils.linSearch(u8, &digits, in_char);
        if (is_digit) {
            in_digits[current_idx] = in_char;
            if (current_idx == 0) {
                current_idx += 1;
            }
        }
    }

    std.debug.print("Sum of lines: {}\n", .{line_sum});
    const allocator = std.heap.page_allocator;
    defer allocator.free(input_string);
}
