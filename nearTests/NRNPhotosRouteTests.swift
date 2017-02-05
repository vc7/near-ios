//
//  NRNPhotosRouteTests.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import XCTest

class NRNPhotosRouteTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchLocationInformationRouteParameters() {
        
        let longitude = "tested_longitude"
        let latitude = "tested_latitude"
        
        let route = NRNPhotosRoute.fetchPhotos(longitude: longitude, latitude: latitude)
        
        XCTAssertEqual(route.parameters["longitude"] as? String, longitude)
        XCTAssertEqual(route.parameters["latitude"] as? String, latitude)
    }
    
}
