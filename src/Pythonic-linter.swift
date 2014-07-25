#!/usr/bin/env xcrun swift -I . -i

import Pythonic

if len(sys.argv) <= 1 {
    println("Usage: Pythonic-linter.swift <file name pattern such as *.swift>")
    sys.exit(0)
}

func countLeadingSpaces(s: String) -> Int {
    for (i, ch) in enumerate(s) {
        if ch != " " {
            return i
        }
    }
    return 0
}

func lintFile(fileName: String) -> Bool {
    var passed = true
    for (lineNumber, originalLine) in enumerate(open(fileName)) {
        var numberOfLeadingSpaces = countLeadingSpaces(originalLine)
        var lineWithoutLeadingSpaces = originalLine[numberOfLeadingSpaces..<len(originalLine)]
        if re.search("\t", originalLine) {
            println("ERROR – Line #\(lineNumber + 1) of \(fileName) contains an raw/unquoted tab (\t):")
            println(originalLine.replace("\t", "\\t") + "\\n")
            passed = false
        } else if numberOfLeadingSpaces % 4 != 0 {
            println("ERROR – Line #\(lineNumber + 1) of \(fileName) has indentation of \(numberOfLeadingSpaces) spaces which is not a multiple of four (4):")
            println(originalLine + "\\n")
            passed = false
        } else if lineWithoutLeadingSpaces != lineWithoutLeadingSpaces.strip() {
            println("ERROR – Line #\(lineNumber + 1) of \(fileName) contains trailing whitespace:")
            println(originalLine + "\\n")
            passed = false
        }
    }
    return passed
}

var hasErrors = false
var fileNames = sys.argv[1..<len(sys.argv)]
for fileName in fileNames {
    if !lintFile(fileName) {
        hasErrors = true
    }
}

if hasErrors {
    sys.exit(-1)
}
