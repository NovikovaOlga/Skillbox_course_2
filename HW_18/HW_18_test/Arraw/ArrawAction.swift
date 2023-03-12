import Foundation

class ArrawAction {
    
    func sortedElement(arraw: [Int]) -> [Int] {
        let sortedElem = arraw.sorted()
        return sortedElem
    }
    
    func reverseElement(arraw: [Int]) -> [Int] {
        let reverseElem: [Int] = arraw.reversed()
        return reverseElem
    }
    
    func countElement(arraw: [Int]) -> Int {
        let countElem = arraw.count
        return countElem
    }
    
    func maxElement(arraw: [Int]) -> Int {
        var maxElem = arraw.first
        for a in arraw {
            if a > maxElem! {
                maxElem = a
            }
        }
        return maxElem!
    }
    
    func minElement(arraw: [Int]) -> Int {
        
        var minElem = arraw.first
        for a in arraw {
            if a < minElem! {
                minElem = a
            }
        }
        return minElem!
    }
}
