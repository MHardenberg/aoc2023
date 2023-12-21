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
                std.debug.print("Game number: {}\n", .{gn});
            }
        } else {
            continue; // if no game number
        }

        // split into sets
        const sets = game_iter.next();
        var set_iter = std.mem.splitScalar(u8, sets, ';');
        while (set_iter.next()) |set| {
            var cubes_iter = std.men.splitScalar(u8, set, ',');
            while (cubes_iter.next()) |cubes| {
                for (cubes) |char| {
                    // add all digits to buffer until space
                    // then check the next char for r,g,b
                    // assign to map
                    if (!std.ascii.isDigit(char)) {
                        continue;
                    }
                }
            }
        }
    }
}
