const std = @import("std");

pub fn linSearch(comptime T: type, haystack: []const T, needle: T) bool {
    for (haystack) |thing| {
        if (thing == needle) {
            return true;
        }
    }
    return false;
}

pub fn getCWD() ![]const u8 {
    var buf: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const cwd = try std.os.getcwd(&buf);
    return cwd;
}

// hands ownership to caller
pub fn readFile(file_path: []const u8) ![]const u8 {
    const allocator = std.heap.page_allocator;
    const max_bytes = std.math.maxInt(usize);

    var data = try std.fs.cwd().readFileAlloc(allocator, file_path, max_bytes);

    return data;
}
