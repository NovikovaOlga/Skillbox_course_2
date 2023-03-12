
import XCTest
import Quick
import Nimble
@testable import HW_18_test // доступ ко всему проекту


class ArrawActionQuickTests: QuickSpec {
    override func tearDown() {
    
    }
 
    override func spec() {
        
        describe("ArrawAction") {
            it("perform operation correctly") {

                // sortedElement
                expect(ArrawAction().sortedElement(arraw: [5, 7, 99, 81, 55, 4, 21])).to(equal([4, 5, 7, 21, 55, 81, 99]))

                // reverseElement
                expect(ArrawAction().reverseElement(arraw: [5, 7, 99, 81, 55, 4, 21])).to(equal([21, 4, 55, 81, 99, 7, 5]))

                // countElement
                expect(ArrawAction().countElement(arraw: [5, 7, 99, 81, 55, 4, 21])).to(equal(7))

                // maxElement
                expect(ArrawAction().maxElement(arraw: [5, 7, 99, 81, 55, 4, 21])).to(equal(99))

                // minElement
                expect(ArrawAction().minElement(arraw: [5, 7, 99, 81, 55, 4, 21])).to(equal(4))
            }
        }
    }
}
