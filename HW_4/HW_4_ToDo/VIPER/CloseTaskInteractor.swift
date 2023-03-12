
import UIKit
import CoreData

// серверное взаимодействие, взаимодетсвие с базами данных (Realm, CoreData), это модуль который связывается с другими библиотеками, хранилищами, зависимостями

// из Presenter получает запрос на то, чтобы что-то сделать
class CloseTaskInteractor: CloseTaskInteractorProtocol {
  
    var presenter: CloseTaskPresenterProtocol?
    private var coreDataManager = CoreDataManager.shared
    private var tasks: [Tasks] = []
    
    func loadTasks() {
        tasks = coreDataManager.fetchTasksUniversal(statusFetch: false, statusPredicate: false) /// грузим задачи кроме "создана" (false-false)
        
        if tasks.count > 0 {
            presenter?.fetchTasksLucky(tasks: tasks)
        }
    }
    
    func changeСreatedTask(indexPath: IndexPath) { /// редактировние статуса задачи
        let task = tasks[indexPath.row]
        task.status = "создана"
        CoreDataManager.shared.editTaskOnlyStatus(status: task.status!)
    }
}
