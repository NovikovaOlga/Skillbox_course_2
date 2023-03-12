import UIKit

class CreatedTaskViewController: UIViewController {
    
    private var viewModel: CreatedTaskViewModelType?
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBAction func closeTasksButton(_ sender: Any) { /// перейдем на роутер для вайпера (можно наверное как то через AppDelegate или sceneDelegate - но там сразу переходит на роутеры, может через цикл выьирать роутер / не роутер.
        let closeTaskViewController = CloseTaskRouter.stationVIPER()
        self.navigationController?.pushViewController(closeTaskViewController, animated: true) /// сегу убрала - делаем через push
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel = CreatedTaskViewModel()
        viewModel?.fetchUniversal()
        table.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel = CreatedTaskViewModel()
        viewModel?.fetchUniversal()
        table.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension CreatedTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "createdTaskCell", for: indexPath) as? CreatedTaskViewControllerCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
}

// MARK: изменить статус задачи "удалена" - правый экшн, "завершена" - левый экшн
extension CreatedTaskViewController {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { /// левый экшн
        
        let done = doneAction(at: indexPath) /// левая кнопка
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { /// правый экшн
        
        let delete = deleteAction(at: indexPath) /// правая кнопка
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Done") { (action, view, completion) in
            
            self.viewModel?.quickChangeStatus(indexPath: indexPath, changeStatus: "завершена")
            self.table.reloadData()
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")  /// в приложении San Fransymbols - нужный символ и его настройки
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            
            self.viewModel?.quickChangeStatus(indexPath: indexPath, changeStatus: "удалена")
            self.table.reloadData()
            completion(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "multiply.circle")
        return action
    }
}

// MARK: segue - так как переход на экран в архитектуре MVC, то передадим как в МVC (не через модель)
extension CreatedTaskViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard  segue.identifier == "editTask" else { return }
        
        let indexPath = table.indexPathForSelectedRow!
        let task = tasks[indexPath.row]
        let teleportVC = segue.destination as! NewTaskTableViewController /// переход на MVC модель
        
        teleportVC.task.head = task.head! ///  все характеристики выбранной задачи отобразить на втором экране
        teleportVC.task.body = task.body!
        teleportVC.task.dateTask = task.dateTask!
        teleportVC.task.deadline = task.deadline!
        teleportVC.task.status = task.status!
    }
    
    // MARK: segue - saveTask - пришло с экрана MVC - без модели
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveTask" else { return }
        let sourceVC = segue.source as! NewTaskTableViewController /// пришли с MVC модели
        let head = sourceVC.headTextField.text
        let body = sourceVC.bodyTextField.text
        let dateTask = sourceVC.dateTaskTextField.text
        let deadline = sourceVC.deadlineTextField.text
        let status = sourceVC.statusTextField.text
        
        if let selectedIndexPath = table.indexPathForSelectedRow {  /// если по индекс паф ячейка есть, то ее редактируем, если нет, то добавляем новую запись
            tasks[selectedIndexPath.row].head = head
            tasks[selectedIndexPath.row].body = body
            tasks[selectedIndexPath.row].dateTask = dateTask
            tasks[selectedIndexPath.row].deadline = deadline
            tasks[selectedIndexPath.row].status = status
            
            table.reloadRows(at: [selectedIndexPath], with: .fade)
            
            CoreDataManager.shared.editTask(head: head!, body: body!, dateTask: dateTask!, deadline: deadline!, status: status!)
        } else {
            CoreDataManager.shared.saveNewTask(head: head!, body: body!, dateTask: dateTask!, deadline: deadline!, status: status!)
            /// две строки далее нужны, тк NewController - Automatic (не на весь экран). Если бы был FullScreen - то срабатывало бы обновление во viewDidAppear
            //            fetchUniversal()
            //            table.reloadData()
            
        }
    }
}




