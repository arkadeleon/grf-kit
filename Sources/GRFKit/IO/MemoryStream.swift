//
//  MemoryStream.swift
//  GRFKit
//
//  Created by Leon Li on 2023/7/21.
//

import Foundation

class MemoryStream: Stream {
    fileprivate var storage: UnsafeMutableRawPointer
    private var capacity: Int

    private(set) var length: Int
    private(set) var position: Int

    init() {
        storage = malloc(0)
        capacity = 0
        length = 0
        position = 0
    }

    init(data: Data) {
        storage = malloc(data.count)
        capacity = data.count
        length = data.count
        position = 0

        data.withUnsafeBytes { pointer in
            let target = UnsafeMutableRawBufferPointer(start: storage, count: pointer.count)
            target.copyMemory(from: pointer)
        }
    }

    deinit {
        free(storage)
    }

    func close() {
    }

    func seek(_ offset: Int, origin: SeekOrigin) throws {
        switch origin {
        case .begin:
            guard offset < length else {
                throw StreamError.bufferUnderflow
            }
            position = offset
        case .current:
            guard position + offset < length else {
                throw StreamError.bufferUnderflow
            }
            position += offset
        case .end:
            guard offset == 0 else {
                throw StreamError.bufferUnderflow
            }
            position = length - 1
        }
    }

    func read(_ buffer: UnsafeMutableRawPointer, count: Int) throws -> Int {
        guard position + count <= length else {
            throw StreamError.bufferUnderflow
        }

        buffer.copyMemory(from: storage.advanced(by: position), byteCount: count)

        position += count

        return count
    }

    func write(_ buffer: UnsafeRawPointer, count: Int) throws -> Int {
        length += count
        storage = realloc(storage, length)

        storage.advanced(by: position).copyMemory(from: buffer, byteCount: count)

        position += count

        return count
    }
}

extension Data {
    init(stream: MemoryStream) {
        self = Data(bytes: stream.storage, count: stream.length)
    }
}
