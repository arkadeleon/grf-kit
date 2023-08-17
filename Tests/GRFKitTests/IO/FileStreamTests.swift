//
//  FileStreamTests.swift
//  GRFKitTests
//
//  Created by Leon Li on 2023/8/11.
//

import XCTest
@testable import GRFKit

final class FileStreamTests: XCTestCase {
    func testFileStreamBinaryReader() throws {
        let url = Bundle.module.url(forResource: "Assets/test", withExtension: "grf")!
        let stream = try FileStream(url: url)
        let reader = BinaryReader(stream: stream)

        XCTAssertEqual(try reader.readString(16, encoding: .utf8), "Master of Magic\0")
        XCTAssertEqual(try reader.readBytes(14), [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E])
        XCTAssertEqual(try reader.readInt(), 78684 as UInt32)
        XCTAssertEqual(try reader.readInt(), 0 as UInt32)
        XCTAssertEqual(try reader.readInt(), 16 as UInt32)
        XCTAssertEqual(try reader.readInt(), 0x200 as UInt32)
    }
}
