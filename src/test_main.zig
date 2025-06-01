// This file serves as the main entry point for 'zig build test'.
// Import all Zig files from the 'src' directory that contain 'test' blocks
// to ensure they are included in the test run.

// Import the main library file, which should bring in its dependencies' tests too
// (e.g., tests in src/codecs.zig and src/encoders/plain.zig).
_ = @import("codecs.zig");

// Add other direct imports here if they contain tests and are not covered by the above.
// For example, if you have files in src/utils/ or src/decoders/ with tests:
// _ = @import("utils/some_utility.zig");
// _ = @import("decoders/some_decoder.zig");

// It's good practice to ensure all files intended for testing are imported here.
