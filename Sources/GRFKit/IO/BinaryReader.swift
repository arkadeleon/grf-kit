//
//  BinaryReader.swift
//  GRFKit
//
//  Created by Leon Li on 2023/7/21.
//

import Foundation

class BinaryReader {
    private var stream: Stream

    init(stream: Stream) {
        self.stream = stream
    }

    func close() {
        stream.close()
    }

    func readInt<T: FixedWidthInteger>() throws -> T {
        let data = try stream.read(MemoryLayout<T>.size)
        return data.withUnsafeBytes { $0.load(as: T.self) }
    }

    func readFloat<T: FloatingPoint>() throws -> T {
        let data = try stream.read(MemoryLayout<T>.size)
        return data.withUnsafeBytes { $0.load(as: T.self) }
    }

    func readBytes(_ count: Int) throws -> [UInt8] {
        let data = try stream.read(count)
        return [UInt8](data)
    }

    func readString(_ count: Int, encoding: String.Encoding = .utf8) throws -> String {
        let data = try stream.read(count)
        guard let string = String(data: data, encoding: encoding) else {
            throw StreamError.invalidEncoding
        }
        return string
    }
}
