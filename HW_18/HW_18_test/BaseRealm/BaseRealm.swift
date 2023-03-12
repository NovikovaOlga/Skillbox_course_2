import Foundation
import RealmSwift

final class HumanDetail: Object { // Ф. И. О., рост, вес, пол, дата рождения
    @objc dynamic var fullName: String? // фио
    @objc dynamic var growth: Double = 0.0 // рост
    @objc dynamic var weight: Double = 0.0 // вес
    @objc dynamic var gender: String? // вес
    @objc dynamic var dateOfBirth: String? // дата рожд.
}

final class ManagerBase {
    static let shared = ManagerBase()
    private let realm = try! Realm()
    var result: Results<HumanDetail>!
    
    func getHumans() -> Results<HumanDetail> {
        realm.objects(HumanDetail.self)
    }
    
    //MARK: - добавить нового человека
    // описание человека
    func human(fullName: String, growth: Double, weight: Double, gender: String, dateOfBirth: String) -> HumanDetail {
        let human = HumanDetail()
        human.fullName = fullName
        human.growth = growth
        human.weight = weight
        human.gender = gender
        human.dateOfBirth = dateOfBirth
        return human
    }
    
    // добавление человека
    func addHuman(human: HumanDetail) {
        try! realm.write {
            realm.add(human)
        }
    }

    //MARK: - удалить всех
    func deleteAll() -> Bool {
        try! realm.write {
            realm.deleteAll()
            return true
        }
    }
    
    //MARK: - самый старший
    func olderHuman() -> HumanDetail? {
        if realm.objects(HumanDetail.self).count > 0 {
            var older = realm.objects(HumanDetail.self)[0]
            for human in realm.objects(HumanDetail.self) {
                if !compareDateOfBirth(human1: human, human2: older) {
                    older = human
                }}
            print("Older human: \(older.fullName!) (\(older.dateOfBirth!.toDateFormatter().1) years)")
            return older
        }
        return nil
    }
    
    //MARK: - самый молодой
    func youngestHuman() -> HumanDetail? {
        if realm.objects(HumanDetail.self).count > 0 {
            var youngest = realm.objects(HumanDetail.self)[0]
            for human in realm.objects(HumanDetail.self) {
                if compareDateOfBirth(human1: human, human2: youngest) {
                    youngest = human
                }}
            print("Youngest human: \(youngest.fullName!) (\(youngest.dateOfBirth!.toDateFormatter().1) years)")
            return youngest
        }
        return nil
    }
    //MARK: - самый упитанный
    func wellFedHuman() -> HumanDetail? {
        if realm.objects(HumanDetail.self).count > 0 {
            var older = realm.objects(HumanDetail.self)[0]
            for human in realm.objects(HumanDetail.self) {
                if human.weight > older.weight {
                    older = human
                }}
            print("Well Fed human: \(older.fullName!). Its weight is: \(older.weight) kg.")
            return older
        }
        return nil
    }
    
    func compareDateOfBirth(human1: HumanDetail, human2: HumanDetail) -> Bool {
        let human1bd = Int(truncating: (human1.dateOfBirth?.toDateFormatter().0.timeIntervalSinceNow)! as NSNumber)
        let human2bd = Int(truncating: (human2.dateOfBirth?.toDateFormatter().0.timeIntervalSinceNow)! as NSNumber)
        return human1bd > human2bd
    }
}

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


