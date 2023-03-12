
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
       guard let _ = (scene as? UIWindowScene) else { return }
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        self.window = UIWindow(windowScene: windowScene)
//
//        let closeTaskViewController = CloseTaskRouter.stationVIPER()
//        let navigationController = UINavigationController(rootViewController: closeTaskViewController)
//
//        self.window?.rootViewController = navigationController
//        self.window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
     
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
  
//        (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.saveContext()
    }
}

