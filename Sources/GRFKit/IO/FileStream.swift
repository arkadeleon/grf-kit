//
//  FileStream.swift
//  GRFKit
//
//  Created by Leon Li on 2023/8/2.
//

import Foundation

class FileStream: Stream {
    private let file: UnsafeMutablePointer<FILE>

    private(set) var length: Int

    var position: Int {
        ftell(file)
    }

    init(url: URL) throws {
        file = fopen(url.path.cString(using: .utf8), "rw+")
        length = (try FileManager.default.attributesOfItem(atPath: url.path)[.size] as? Int) ?? 0
    }

    func close() {
        fclose(file)
    }

    func seek(_ offset: Int, origin: SeekOrigin) throws {
        fseek(file, offset, origin.rawValue)
    }

    func read(_ buffer: UnsafeMutableRawPointer, count: Int) throws -> Int {
        return fread(buffer, 1, count, file)
    }

    func write(_ buffer: UnsafeRawPointer, count: Int) throws -> Int {
        return fwrite(buffer, 1, count, file)
    }
}
