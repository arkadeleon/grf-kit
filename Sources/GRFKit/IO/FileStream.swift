//
//  FileStream.swift
//  GRFKit
//
//  Created by Leon Li on 2023/8/2.
//

import Foundation

class FileStream: Stream {
    private let _fileHandle: FileHandle

    private var _length: Int

    init(url: URL) throws {
        _fileHandle = try FileHandle(forUpdating: url)
        _length = (try FileManager.default.attributesOfItem(atPath: url.path)[.size] as? Int) ?? 0
    }

    var length: Int {
        _length
    }

    var position: Int {
        let offset = try? _fileHandle.offset()
        return Int(offset ?? 0)
    }

    func close() {
        do {
            try _fileHandle.close()
        } catch {
            print(error)
        }
    }

    func seek(_ offset: Int, origin: StreamSeekOrigin) throws {
        try _fileHandle.seek(toOffset: UInt64(offset))
    }

    func read(_ count: Int) throws -> Data {
        guard let data = try _fileHandle.read(upToCount: count) else {
            throw StreamError.endOfStream
        }
        return data
    }

    func write<T>(_ data: T) where T : DataProtocol {
        do {
            try _fileHandle.write(contentsOf: data)
        } catch {
            print(error)
        }
    }
}
