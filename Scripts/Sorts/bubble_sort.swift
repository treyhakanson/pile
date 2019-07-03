/*
  Bubble sort (ascending) implementation in swift
*/

import Foundation

func bubbleSort(filename: String) -> String? {
  let dir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
  let path = URL(fileURLWithPath: filename, relativeTo: dir)
  
  do {
    let txt = try String(contentsOf: path, encoding: .utf8).trimmingCharacters(in: .newlines)
    var lines = txt.components(separatedBy: .newlines)
    
    for _ in 0..<lines.count - 1 {
      var swapped = false

      for j in 0..<lines.count - 1 {

        if lines[j] > lines[j + 1] {
          let tmp = lines[j + 1]
          lines[j + 1] = lines[j]
          lines[j] = tmp
          swapped = true
        }

      }

      if !swapped {
        break;
      }

    }

    return lines.joined(separator: "\n")
  } catch {
    print("Unable to read from \(filename), due to:\n\(error)")
    return nil
  }

}

if let sorted = bubbleSort(filename: "raw_data.txt") {
  print(sorted)
}
