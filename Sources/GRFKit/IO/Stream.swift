//
//  Stream.swift
//  GRFKit
//
//  Created by Leon Li on 2023/7/21.
//

import Foundation

enum StreamError: Error {
    case bufferUnderflow
    case endOfStream
    case invalidEncoding
}

enum StreamSeekOrigin {
    case begin
    case current
    case end
}

protocol Stream {
    var length: Int { get }
    var position: Int { get }

    func close()

    func seek(_ offset: Int, origin: StreamSeekOrigin) throws

    func read(_ count: Int) throws -> Data
    func write<T>(_ data: T) where T : DataProtocol
}
