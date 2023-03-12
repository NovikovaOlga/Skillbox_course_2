
import UIKit

class CloseTaskViewController: UIViewController, CloseTaskViewProtocol {
    
    var presenter: CloseTaskPresenterProtocol?
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = false /// нельзя выбрать строку (подсветить)
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
        table.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }
    
    func handleTasks(with results: [Tasks]) {
        table.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension CloseTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CloseTaskViewControllerCell.identifier, for: indexPath) as! CloseTaskViewControllerCell
        
        cell.configure(head: presenter?.textHeadText(indexPath: indexPath),
                       body: presenter?.textBodyText(indexPath: indexPath),
                       dateTask: presenter?.textDateTaskText(indexPath: indexPath),
                       deadline: presenter?.textDeadlineText(indexPath: indexPath),
                       status: presenter?.textStatusText(indexPath: indexPath))
        return cell
    }
    
    
}

// MARK: segue - changeTask
extension CloseTaskViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "changeTask" else { return }
        
        let indexPath = table.indexPathForSelectedRow!
        let task = tasks[indexPath.row]
        let newTaskVC = segue.destination as! NewTaskTableViewController
        
        newTaskVC.task.head = task.head! ///  все характеристики выбранной задачи отобразить на втором экране
        
        newTaskVC.task.body = task.body!
        newTaskVC.task.dateTask = task.dateTask!
        newTaskVC.task.deadline = task.deadline!
        newTaskVC.task.status = task.status!
    }
}

// MARK: изменить статус задачи  "создана" - левый экшн
extension CloseTaskViewController {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { /// левый экшн - переносим "создана"
        
        let created = createdAction(at: indexPath) /// левая кнопка
        return UISwipeActionsConfiguration(actions: [created])
    }
    
    func createdAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Created") { (action, view, completion) in
            self.presenter?.returnСreatedTask(indexPath: indexPath)
            self.presenter?.viewDidLoad()
            self.table.reloadData()
            completion(true) /// действие завершится
        }
        action.backgroundColor = .systemPurple /// кнопочка фиолетовая
        action.image = UIImage(systemName: "clock")  /// в приложении San Fransymbols - нужный символ и его настройки
        return action
    }
}
