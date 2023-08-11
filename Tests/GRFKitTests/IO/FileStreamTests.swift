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

        XCTAssertEqual(try reader.readString(15), "Master of Magic")
        XCTAssertEqual(try reader.readString(15).count, 15)
        XCTAssertEqual(try reader.readInt(), 78684 as UInt32)
        XCTAssertEqual(try reader.readInt(), 0 as UInt32)
        XCTAssertEqual(try reader.readInt(), 16 as UInt32)
        XCTAssertEqual(try reader.readInt(), 0x200 as UInt32)
    }
}
