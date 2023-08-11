//
//  MemoryStream.swift
//  GRFKit
//
//  Created by Leon Li on 2023/7/21.
//

import Foundation

class MemoryStream: Stream {
    fileprivate var _buffer: UnsafeMutableRawPointer
    private var _capacity: Int

    private var _length: Int
    private var _position: Int

    init() {
        _buffer = malloc(0)
        _capacity = 0
        _length = 0
        _position = 0
    }

    init(data: Data) {
        _buffer = malloc(data.count)
        _capacity = data.count
        _length = data.count
        _position = 0

        data.withUnsafeBytes { pointer in
            let target = UnsafeMutableRawBufferPointer(start: _buffer, count: pointer.count)
            target.copyMemory(from: pointer)
        }
    }

    deinit {
        free(_buffer)
    }

    var length: Int {
        _length
    }

    var position: Int {
        _position
    }

    func close() {
    }

    func seek(_ offset: Int, origin: StreamSeekOrigin) throws {
        switch origin {
        case .begin:
            guard offset < _length else {
                throw StreamError.bufferUnderflow
            }
            _position = offset
        case .current:
            guard _position + offset < _length else {
                throw StreamError.bufferUnderflow
            }
            _position += offset
        case .end:
            guard offset == 0 else {
                throw StreamError.bufferUnderflow
            }
            _position = _length - 1
        }
    }

    func read(_ count: Int) throws -> Data {
        guard _position + count <= _length else {
            throw StreamError.bufferUnderflow
        }

        let data = Data(bytes: _buffer.advanced(by: _position), count: count)

        _position += count

        return data
    }

    func write<T>(_ data: T) where T : DataProtocol {
        _length += data.count
        _buffer = realloc(_buffer, _length)

        let target = UnsafeMutableRawBufferPointer(start: _buffer.advanced(by: _position), count: data.count)
        data.copyBytes(to: target)

        _position += data.count
    }
}

extension Data {
    init(stream: MemoryStream) {
        self = Data(bytes: stream._buffer, count: stream.length)
    }
}
