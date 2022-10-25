//
//  View+Extension.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 24/03/2022.
//

import Foundation
import SwiftUI

extension View {
    func embedNavigationView() -> some View {
        return NavigationView { self }
    } 
}
