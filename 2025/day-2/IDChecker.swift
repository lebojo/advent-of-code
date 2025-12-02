import Foundation

let testInput =
	"11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

func wrongIdsCombinated(_ input: String) -> Int {
	let split = input.split(separator: ",")
	var total = 0

	for range in split {
		let splittedRange = range.split(separator: "-")
		guard splittedRange.count == 2 else { continue }

		let firstId = Int(splittedRange.first!)!
		let lastId = Int(splittedRange.last!)!

		for testedId in firstId...lastId {
			let size = String(testedId).count
			guard size % 2 == 0 else { continue }

			let stringId = String(testedId)
			if stringId.dropFirst(size / 2) == stringId.dropLast(size / 2) {
				total += Int(stringId) ?? 0
			}
		}
	}
	return total
}

print(wrongIdsCombinated(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(wrongIdsCombinated(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
