<div align="center">

# zig-bitops

**High-performance encoding algorithms.**

A comprehensive collection of encoding and compression algorithms for Zig. Useful, among other things, for implementing
columnar storage formats.

![GitHub License](https://img.shields.io/github/license/sackosoft/zig-bitops)

<!--
TODO: Capture attention with a visualization, diagram, demo or other visual placeholder here.
![Placeholder]()
-->

</div>

## Overview

`zig-bitops` provides production-ready implementations of encoding algorithms commonly used in data serialization and to
improve results from applying compression. The library emphasizes correctness, performance, and usability for developers
building data-intensive applications.

### Supported Encodings

- **Plain Encoding** - Direct little-endian storage for all primitive types
- **Dictionary Encoding** - Value deduplication with RLE/bit-packed indices  
- **RLE/Bit-Packing Hybrid** - Efficient storage of repeated and sparse values
- **Delta Binary Packed** - Compressed integer sequences using delta compression
- **Delta Length Byte Array** - Optimized variable-length byte array storage
- **Delta Byte Array** - Incremental/front compression for string data
- **Byte Stream Split** - Improved compression for floating-point data

### Design Goals

- **Zero-copy operations** where possible
- **Memory-efficient** streaming interfaces
- **Comprehensive test coverage** including edge cases and fuzzing
- **Clear API documentation** with usage examples
- **Performance benchmarks** against reference implementations

## Quick Start

```zig
const std = @import("std");
const bitops = @import("zig-bitops");

// Plain encoding example
var buffer: [1024]u8 = undefined;
var encoder = bitops.PlainEncoder.init(&buffer);

const values = [_]i32{ 42, 1337, -123, 0 };
try encoder.encodeInt32Slice(&values);

// Delta encoding example  
var delta_encoder = bitops.DeltaBinaryPackedEncoder.init(
    std.testing.allocator,
    128, // block size
    4,   // miniblocks per block
);
defer delta_encoder.deinit();

const deltas = [_]i64{ 100, 102, 105, 109, 114, 120 };
try delta_encoder.encode(&deltas);
```

## Project Structure

```
zig-bitops/
├── src/
│   ├── encoders/           # Encoding implementations
│   ├── decoders/           # Decoding implementations
│   ├── utils/              # Shared utilities (varint, bit-packing, etc.)
│   └── root.zig            # Public API
├── tests/                  # Unit and integration tests
├── benchmarks/             # Performance benchmarks
├── examples/               # Usage examples
└── docs/                   # Additional documentation
```

<!--

## Development

### Prerequisites

- Zig 0.14.0 or later

### Building and Testing

Compile and test all implementations.

```bash
zig build test
```

### Testing

The project includes comprehensive test coverage:

- **Unit tests** for individual encoding/decoding functions
- **Round-trip tests** to verify encoder/decoder compatibility  
- **Edge case tests** for boundary conditions and error handling
- **Fuzzing tests** for robustness validation

```bash
# Run all tests
zig build test

# Run tests with coverage
zig build test-coverage
```

## Contributing

Contributions are welcome. This project aims to be a comprehensive reference implementation of encoding algorithms used in modern data systems.

Areas for contribution:
- Additional encoding algorithms (LZ4, Snappy integration, etc.)
- Performance optimizations and SIMD implementations
- Extended test coverage and fuzzing
- Documentation improvements and examples
- Benchmarking against other implementations

### Code Style

- Follow Zig's standard formatting (`zig fmt`)
- Comprehensive error handling with meaningful error types
- Document public APIs with doc comments
- Include usage examples for complex functions

## Performance

Benchmarks are included comparing against reference implementations. Run `zig build bench` to measure performance on your hardware.

Performance characteristics vary by data type and distribution. Delta encoding excels with sequential data, while dictionary encoding works best with repeated values.
-->

## License

The algorithms, tests and other artifacts in `zig-bitops` are licensed under the MIT License:

```
Copyright (c) 2025 Theodore Sackos

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```