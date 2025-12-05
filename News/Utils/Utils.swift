//
//  Utils.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case success(T)
    case failure(Error)
}
