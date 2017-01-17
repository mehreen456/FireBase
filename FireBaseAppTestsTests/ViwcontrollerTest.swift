//
//  ViwcontrollerTest.swift
//  FireBaseApp
//
//  Created by Amerald on 17/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

import XCTest
@testable import FireBaseApp

class ViwcontrollerTest: XCTestCase {
 
    let fvc = FireBase()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSignIn()
    {
        
        let email = "mehreen@gmail.com"
        let pass = "qweasd"
        fvc.SignIn(email, Upassword: pass) { (error) -> () in
            XCTAssertEqual(nil,error)
        }
        
    }
    
    func testCreateUser()
    {
        let asyncExpectation = expectationWithDescription("Get Response")
       
        let email = "mehreen.ku1@gmail.com"
        let pass = "qweasd"
        fvc.CreateAuthenticatedUser(email, Upassword: pass, Shouldverify: false, completion: { (error) -> () in
         
           XCTAssertEqual(nil, error, "error ..")
            asyncExpectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }

    func testVerifyUser()
    {
        XCTAssertTrue(fvc.IsVreifiedUser())
        }
}
