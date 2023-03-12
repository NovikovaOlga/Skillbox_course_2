
import UIKit

// связующее звено между viewControllerom и interactor и router
// реагирует на события из viewController, но в отличии от viewModel он не сам их обрабатывает, а отправляет либо interactor либо router

class CloseTaskPresenter: CloseTaskPresenterProtocol {
    
    weak var view: CloseTaskViewProtocol?
    
    private var interactor: CloseTaskInteractorProtocol
    private var router: CloseTaskRouterProtocol
    var tasks: [Tasks]?
    
    init(view: CloseTaskViewProtocol,
         interactor: CloseTaskInteractorProtocol,
         router: CloseTaskRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.loadTasks()
    }
    
    func fetchTasksLucky(tasks: [Tasks]) { /// удачная загрузка
        self.tasks = tasks
        view?.handleTasks(with: tasks) /// обработанные задачи
    }
    
    func textHeadText(indexPath: IndexPath) -> String? {
        guard let tasks = self.tasks else { return nil }
        return tasks[indexPath.row].head
    }
    
    func textBodyText(indexPath: IndexPath) -> String? {
        guard let tasks = self.tasks else { return nil }
        return tasks[indexPath.row].body
    }
    
    func textDateTaskText(indexPath: IndexPath) -> String? {
        guard let tasks = self.tasks else { return nil }
        return tasks[indexPath.row].dateTask
    }
    
    func textDeadlineText(indexPath: IndexPath) -> String? {
        guard let tasks = self.tasks else { return nil }
        return tasks[indexPath.row].deadline
    }
    
    func textStatusText(indexPath: IndexPath) -> String? {
        guard let tasks = self.tasks else { return nil }
        return tasks[indexPath.row].status
    }
    
    func numberOfRowsInSection() -> Int {
        guard let tasks = self.tasks else {
            return 0
        }
        return tasks.count
    }

    func returnСreatedTask(indexPath: IndexPath) {
        interactor.changeСreatedTask(indexPath: indexPath)
    }
    
}

