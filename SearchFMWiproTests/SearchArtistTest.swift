//
//  SearchArtistTest.swift
//  SearchFMWiproTests
//
//  Created by Apple on 17/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import XCTest
@testable import SearchFMWipro

class SearchArtistTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- Happy Dataset
    func testSerialization_happy() {
        let resultModel  = MockData.questionResultModel(for: .happy)
        XCTAssertNotNil(resultModel)
    }
    
    func testResultModel_happy () {
        let resultModel  = MockData.questionResultModel(for: .happy)
        let artist = resultModel.first!
        
        XCTAssertNotNil(artist)
        XCTAssertEqual(artist.name, "Justin Timberlake")
        XCTAssertEqual(artist.image.count,  5)
        XCTAssertEqual(artist.url, "https://www.last.fm/music/Justin+Timberlake")

    }
    

}
