import Foundation

let testInput = """
	123 328  51 64
	45 64  387 23
	6 98  215 314
	*   +   *   +
	"""

func VerticalMathResolver(_ input: String) -> Int {
	let parsedInput = input.split(separator: "\n")
	let operators = parsedInput.last!
	var res = 0

	for ope in operators.split(separator: " ").enumerated() {
		guard !ope.element.isEmpty else { continue }
		let numbers = parsedInput.compactMap { Int($0.split(separator: " ")[ope.offset]) }

		switch ope.element {
		case "+":
			res += numbers.reduce(0, +)
		case "*":
			res += numbers.reduce(1, *)
		default:
			continue
		}
	}

	return res
}

print(VerticalMathResolver(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(VerticalMathResolver(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
