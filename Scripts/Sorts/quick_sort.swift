/*
	Quick sort (ascending) implementation in swift
*/

import Foundation

/*
	currently not a good way to include other files in interpreted
	swift scripts; this is the same function as in './insertion_sort.swift'
*/
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

func quickSort(filename: String) -> String? {
	let dir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
	let path = URL(fileURLWithPath: filename, relativeTo: dir)

	do {
		let txt = try String(contentsOf: path, encoding: .utf8).trimmingCharacters(in: .newlines)
		var lines = txt.components(separatedBy: .newlines)

		let numLines = lines.count
		let partitionSize = 5 // 5 items per partition
		var currentPart: [String] = []

		repeat {
			let middle = lines[lines.count / 2]
			// first partition
			for i in 0..<lines.count / 2 {
				
			}
			// second partition
			for i in lines.count / 2...<lines.count {

			}
		} while (currentPart.count > partitionSize)

		return lines.joined(separator: "\n");
	} catch {
		print("Unable to read file \(filename), due to: \(error)")
		return nil
	}

}

if let sorted = insertionSort(filename: "raw_data.txt") {
	print(sorted)
}
