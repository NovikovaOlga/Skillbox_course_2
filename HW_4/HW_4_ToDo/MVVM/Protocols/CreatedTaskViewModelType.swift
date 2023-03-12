
import Foundation


// можно и без протокола, но так как один из принципов Solid - Dependency Inversion Principle (Подробности должны зависеть от абстракций, те надо зависеть от абстракций, а не от чего-то конкретного). Построим нашу зависимость на абстракциях.

protocol CreatedTaskViewModelType {
    
    func fetchUniversal()
    
    func numberOfRows() -> Int // MVVM - вариант через метод (можно через свойство var numberOfRow: Int { get })
    
    func cellViewModel(forIndexPath: IndexPath) -> CreatedTaskCellViewModelType? // MVVM модель для ячейки
    
    func quickChangeStatus(indexPath: IndexPath, changeStatus: String) // изменение статуса задачи при действии боковыми кнопками
    
    func selectRow(atIndexPath indexPath: IndexPath)// вспомогательный метод для определения indexPath
}

