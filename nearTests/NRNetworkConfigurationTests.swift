//
//  NRNetworkConfigurationTests.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import XCTest

class NRNetworkConfigurationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testNetworkConfigurationInitializeWithUrl() {
        let url = "http://tested.url/"
        let config = NRNetworkConfiguration.init(url: url)
        
        XCTAssertEqual(config.baseUrl, url)
    }
}
