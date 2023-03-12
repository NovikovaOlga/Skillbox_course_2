
import Foundation
import UIKit

// MARK: - View

protocol CloseTaskViewProtocol: class {
 
    var presenter: CloseTaskPresenterProtocol? { get set }

    func handleTasks(with results: [Tasks])
}

// MARK: - Presenter

protocol CloseTaskPresenterProtocol: class {
    
    func viewDidLoad()
    
    func textHeadText(indexPath: IndexPath) -> String?
    func textBodyText(indexPath: IndexPath) -> String?
    func textDateTaskText(indexPath: IndexPath) -> String?
    func textDeadlineText(indexPath: IndexPath) -> String?
    func textStatusText(indexPath: IndexPath) -> String?
    
    func returnСreatedTask(indexPath: IndexPath) /// правый экшн - восстановить
    func fetchTasksLucky(tasks: [Tasks])
    func numberOfRowsInSection() -> Int
}

// MARK: - Interactor

protocol CloseTaskInteractorProtocol: class {
    
    var presenter: CloseTaskPresenterProtocol? { get set }
    func loadTasks()
    func changeСreatedTask(indexPath: IndexPath)
}

// MARK: - Router

protocol CloseTaskRouterProtocol: class {
    static func stationVIPER() -> CloseTaskViewController
}
