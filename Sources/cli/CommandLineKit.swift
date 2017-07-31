//
// CommandLineKit.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import CommandLineKit

extension CommandLineKit.CommandLine {
    var usage: String {
        var usage = ""
        self.printUsage(&usage)
        return usage
    }
}
