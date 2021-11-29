//
//  NotImplemented.swift
//  Faces
//
//  Created by Tom Rochat on 31/10/2021.
//

import Foundation

/// Indicates that a function has not been implemented, triggering a fatal error with an optional reason
///
/// - Parameter message: An optional reason why the function is not implemented
func notImplemented(
    _ message: String = "",
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line
) -> Never {
    let reason = message.isEmpty ? "" : ": \(message)"
    fatalError("\(function) has not been implemented\(reason)", file: file, line: line)
}
