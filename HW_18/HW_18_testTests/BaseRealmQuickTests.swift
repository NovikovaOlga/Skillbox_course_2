import XCTest
import Quick
import Nimble
import RealmSwift
@testable import HW_18_test

class PersonsDatabaseTests: QuickSpec {
    override func tearDown() {
    }
    
    override func spec() {
        describe("BaseRealmQuickTests") {
            it("ManagerBaseTests") {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
                
                //MARK: - добавление новых записей в базу
                let martinByrde = ManagerBase.shared.human(fullName: "Martin Byrde", growth: 180.0, weight: 80.0, gender: "Male", dateOfBirth: "1969-01-14")
                ManagerBase.shared.addHuman(human: martinByrde)
                
                let wendyByrde = ManagerBase.shared.human(fullName: "Wendy Byrde", growth: 171.5, weight: 61.3, gender: "Female", dateOfBirth: "1964-02-05")
                ManagerBase.shared.addHuman(human: wendyByrde)
                
                let charlotteByrde = ManagerBase.shared.human(fullName: "Charlotte Byrde", growth: 163.2, weight: 62.9, gender: "Female", dateOfBirth: "1999-06-01")
                ManagerBase.shared.addHuman(human: charlotteByrde)
                
                let jonahByrde = ManagerBase.shared.human(fullName: "Jonah Byrde", growth: 163.8, weight: 59.0, gender: "Male", dateOfBirth: "2004-05-13")
                ManagerBase.shared.addHuman(human: jonahByrde)
                
                let ruthLangmore =  ManagerBase.shared.human(fullName: "Ruth Langmore", growth: 165.0, weight: 54.3, gender: "Female", dateOfBirth: "1994-02-01")
                ManagerBase.shared.addHuman(human: ruthLangmore)
                
                let darleneSnell = ManagerBase.shared.human(fullName: "Darlene Snell", growth: 167.3, weight: 59.0, gender: "Female", dateOfBirth: "1952-01-29")
                ManagerBase.shared.addHuman(human: darleneSnell)
                
                let wyattLangmore = ManagerBase.shared.human(fullName: "Wyatt Langmore", growth: 178.2, weight: 79.3, gender: "Male", dateOfBirth: "1998-06-11")
                ManagerBase.shared.addHuman(human: wyattLangmore)
                
                let omarNavarro = ManagerBase.shared.human(fullName: "Omar Navarro", growth: 176.8, weight: 87.2, gender: "Male", dateOfBirth: "1971-09-17")
                ManagerBase.shared.addHuman(human: omarNavarro)
            
                print(ManagerBase.shared.getHumans())

                //MARK: - самый старший
                expect(ManagerBase.shared.olderHuman()?.dateOfBirth).to(equal(darleneSnell.dateOfBirth))
                
                //MARK: - самый молодой
                expect(ManagerBase.shared.youngestHuman()?.dateOfBirth).to(equal(jonahByrde.dateOfBirth))
                
                //MARK: - самый упитанный
                expect(ManagerBase.shared.wellFedHuman()?.weight).to(equal(omarNavarro.weight))
            }
        }
    }
}
