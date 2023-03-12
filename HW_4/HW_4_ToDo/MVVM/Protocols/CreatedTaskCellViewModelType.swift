import Foundation

protocol CreatedTaskCellViewModelType: class {
  
    var headLabel: String { get }
    var bodyLabel: String { get }
    var dateLabel: String { get }
    var deadlineLabel: String { get }
    var statusLabel: String { get }
}
