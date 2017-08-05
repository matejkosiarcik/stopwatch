//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import CommandLineKit
import Result

public struct Arguments {
    // 0th implicit argument
    let path: String

    // actual logical arguments
    let help: Bool
    let version: Bool

    // if we would want to use parser's usage later
    let usage: String
}

extension Arguments {
    var executableFileName: String {
        let parts = self.path.split(separator: "/")
        guard !parts.isEmpty else { return "" }
        return String(parts[parts.count - 1])
    }
}

extension Arguments {
    static func new(from arguments: [String]) -> Result<Arguments, Arguments.Error> {
        let helpOption = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Display help message")
        let versionOption = BoolOption(shortFlag: "V", longFlag: "version", helpMessage: "Display program version")

        let parser = CommandLineKit.CommandLine(arguments: arguments)
        parser.addOptions(helpOption, versionOption)

        do {
            try parser.parse(strict: true)
            return .success(Arguments(path: arguments[0], help: helpOption.value,
                                      version: versionOption.value, usage: parser.usage))
        } catch let error as CommandLineKit.CommandLine.ParseError {
            let description = error.description + "\n" + error.localizedDescription + "\n\n" + parser.usage
            return .failure(Arguments.Error.passed(description))
        } catch {
            let description = error.localizedDescription + "\n\n" + parser.usage
            return .failure(Arguments.Error.passed(description))
        }
    }
}

extension Arguments: Equatable {
    public static func == (lhs: Arguments, rhs: Arguments) -> Bool {
        return lhs.path == rhs.path && lhs.help == rhs.help && lhs.version == rhs.version
    }
}

extension Arguments {
    public enum Error: Swift.Error {
        case passed(String)
    }
}

extension Arguments.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case .passed(let x): return x
        }
    }
}
