/*
 c) UITableView с выводом 20 разных имён людей и две кнопки. Одна кнопка добавляет новое случайное имя в начало списка, вторая — удаляет последнее имя. Список реактивно связан с UITableView.
 
 f) Для задачи «c» добавьте поисковую строку. При вводе текста в поисковой строке, если текст не изменялся в течение двух секунд, выполните фильтрацию имён по введённой поисковой строке (с помощью оператора throttle). Такой подход применяется в реальных приложениях при поиске, который отправляет поисковый запрос на сервер, — чтобы не перегружать сервер и поисковая строка отправлялась на сервер, только когда пользователь закончит ввод (или сделает паузу во вводе).
 */

import UIKit
import ReactiveKit
import Bond

class CviewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let names = MutableObservableArray(["Уолтер Уайт", "Скайлер Уайт", "Джесси Пинкман", "Хэнк Шрейдер", "Мари Шрейдер", "Уолтер Уайт мл.", "Сол Гудман", "Густаво Фринг", "Майк Эрмантраут", "Венди", "Гейл Боттикер", "Гектор Саламанка", "Гретхен Шварц", "Джейн Марголис", "Доминго Молина", "Кристиан Ортега ", "Стивен Гомез", "Тед Бенеке", "Тощий Пит", "Туко Саламанка"])
    
    let names1 = MutableObservableArray(["Уолтер Уайт", "Скайлер Уайт", "Джесси Пинкман", "Хэнк Шрейдер", "Мари Шрейдер", "Уолтер Уайт мл.", "Сол Гудман", "Густаво Фринг", "Майк Эрмантраут", "Венди", "Гейл Боттикер", "Гектор Саламанка", "Гретхен Шварц", "Джейн Марголис", "Доминго Молина", "Кристиан Ортега ", "Стивен Гомез", "Тед Бенеке", "Тощий Пит", "Туко Саламанка"])
    
    let searchNames = MutableObservableArray<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNames.bind(to: tableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CviewControllerCell
            cell.nameLabel.text = dataSourse[indexPath.row]
            return cell
        }
        searchBar.reactive.text
            .ignoreNils()
            .observeNext { [self] text in
                text.count > 0
                ? self.names.filterCollection { $0.contains(text) }
                    .debounce(for: 2)
                  //  .throttle(for: 2)
                    .bind(to: searchNames)
                : self.names
            
                    .bind(to: searchNames )
            }
            .dispose(in: reactive.bag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reactive.bag.dispose()
    }

    
    @IBAction func addButton(_ sender: Any) {
       
        names.insert(names1.array.randomElement()!, at: 0)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        guard !names.isEmpty else { return }
        names.removeLast()
    }
    
}
