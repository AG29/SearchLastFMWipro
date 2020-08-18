//
//  MockData.swift
//  SearchFMWiproTests
//
//  Created by Apple on 17/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation
@testable import SearchFMWipro

enum MockData: String {
    case happy = "happy"
    
    func jsonData() -> [Artist] {
        
        print( "\(self.rawValue)_dataset")
        
        guard let bundle = Bundle(identifier: "com.ag.SearchFMWipro"),
            let url = bundle.url(forResource: "\(self.rawValue)_dataset", withExtension: "json")
            else { return []}
        
        guard let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe) else { return []}
        
        guard let jsonResult = try? JSONDecoder().decode(ArtistSearch.self, from: jsonData) else { return [] }
        
        return jsonResult.results.artistmatches.artist
    }
    
    static func questionResultModel(for mock: MockData) -> [Artist] {
        let mockData = mock.jsonData()
        return mockData
    }
}
