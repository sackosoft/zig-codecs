const std = @import("std");
const builtin = @import("builtin");

const native_endian = builtin.cpu.arch.endian();

pub fn Encoder(comptime T: type) type {
    return struct {
        const Self = @This();

        pub fn encode(self: *Self, writer: std.io.AnyWriter, values: []T) !void {
            _ = self;

            for (values) |v| {
                const little = std.mem.nativeToLittle(T, v);
                const bytes = std.mem.asBytes(&little);
                try writer.writeAll(bytes);
            }
        }
    };
}

test "Plain encoder writes integers in sequence" {
    // Arrange
    var buf: [8]u32 = undefined;
    @memset(&buf, 0);
    var fbs = std.io.fixedBufferStream(@as([*]u8, @ptrCast(&buf))[0 .. 8 * 8]);
    const writer = fbs.writer().any();
    var given = [_]u32{ 1, 2, 3 };
    var encoder: Encoder(u32) = .{};

    // Act
    try encoder.encode(writer, &given);

    // Assert
    for (0..given.len) |i| {
        const expected = given[i];
        const actual = std.mem.nativeToLittle(u32, buf[i]);
        try std.testing.expectEqual(expected, actual);
    }
}
