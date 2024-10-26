//
//  File.swift
//  
//
//  Created by David on 10/26/24.
//

import Foundation
import SwiftUI

@available(iOS 16.0.0, *)
public struct CustomDialogPackage {
    public static func customDialog(nameImage: String, nameColor: Color, title: String, subtitle: String, actionNo: @escaping () -> Void, actionYes: @escaping () -> Void ){
        ReactangleWithCurvedTopView(nameImage: nameImage, nameColor: nameColor, title: title, subtitle: subtitle, actionNo: actionNo, actionYes: actionYes)
    }
}

