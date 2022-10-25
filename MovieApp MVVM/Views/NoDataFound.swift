//
//  NoDataFound.swift
//  MovieApp MVVM
//
//  Created by NaheedPK on 25/03/2022.
//

import SwiftUI

struct NoDataFound: View {
    var body: some View {
        Image("oops")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct NoDataFound_Previews: PreviewProvider {
    static var previews: some View {
        NoDataFound()
    }
}
