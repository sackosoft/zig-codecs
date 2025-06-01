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
    @memset(&buf, 0);
    var fbs = std.io.fixedBufferStream(@as([*]u8, @ptrCast(&buf))[0 .. 8 * 8]);
    const writer = fbs.writer().any();
    var given = [_]?u32{ 1, 2, 3 };
    var encoder: Encoder(u32) = .{};

    // Act
    try encoder.encode(writer, &given);

    // Assert
    try std.testing.expect(false);
    for (0..given.len) |i| {
        std.debug.print("JKLAJDLASJLD\n", .{});
        const expected = given[i];
        const actual = std.mem.nativeToLittle(u32, buf[i]);
        try std.testing.expectEqual(expected, actual);
    }
}
