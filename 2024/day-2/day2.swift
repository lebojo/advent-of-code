import Foundation

let fileContent = try! String(contentsOfFile: "./input2", encoding: .utf8)
let lines = fileContent.split(separator: "\n")

var safeLines = 0

lines.forEach { line in
    let report = line.split(separator: " ").compactMap { Int($0) }
    guard report.count >= 2 else { return }

    if isSafe(report) {
        safeLines += 1
    } else {
        for i in 0 ..< report.count {
            if isSafe(report, skip: i) {
                safeLines += 1
                break
            }
        }
    }
}

func isSafe(_ report: [Int], skip: Int = -1) -> Bool {
	var report_copy = report
	if skip >= 0 {
		report_copy.remove(at: skip)
	}

    let isIncrement = report_copy[0] < report_copy[1]

    for i in 0..<report_copy.count {

        let diff = abs(report_copy[i] - report_copy[i > 0 ? i - 1 : i + 1])

        if diff > 3 
            || diff < 1 
            || (i > 0 && ((isIncrement && report_copy[i] < report_copy[i - 1]) 
                || (!isIncrement && report_copy[i] > report_copy[i - 1]))) {
            break
        }
        if i == report_copy.count - 1 {
            return true
        }
    }
    return false
}

print("There's \(safeLines) safe lines.")