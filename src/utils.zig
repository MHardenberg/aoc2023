const std = @import("std");

pub fn getCWD() ![]const u8 {
    var buf: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const cwd = try std.os.getcwd(&buf);
    return cwd;
}

pub fn readFile(file_path: []const u8) ![]const u8 {
    const allocator = std.heap.page_allocator;
    const max_bytes = std.math.maxInt(usize);

    var data = try std.fs.cwd().readFileAlloc(allocator, file_path, max_bytes);
    defer allocator.free(data);

    return data;
}
