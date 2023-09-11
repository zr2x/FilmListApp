//
//  NetworkConstant.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import Foundation

final class NetworkConstant {
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
    }
    
    public var apiKey: String {
        get {
            return "55fe2ffd83d14bd4820bf58ddc7ba856"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}
