
import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var head: String?
    @NSManaged public var body: String?
    @NSManaged public var dateTask: String?
    @NSManaged public var deadline: String?
    @NSManaged public var status: String?

}

extension Tasks: Identifiable {

}
