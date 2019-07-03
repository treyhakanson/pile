/*
  Insertion sort (ascending) implementation in swift
*/

import Foundation

func insertionSort(filename: String) -> String? {
  let dir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
  let path = URL(fileURLWithPath: filename, relativeTo: dir)

  do {
    let txt = try String(contentsOf: path, encoding: .utf8).trimmingCharacters(in: .newlines)
    var lines = txt.components(separatedBy: .newlines)

    for i in 0..<lines.count {

      for j in 0..<i {

        if lines[j] > lines[i] {
          let tmp = lines[j]
          lines[j] = lines[i]
          lines[i] = tmp
        }

      }

    }

    return lines.joined(separator: "\n")
  } catch {
    print("Unable to read from \(filename), due to:\n\(error)")
    return nil
  }

}

if let sorted = insertionSort(filename: "raw_data.txt") {
  print(sorted)
}
