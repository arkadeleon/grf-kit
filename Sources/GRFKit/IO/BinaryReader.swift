//
//  BinaryReader.swift
//  GRFKit
//
//  Created by Leon Li on 2023/7/21.
//

class BinaryReader {
    let stream: Stream

    init(stream: Stream) {
        self.stream = stream
    }

    func close() {
        stream.close()
    }

    func readInt<T: FixedWidthInteger>() throws -> T {
        let count = MemoryLayout<T>.size
        var result: T = 0
        try withUnsafeMutablePointer(to: &result) { pointer in
            _ = try stream.read(pointer, count: count)
        }
        return result
    }

    func readFloat<T: FloatingPoint>() throws -> T {
        let count = MemoryLayout<T>.size
        var result: T = 0
        try withUnsafeMutablePointer(to: &result) { pointer in
            _ = try stream.read(pointer, count: count)
        }
        return result
    }

    func readBytes(_ count: Int) throws -> [UInt8] {
        var bytes = [UInt8](repeating: 0, count: count)
        try bytes.withUnsafeMutableBytes { pointer in
            _ = try stream.read(pointer.baseAddress!, count: count)
        }
        return bytes
    }

    func readString(_ count: Int, encoding: String.Encoding) throws -> String {
        let bytes = try readBytes(count)
        guard let string = String(bytes: bytes, encoding: encoding) else {
            throw StreamError.invalidEncoding
        }
        return string
    }
}
