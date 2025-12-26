import Foundation

func VerticalMathResolver(_ input: String) -> Int {
	let parsedInput = input.split(separator: "\n")
	let startIndex = parsedInput.first!.count - 1
	var res = 0
	var actualOperation: [Int] = []

	for i in stride(from: startIndex, through: 0, by: -1) {
		var number = ""
		var sign: Character?

		for line in parsedInput {
			let lastIndex = Array(line)[i]
			guard lastIndex.isNumber else {
				if lastIndex == "*" || lastIndex == "+" {
					sign = lastIndex
				}
				continue
			}
			number.append(lastIndex)
		}

		if let opeSign = sign, let num = Int(number) {
			actualOperation.append(num)
			switch opeSign {
			case "+":
				sign = nil
				res += actualOperation.reduce(0, +)
				actualOperation = []
			case "*":
				sign = nil
				res += actualOperation.reduce(1, *)
				actualOperation = []
			default:
				sign = nil
				actualOperation = []
				continue
			}
		} else if let num = Int(number) {
			actualOperation.append(num)
		}
	}

	return res
}

do {
	let testInput = try String(contentsOfFile: "testInput", encoding: .utf8)
	print("Test: \(VerticalMathResolver(testInput))")
} catch {
	print("error decoding file")
	fatalError()
}

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(VerticalMathResolver(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
