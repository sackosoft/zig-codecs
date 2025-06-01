const std = @import("std");

pub fn Encoder(comptime T: type) type {
    return struct {
        const Self = @This();

        pub fn encode(self: *@This(), writer: std.io.AnyWriter, values: []?T) !void {
            _ = self;
            _ = writer;
            _ = values;
        }
    };
}

test "Plain encoder writes integers in sequence" {
    // Arrange
    var buf: [8]u32 = undefined;
    var fbs = std.io.fixedBufferStream(@as(*u8, @ptrCast(&buf)));
    const writer = fbs.writer();
    const encoder: Encoder(u32) = .{};
    const given = &[_]u32{ 1, 2, 3 };

    // Act
    try encoder.encode(writer, given);

    // Assert
    for (given, 0..) |expected, i| {
        const actual = std.mem.nativeToLittle(u32, buf[i]);
        try std.testing.expectEqual(expected, actual);
    }
}
