//
//  HomeModel.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 12/07/2021.
//

import Foundation

struct Post: Codable {
    let userId : Int
    let id     : Int
    let title  : String?
    let body   : String?
}
