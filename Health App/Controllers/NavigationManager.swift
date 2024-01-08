//
//  NavigationManager.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import Foundation
import SwiftUI

class NavigationManager:ObservableObject {
    
    @Published var path:NavigationPath = NavigationPath()
    @Published var presentConfirmation:Bool = false
    @Published var showNixFoods:Bool = true
}
