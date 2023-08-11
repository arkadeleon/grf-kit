//
//  BinaryWriter.swift
//  GRFKit
//
//  Created by Leon Li on 2023/7/21.
//

import Foundation

class BinaryWriter {
    private var stream: Stream

    init(stream: Stream) {
        self.stream = stream
    }

    func close() {
        stream.close()
    }

    func write<T: FixedWidthInteger>(_ value: T) {
        var value = value
        let data = withUnsafeBytes(of: &value) { Data($0) }
        stream.write(data)
    }

    func write<T: FloatingPoint>(_ value: T) {
        var value = value
        let data = withUnsafeBytes(of: &value) { Data($0) }
        stream.write(data)
    }

    func write(_ value: [UInt8]) {
        let data = Data(value)
        stream.write(data)
    }

    func write(_ value: String, encoding: String.Encoding = .utf8) throws {
        guard let data = value.data(using: encoding) else {
            throw StreamError.invalidEncoding
        }
        stream.write(data)
    }
}
