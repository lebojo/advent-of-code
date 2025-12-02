import Foundation

var first_res = 0
var second_res = 0

let fileContent = try! String(contentsOfFile: "./input", encoding: .utf8)

let elements = fileContent.components(separatedBy: CharacterSet(charactersIn: "\n "))
							.compactMap { Int($0) }
							.enumerated()

let left = elements.filter { $0.offset % 2 == 0 }.map { $0.element }.sorted()
let right = elements.filter { $0.offset % 2 != 0 }.map { $0.element }.sorted()

left.enumerated().forEach { (i, element) in
	first_res += abs(element - right[i])
	second_res += right.filter { $0 == element }.count * element
}

print("First part answer: \(first_res), second part answer: \(second_res)")
