//
//  EndpointType.swift
//  SearchFMWipro
//
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation

protocol EndpointType {

    var baseURL: URL { get }

    var path: String { get }

}
