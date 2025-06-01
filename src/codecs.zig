const std = @import("std");

pub const plain = @import("encoders/plain.zig");

test "should pass" {
    // Add a reference to the submodules to prevent tree shaking them away.
    _ = plain;

    try std.testing.expect(true);
}
