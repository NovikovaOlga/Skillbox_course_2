
import Foundation
import UIKit

// переход с экрана на экран и обмен данными между ними

class CloseTaskRouter: CloseTaskRouterProtocol {
       
    static func stationVIPER() -> CloseTaskViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(identifier: "closeTaskViewController") as! CloseTaskViewController
        let router: CloseTaskRouterProtocol = CloseTaskRouter()
        let interactor: CloseTaskInteractorProtocol = CloseTaskInteractor()
        let presenter: CloseTaskPresenterProtocol = CloseTaskPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }

}
