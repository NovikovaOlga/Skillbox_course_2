
import UIKit
import CoreData

class NewTaskTableViewController: UITableViewController, UITextFieldDelegate {

    var task = TaskModel(head: "", body: "", dateTask: "", deadline: "", status: "создана")

    let dateTaskPicker = UIDatePicker()
    let deadlinePicker = UIDatePicker()
    let statusPicker = UIPickerView()

    let localID = Locale.preferredLanguages.first
    let formatter = DateFormatter() /// http://nsdateformatter.com

    @IBOutlet weak var headTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var dateTaskTextField: UITextField!
    @IBOutlet weak var deadlineTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!

    @IBOutlet weak var imagePicker: UIImageView!

    @IBAction func textChanged(_ sender: UITextField) { /// editing changed (здесь связь сразу с 5 полями - будем проверять заполнение и подсвечивать/ не подсвечивать кнопку сохранения
        updateSaveButton()
    }

    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        statusPicker.dataSource = self
        statusPicker.delegate = self
        statusTextField.delegate = self
        statusTextField.inputView = statusPicker

        tapGesturePickerDone() /// жест закрытия пикера при клике по экрану

        updateData()
        updateSaveButton()
        formatterDate()
    }
    // MARK: updateData - грузим данные в textField
    private func updateData() {

        headTextField.text = task.head
        bodyTextField.text = task.body
        dateTaskTextField.text = task.dateTask
        deadlineTextField.text = task.deadline
        statusTextField.text = task.status

        if task.status == "создана" {
            imagePicker.image = UIImage(named: "created")
        } else if task.status == "завершена" {
            imagePicker.image = UIImage(named: "completed")
        } else if task.status == "удалена" {
            imagePicker.image = UIImage(named: "deleted")
        }
    }

    // MARK: жест закрытия пикера при клике по экрану
    func tapGesturePickerDone() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone)) /// жест закрытия пикера при клике по экрану
        self.view.addGestureRecognizer(tapGesture)
    }

    // MARK: formatterDate & Locale
    private func formatterDate() {

        formatter.dateFormat = "dd.MM.yyyy, E" /// как вариант  "dd.MM.yyyy HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")

        dateTaskTextField.inputView = dateTaskPicker
        dateTaskPicker.datePickerMode = .date
        dateTaskPicker.preferredDatePickerStyle = .wheels
        dateTaskPicker.locale = Locale(identifier: localID!) /// локаль установок телефона
        dateTaskPicker.addTarget(self, action: #selector(dateTaskChanged), for: .valueChanged) /// дата в TF меняется автоматически при прокуртке барабанов пикера

        deadlineTextField.inputView = deadlinePicker
        deadlinePicker.datePickerMode = .date
        deadlinePicker.preferredDatePickerStyle = .wheels
        deadlinePicker.locale = Locale(identifier: localID!)
        deadlinePicker.addTarget(self, action: #selector(deadlineChanged), for: .valueChanged)

        guard task.head == "" else { return }
        dateTaskTextField.text = formatter.string(from: NSDate() as Date)
        deadlineTextField.text = formatter.string(from: NSDate() as Date)

    }

    // MARK: updateSaveButton - заполнены все поля = подсветим кнопку Save
    private func updateSaveButton() {
        let headText = headTextField.text ?? ""
        let bodyText = bodyTextField.text ?? ""
        let dateTaskText = dateTaskTextField.text ?? ""
        let deadlineText = deadlineTextField.text ?? ""
        let statusText = statusTextField.text ?? ""

        saveButtonOutlet.isEnabled = !headText.isEmpty && !bodyText.isEmpty  && !dateTaskText.isEmpty && !deadlineText.isEmpty && !statusText.isEmpty
    }
}

// MARK: numberOfRowsInSection (static)
extension NewTaskTableViewController { // таблица

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

// MARK: UIPickerViewDataSource
extension NewTaskTableViewController: UIPickerViewDataSource {  /// пикер статуса задачи

    func numberOfComponents(in pickerView: UIPickerView) -> Int { /// количество компонентов (барабанов)
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
}

// MARK: UIPickerViewDelegate
extension NewTaskTableViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { /// заголовок - соответствующи элемент массива
        return status[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch row {
        case 0:
            self.imagePicker.image = UIImage(named: "created")
            self.statusTextField.text = "создана"
        case 1:
            self.imagePicker.image = UIImage(named: "completed")
            self.statusTextField.text = "завершена"
        case 2:
            self.imagePicker.image = UIImage(named: "deleted")
            self.statusTextField.text = "удалена"
        default:
            break
        }
    }
}

// MARK: UIPickerView - formatter & Changed & tapGesture
extension NewTaskTableViewController { /// пикер дат

    @objc func dateTaskChanged() { /// выбор даты  - ее формат
        dateTaskTextField.text = formatter.string(from: dateTaskPicker.date)
    }

    @objc func deadlineChanged() { /// выбор даты  - ее формат
        deadlineTextField.text = formatter.string(from: deadlinePicker.date)
    }

    @objc func tapGestureDone() { /// функция при нажатии на экран (закрываем пикер)
        view.endEditing(true)
    }
}

// MARK: backgroundImage
extension UITableView { /// поле background image в tableVIew в storyboard
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return nil
        }
        set {
            backgroundView = UIImageView(image: newValue)
            backgroundView?.alpha = 0.2
            backgroundView?.contentMode = .top
        }
    }
}
