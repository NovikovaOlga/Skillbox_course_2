
import Foundation

class CreatedTaskCellViewModel: CreatedTaskCellViewModelType {
    
    private var tasks: Tasks
    init(tasks: Tasks) {
        self.tasks = tasks
    }
    
    var headLabel: String {
        return tasks.head ?? ""
    }
    
    var bodyLabel: String {
        return tasks.body ?? ""
    }
    
    var dateLabel: String {
        return tasks.dateTask ?? ""
    }
    
    var deadlineLabel: String {
        return tasks.deadline ?? ""
    }
    
    var statusLabel: String {
        return tasks.status ?? ""
    }
    
}
