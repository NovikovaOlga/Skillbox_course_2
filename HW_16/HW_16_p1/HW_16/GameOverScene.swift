
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    
    let label = SKLabelNode(text: "Game Over!")
    
    //MARK: - сообщение о проигрыше
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        label.fontSize = 46
        
        addChild(label)
    }
    
    //MARK: - нажатии на экран = новая игра
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let scene = GameScene(size: size)
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(scene, transition: reveal) 
    }
}

