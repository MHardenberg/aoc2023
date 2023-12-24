const std = @import("std");
const utils = @import("../utils.zig");
const allocator = std.heap.page_allocator;

pub fn parse_game_num(game_str: []const u8) !?u8 {
    if (game_str.len == 0) {
        return null;
    }
    const num_str = game_str[5..];
    return try std.fmt.parseUnsigned(u8, num_str, 10);
}

pub fn parse_set(set_str: []const u8) ![3]u8 {
    const Colour = enum { red, green, blue };
    var c_map = std.AutoHashMap(u8, u8).init(allocator);
    try c_map.put('r', @intFromEnum(Colour.red));
    try c_map.put('g', @intFromEnum(Colour.green));
    try c_map.put('b', @intFromEnum(Colour.blue));

    var out = [3]u8{ 0, 0, 0 };
    var figures: u8 = 0;
    var num_buf: [3]u8 = undefined;
    var cubes_iter = std.mem.splitScalar(u8, set_str, ',');

    while (cubes_iter.next()) |cubes| {
        for (0.., cubes) |i, char| {
            if (!std.ascii.isDigit(char)) {
                if (figures > 0) {
                    // this indicated that we have parse the number of cubes
                    // and that we now need to determine their colour by
                    // moving one more character

                    const c: u8 = cubes[i + 1];
                    const c_idx = c_map.get(c);
                    if (c_idx) |idx| {
                        const c_num = try std.fmt.parseInt(u8, num_buf[0..figures], 10);
                        out[idx] = c_num;
                        figures = 0;
                        continue;
                    }
                }
                continue;
            }

            num_buf[figures] = char;
            figures += 1;
        }
    }
    return out;
}

pub fn possible_games() !void {
    std.debug.print("Checking games...\n", .{});
    const input = try utils.readFile("./src/Dec2/input");
    defer allocator.free(input);

    var game_num: ?u8 = undefined;
    var iterator = std.mem.splitScalar(u8, input, '\n');
    while (iterator.next()) |line| {
        var game_iter = std.mem.splitScalar(u8, line, ':');

        // get game number
        var game_str = game_iter.next();
        if (game_str) |gs| {
            game_num = try parse_game_num(gs);
            if (game_num) |gn| {
                std.debug.print("\n{s}\n\tGame number: {}\n", .{ line, gn });
            }
        } else {
            continue; // if no game number
        }

        // split into sets
        const sets = game_iter.next();
        if (sets) |s| {
            var set_iter = std.mem.splitScalar(u8, s, ';');
            while (set_iter.next()) |set| {
                const cubes = try parse_set(set);
                std.debug.print("\tSet: {s}\n\t\t-> rgb Cubes : {any}\n", .{ set, cubes });
            }
        }
    }
}
