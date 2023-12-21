const std = @import("std");
const utils = @import("../utils.zig");
const allocator = std.heap.page_allocator;

pub fn parse_game_num(line: []const u8) !?u8 {
    var line_iter = std.mem.splitScalar(u8, line, ':');
    const game = line_iter.next();
    if (game) |g| {
        if (g.len == 0) {
            return null;
        }
        const num_str = g[5..];
        return try std.fmt.parseUnsigned(u8, num_str, 10);
    }
    return null;
}

pub fn possible_games() !void {
    std.debug.print("Checking games...\n", .{});
    const input = try utils.readFile("./src/Dec2/input");
    defer allocator.free(input);

    var game_num: ?u8 = undefined;
    var iterator = std.mem.splitScalar(u8, input, '\n');
    while (iterator.next()) |line| {
        game_num = try parse_game_num(line);
        if (game_num) |num| {
            std.debug.print("Game number: {}\n", .{num});
            var line_iter = std.fmt.parseInt(u8, line);
            _ = line_iter;
            // discard game num
        }
    }
}
