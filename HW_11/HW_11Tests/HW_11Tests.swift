

import XCTest
@testable import HW_11

class HW_11Tests: XCTestCase {
    
    var sut: ViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEmail() throws {
        XCTAssertFalse(sut.validateEmail(candidate: "qwerty"), "no email")
        XCTAssertFalse(sut.validateEmail(candidate: "qwerty@gmail"), "invalid email")
        XCTAssertFalse(sut.validateEmail(candidate: "qwerty@gmail.tyi,"), "Email incorrect")
        XCTAssertFalse(sut.validateEmail(candidate: "qwertygmail.com"), "No @")
        XCTAssertFalse(sut.validateEmail(candidate: "кверти@джимайл.ком"), "unrecognized language")
        XCTAssertFalse(sut.validateEmail(candidate: "qwerty@gmailcom"), "unrecognized domain")
        XCTAssertFalse(sut.validateEmail(candidate: "qwerty @gmail.com"), "extra space")
        XCTAssertTrue(sut.validateEmail(candidate: "qwerty@gmail.com"), "Not bad! Correct email.")
    }
    
    func testPassword() throws {
        XCTAssertFalse(sut.validatePassword(candidate: " "), "no data entered")
        XCTAssertFalse(sut.validatePassword(candidate: "123456"), "no letters")
        XCTAssertFalse(sut.validatePassword(candidate: "123"), "few signs")
        XCTAssertFalse(sut.validatePassword(candidate: "123qwe"), "no capital letters")
        XCTAssertFalse(sut.validatePassword(candidate: "qwerty"), "there are no capital letters and numbers")
        XCTAssertFalse(sut.validatePassword(candidate: "QWE123"), "only capital letters and numbers")
        XCTAssertFalse(sut.validatePassword(candidate: "QWERTY"), "capital letters only")
        XCTAssertTrue(sut.validatePassword(candidate: "123Qwe"), "Great!")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
