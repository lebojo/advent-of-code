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
			guard size > 1 else { continue }

			let stringId = String(testedId)
			var divider = 1
			//print(testedId)
			while divider < stringId.count {
				let splitted = stringId.chunks(size: divider)
				guard splitted.count > 1 else { break }

				if Set(splitted).count == 1 {
					total += testedId
					break
				}
				divider += 1
			}
		}
	}
	return total
}

//print(wrongIdsCombinated(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(wrongIdsCombinated(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}

extension String {
	func chunks(size: Int) -> [String] {
		guard size > 0 else { return [] }
		return stride(from: 0, to: count, by: size).map {
			let start = index(startIndex, offsetBy: $0)
			let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
			return String(self[start..<end])
		}
	}
}
