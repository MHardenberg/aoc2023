const std = @import("std");
const utils = @import("../utils.zig");
const digits = [_]u8{ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
const line_break = '\n';

pub fn calibrate() !void {
    std.debug.print("Calibrating...\n", .{});
    const allocator = std.heap.page_allocator;
    const input_string = try utils.readFile("./src/Dec1/input");
    defer allocator.free(input_string);

    var line_buffer: [100]u8 = undefined;
    var digit_buffer: [2]u8 = undefined;
    var line_idx: u8 = 0;
    var digit_idx: u8 = 0;
    var line_sum: u16 = 0;

    for (input_string) |in_char| {
        if (in_char == line_break and digit_idx > 0) {
            var out = try std.fmt.parseInt(u8, &digit_buffer, 10);
            line_sum += out;

            std.debug.print("{s}:    ", .{line_buffer});
            std.debug.print("{}\n", .{out});

            for (0..line_idx) |index| {
                line_buffer[index] = undefined;
            }
            line_idx = 0;
            digit_idx = 0;
        }

        line_buffer[line_idx] = in_char;
        line_idx += 1;

        const is_digit = utils.linSearch(u8, &digits, in_char);
        if (is_digit) {
            digit_buffer[digit_idx] = in_char;
            if (digit_idx == 0) {
                digit_buffer[1] = in_char;
                digit_idx += 1;
            }
        }
    }
    std.debug.print("Sum of lines: {}\n", .{line_sum});
}
