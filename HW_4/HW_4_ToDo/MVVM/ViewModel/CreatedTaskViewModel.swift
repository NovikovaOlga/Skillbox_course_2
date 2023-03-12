import Foundation

class CreatedTaskViewModel: CreatedTaskViewModelType {
    
    static let shared = CreatedTaskViewModel()
    
    private var selectedIndexPath: IndexPath?

    func fetchUniversal() {
        tasks = CoreDataManager.shared.fetchTasksUniversal(statusFetch: false, statusPredicate: true) // условия false-true - созданные задачи
    }
    
    func numberOfRows() -> Int {
        return tasks.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CreatedTaskCellViewModelType? {
        let task = tasks[indexPath.row]
        // передадим профиль дальше, чтобы следующая viewModel с ним работала
        return CreatedTaskCellViewModel(tasks: task)
    }
    
    func quickChangeStatus(indexPath: IndexPath, changeStatus: String) {
                let task = tasks[indexPath.row]
        task.status = changeStatus
        CoreDataManager.shared.editTaskOnlyStatus(status: task.status!)
                fetchUniversal()
    }

    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
