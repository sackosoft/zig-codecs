const std = @import("std");

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

    const test_library = b.addTest(.{
        .root_module = core_module,
        .target = target,
        .optimize = optimize,
    });
    const run_lib_unit_tests = b.addRunArtifact(test_library);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
