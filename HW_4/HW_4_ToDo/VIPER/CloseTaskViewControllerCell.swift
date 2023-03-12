
import UIKit

class CloseTaskViewControllerCell: UITableViewCell {
    
    static let identifier = "closeTaskCell"
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    public func configure(head: String?, body: String?, dateTask: String?, deadline: String?, status: String?) {
        
        headLabel.text = head
        bodyLabel.text = body
        dateLabel.text = dateTask
        deadlineLabel.text = deadline
        
        if status == "завершена" {
            statusImage.image = UIImage(named: "completed")
        } else if status == "удалена" {
            statusImage.image = UIImage(named: "deleted")
        }
    }
    
    
}
