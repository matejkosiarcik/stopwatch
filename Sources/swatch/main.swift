//
// main.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation
import StopWatch

// setup unbuffered standard input
setbuf(stdin, nil)
setvbuf(stdin, nil, _IONBF, 0)
var input = termios()
tcgetattr(STDIN_FILENO, &input)
input.c_lflag = tcflag_t(Int32(input.c_lflag) & ~ICANON)
tcsetattr(STDIN_FILENO, TCSANOW, &input)

func readCharacter(from file: FileHandle) -> Character? {
    let data = file.readData(ofLength: 1)
    let string = String(data: data, encoding: .ascii)
    return string?.characters.first
}

func demo() {
    let str = readCharacter(from: .standardInput).map { String($0) } ?? ""
    print("\r", terminator: "")
    switch str {
    case "\n": print("newline")
    case " ": print("space")
    case "a": print("A it is.")
    default: break
    }
}

while true {
    demo()
}
