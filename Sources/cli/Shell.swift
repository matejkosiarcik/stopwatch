//
// Shell.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

@discardableResult
public func shell(_ command: String) -> Int32 {
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c"] + [command]
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
