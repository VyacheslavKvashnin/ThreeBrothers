//
//  AppDependency.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 11.06.2022.
//

import Foundation

struct AppDependency: DataManagerProtocol, AuthManagerProtocol {
    let databaseServices: DatabaseServices
    let authManager: AuthManager
}
