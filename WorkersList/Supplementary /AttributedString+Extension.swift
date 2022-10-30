//
//  AttributedString+Extension.swift
//  WorkersList
//
//  Created by Людмила Долонтаева on 31.10.2022.
//

import Foundation
import UIKit

@available(iOS 15, *)
extension AttributedString {
    var nsAttributedString: NSAttributedString{
        return NSAttributedString(self)
    }
}
