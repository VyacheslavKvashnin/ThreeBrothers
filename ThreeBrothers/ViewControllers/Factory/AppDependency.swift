//
//  AppDependency.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 11.06.2022.
//

import Foundation

struct AppDependency: DataManagerProtocol, AuthManagerProtocol {
    var databaseServices: DatabaseServices
    var authManager: AuthManager
}
