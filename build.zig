const std = @import("std");

const Encoder = struct {
    name: []const u8,
    path: []const u8,
    module: ?*std.Build.Module,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const core_module = b.createModule(.{
        .root_source_file = b.path("src/codecs.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib_encoders = b.addLibrary(.{
        .name = "zig-codecs",
        .linkage = .static,
        .root_module = core_module,
    });
    b.installArtifact(lib_encoders);
}
