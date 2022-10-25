//
//  ViewModalBase.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 25/03/2022.
//

import Foundation

enum LoadingState {
    case loading, success, failed, none
}

class ViewModalBase: ObservableObject {
    @Published var loadingStates: LoadingState = .none
}


