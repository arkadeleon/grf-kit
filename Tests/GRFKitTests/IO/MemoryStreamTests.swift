//
//  MemoryStreamTests.swift
//  GRFKitTests
//
//  Created by Leon Li on 2023/7/21.
//

import XCTest
@testable import GRFKit

final class MemoryStreamTests: XCTestCase {
    func testMemoryStreamBinaryReader() throws {
        var data = Data([0x00, 0x11, 0x22, 0x33])
        data += Data([0x01, 0x02, 0x03, 0x04])
        data += "ABCD".data(using: .utf8)!

        let stream = MemoryStream(data: data)
        let reader = BinaryReader(stream: stream)

        XCTAssertEqual(stream.length, 12)
        XCTAssertEqual(try reader.readInt(), 0x00 as UInt8)
        XCTAssertEqual(try reader.readInt(), 0x11 as UInt8)
        XCTAssertEqual(try reader.readInt(), 0x22 as UInt8)
        XCTAssertEqual(try reader.readInt(), 0x33 as UInt8)
        XCTAssertEqual(try reader.readBytes(4), [0x01, 0x02, 0x03, 0x04])
        XCTAssertEqual(try reader.readString(4, encoding: .utf8), "ABCD")
    }

    func testMemoryStreamBinaryWriter() throws {
        let stream = MemoryStream()
        let writer = BinaryWriter(stream: stream)

        try writer.write(0x00 as UInt8)
        try writer.write(0x11 as UInt8)
        try writer.write(0x22 as UInt8)
        try writer.write(0x33 as UInt8)
        try writer.write([0x01, 0x02, 0x03, 0x04])
        try writer.write("ABCD", encoding: .utf8)

        let data = Data(stream: stream)
        XCTAssertEqual(data.count, 12)
        XCTAssertEqual(data[0], 0x00)
        XCTAssertEqual(data[1], 0x11)
        XCTAssertEqual(data[2], 0x22)
        XCTAssertEqual(data[3], 0x33)
        XCTAssertEqual(data[4..<8], Data([0x01, 0x02, 0x03, 0x04]))
        XCTAssertEqual(data[8..<12], "ABCD".data(using: .utf8))
    }
}
