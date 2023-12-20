const std = @import("std");
const utils = @import("../utils.zig");
const allocator = std.heap.page_allocator;

pub fn calibrate() !void {
    var map = std.StringHashMap(u8).init(
        allocator,
    );

    try map.put("zero", '0');
    try map.put("one", '1');
    try map.put("two", '2');
    try map.put("three", '3');
    try map.put("four", '4');
    try map.put("five", '5');
    try map.put("six", '6');
    try map.put("seven", '7');
    try map.put("eight", '8');
    try map.put("nine", '9');

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

        for (0.., line) |i, char| {
            var value: ?u8 = null;
            // check for numeric digit
            if (std.ascii.isDigit(char)) {
                value = char;
            } else { // check for spelled digit
                var word_buff: [5]u8 = undefined;
                for (0..5) |j| {
                    if (i + j == line.len) {
                        break;
                    }
                    word_buff[j] = line[i + j];
                }

                // all spelling are 3, 4 or 5 chars long
                for (3..6) |k| {
                    value = map.get(word_buff[0..k]);
                    if (value) |v| {
                        std.debug.print("{s}\t: {s} val = {}\n", .{ line, word_buff, v });
                        break;
                    }
                }
            }

            if (value) |v| {
                if (first_digit == null) {
                    first_digit = @as(u8, v);
                } else {
                    second_digit = @as(u8, v);
                }
            }
        }

        if (first_digit) |first| {
            var number_str: [2]u8 = undefined;
            if (second_digit) |second| {
                number_str = [2]u8{ first, second };
            } else {
                number_str = [2]u8{ first, first };
            }

            const parse_result = try std.fmt.parseUnsigned(u8, &number_str, 10);
            std.debug.print("nstr {any} -> {}\n\n", .{ number_str, parse_result });
            result += parse_result;
        }
    }
    std.debug.print("results: {}\n", .{result});
}
