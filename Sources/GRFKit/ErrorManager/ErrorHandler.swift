//
//  ErrorHandler.swift
//  GRFKit
//
//  Created by Leon Li on 2023/8/15.
//

class ErrorHandler {
    static let `default` = ErrorHandler()

    func handleError(_ error: Error, errorLevel: ErrorLevel = .warning) {
        print("Error level : \(errorLevel)")
        print(error)
        print("")
    }

    func handleError(_ error: String, errorLevel: ErrorLevel = .warning) {
        print("Error level : \(errorLevel)")
        print(error)
        print("")
    }

    func handleError(error: String, message: String, errorLevel: ErrorLevel = .warning) {
        print("Error level : \(errorLevel)")
        print(message)
        print(error)
        print("")
    }

    func yesNoRequest(message: String, caption: String) -> Bool {
        print("Caption : \(caption)")
        print("Request : \(message)")
        print("Yes or no (Y | N) ? ")
        if let text = readLine(), text.lowercased().hasPrefix("y") {
            print("Answer : Yes")
            print("")
            return true
        }
        print("Answer : No")
        print("")
        return false
    }
}
