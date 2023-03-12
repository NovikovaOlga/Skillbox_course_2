
import Foundation
import RealmSwift

final class HumanDetailControl: Object { // Ф. И. О., рост, вес, пол, дата рождения
    @objc dynamic var fullName: String? // фио
    @objc dynamic var growth: Double = 0.0 // рост
    @objc dynamic var weight: Double = 0.0 // вес
    @objc dynamic var gender: String? // вес
    @objc dynamic var dateOfBirth: String? // дата рожд.
}

final class ManagerBaseControl {
    static let shared = ManagerBaseControl()
    private let realm = try! Realm()
    var result: Results<HumanDetailControl>!
 
    //MARK: - вывести список всех людей
    func printHumans() {
        let object = realm.objects(HumanDetailControl.self)
        for o in object.indices {
            print("\(object[o].fullName!)---\(object[o].dateOfBirth!)---\(object[o].gender!)---h:\(object[o].growth)---w:\(object[o].weight)")
        }
    }
    
    //MARK: - добавить нового человека
    func addHuman(fullName: String, growth: Double, weight: Double, gender: String, dateOfBirth: String) {
        try! realm.write {
            let human = HumanDetailControl()
            human.fullName = fullName
            human.growth = growth
            human.weight = weight
            human.gender = gender
            human.dateOfBirth = dateOfBirth
            realm.add(human)
        }
    }
    
    //MARK: - удалить всех
    func deleteAll() {
        try! realm.write { realm.deleteAll() }
    }
    
    //MARK: - самый старший
    func olderHuman() -> HumanDetailControl? {
        if realm.objects(HumanDetailControl.self).count > 0 {
            var older = realm.objects(HumanDetailControl.self)[0]
            for human in realm.objects(HumanDetailControl.self) {
                if !compareDateOfBirth(human1: human, human2: older) {
                    older = human
                }}
            print("Older human: \(older.fullName!) (\(older.dateOfBirth!.toDateFormatter().1) years)")
            return older
        }
        return nil
    }
    
    //MARK: - самый молодой
    func youngestHuman() -> HumanDetailControl? {
        if realm.objects(HumanDetailControl.self).count > 0 {
            var youngest = realm.objects(HumanDetailControl.self)[0]
            for human in realm.objects(HumanDetailControl.self) {
                if compareDateOfBirth(human1: human, human2: youngest) {
                    youngest = human
                }}
            print("Youngest human: \(youngest.fullName!) (\(youngest.dateOfBirth!.toDateFormatter().1) years)")
            return youngest
        }
        return nil
    }
    //MARK: - самый упитанный
    func wellFedHuman() -> HumanDetailControl? {
        if realm.objects(HumanDetailControl.self).count > 0 {
            var older = realm.objects(HumanDetailControl.self)[0]
            for human in realm.objects(HumanDetailControl.self) {
                if human.weight > older.weight {
                    older = human
                }}
            print("Well Fed human: \(older.fullName!). Its weight is: \(older.weight) kg.")
            return older
        }
        return nil
    }
    
    //MARK: - сравнение дат
    func compareDateOfBirth(human1: HumanDetailControl, human2: HumanDetailControl) -> Bool {
        let human1bd = Int(truncating: (human1.dateOfBirth?.toDateFormatter().0.timeIntervalSinceNow)! as NSNumber)
        let human2bd = Int(truncating: (human2.dateOfBirth?.toDateFormatter().0.timeIntervalSinceNow)! as NSNumber)
        return human1bd > human2bd
    }
}

// MARK: - Extension
extension String {
    func toDateFormatter() -> (Date,Int) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY-MM-DD"
        guard let date = dateFormat.date(from: self) else {
            preconditionFailure("Error")
        }
        let age = Calendar.current.dateComponents([.year], from: date, to: Date()) // dateComponents - возвращает разницу между двумя датами.
        return (date, age.year!)
    }
}



let managerBaseControl = ManagerBaseControl()
managerBaseControl.deleteAll()

managerBaseControl.addHuman(fullName: "Martin Byrde", growth: 180.0, weight: 80.0, gender: "Male", dateOfBirth: "1969-01-14")
managerBaseControl.addHuman(fullName: "Wendy Byrde", growth: 171.5, weight: 61.3, gender: "Female", dateOfBirth: "1964-02-05")
managerBaseControl.addHuman(fullName: "Charlotte Byrde", growth: 163.2, weight: 62.9, gender: "Female", dateOfBirth: "1999-06-01")
managerBaseControl.addHuman(fullName: "Jonah Byrde", growth: 163.8, weight: 59.0, gender: "Male", dateOfBirth: "2004-05-13")
managerBaseControl.addHuman(fullName: "Ruth Langmore", growth: 165.0, weight: 54.3, gender: "Female", dateOfBirth: "1994-02-01")
managerBaseControl.addHuman(fullName: "Darlene Snell", growth: 167.3, weight: 59.0, gender: "Female", dateOfBirth: "1952-01-29")
managerBaseControl.addHuman(fullName: "Wyatt Langmore", growth: 178.2, weight: 79.3, gender: "Male", dateOfBirth: "1998-06-11")
managerBaseControl.addHuman(fullName: "Omar Navarro", growth: 176.8, weight: 87.2, gender: "Male", dateOfBirth: "1971-09-17")


managerBaseControl.printHumans()
managerBaseControl.olderHuman()
managerBaseControl.youngestHuman()
managerBaseControl.wellFedHuman()

