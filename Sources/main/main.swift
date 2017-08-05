//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import cli
import Foundation

var helperOutput = ""
let result = Program.new(for: CommandLine.arguments).map { $0.main(output: &helperOutput) }
helperOutput = helperOutput.trimmingCharacters(in: .whitespacesAndNewlines)
switch result {
case .success(let exitCode):
    if helperOutput != "" { print(helperOutput) }
    exit(exitCode)
case .failure(let error):
    print(error.description)
    exit(1)
}
