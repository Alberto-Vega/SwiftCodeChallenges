import Foundation
import UIKit

public func assertEqual(_ actual: String, _ expected: String) -> String {
	let result = actual == expected ? "✅" : "⛔️ \"\(actual)\" does not match the expected value of \"\(expected)\""
	return result
}

public enum Assertion: CustomPlaygroundQuickLookable {
	case success
	case failure(actual: String, expected: String)
	
	public init(actual: String, expected: String) {
		if actual == expected {
			self = .success
		} else {
			print("⛔️ \"\(actual)\" != \"\(expected)\"")
			self = .failure(actual: actual, expected: expected)
		}
	}
	public var customPlaygroundQuickLook: PlaygroundQuickLook {
		switch self {
		case .success:
			return .attributedString(NSAttributedString(string: "✅ Success!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 30)]))
		case .failure(let actual, let expected):
			return .attributedString(failureMessage(actual: actual, expected: expected))
		}
	}

	func failureMessage(actual: String, expected: String) -> NSAttributedString {
		let labelAttributes = [NSFontAttributeName : UIFont.italicSystemFont(ofSize: 12),
		                       NSForegroundColorAttributeName : UIColor.lightGray]
		let contentAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16)]//(name: "Menlo-Regular", size: 16)]
		let result = NSMutableAttributedString(string: "⛔️", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 30)])
		result.append(NSAttributedString(string: "\nactual:\n", attributes: labelAttributes))
		result.append(NSAttributedString(string: actual, attributes: contentAttributes))
		result.append(NSAttributedString(string: "\nexpected:\n", attributes: labelAttributes))
		result.append(NSAttributedString(string: expected, attributes: contentAttributes))
		return result
	}
}



func assert(_ actual: String, _ expected: String) -> NSAttributedString {
	if actual == expected {
		return NSAttributedString(string: "✅ Success!")
	} else {
		print("⛔️ \"\(actual)\" != \"\(expected)\"")
		let labelAttributes = [NSFontAttributeName : UIFont.italicSystemFont(ofSize: 12),
		                       NSForegroundColorAttributeName : UIColor.lightGray]
		let contentAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16)]//(name: "Menlo-Regular", size: 16)]
		let result = NSMutableAttributedString(string: "⛔️\n")
		result.append(NSAttributedString(string: "actual:\n", attributes: labelAttributes))
		result.append(NSAttributedString(string: actual, attributes: contentAttributes))
		result.append(NSAttributedString(string: "\nexpected:\n", attributes: labelAttributes))
		result.append(NSAttributedString(string: expected, attributes: contentAttributes))
		return result
	}
}
