
import UIKit

class CreatedTaskViewControllerCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
 
    weak var viewModel: CreatedTaskCellViewModelType? { // сюда передали подготовленную модель и здесь ее заполнили
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            headLabel.text = viewModel.headLabel
            bodyLabel.text = viewModel.bodyLabel
            dateLabel.text = viewModel.dateLabel
            deadlineLabel.text = viewModel.deadlineLabel
            
            if viewModel.statusLabel == "создана" {
                statusImage.image = UIImage(named: "created")
            }
        }
    }
}
