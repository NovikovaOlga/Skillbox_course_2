import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = SKShapeNode(circleOfRadius: 10)
    let enemy = SKShapeNode(circleOfRadius: 10)
    
    var scoreLabel = SKLabelNode(fontNamed: "System")
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //MARK: - didMove
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        scene?.backgroundColor = .lightGray
        playerSettings()
        enemySettings()
        scoreLabelSettings()
        
        timeGame()
        moveEnemy()
        enemyRadius()
    }
    
    //MARK: - player settings
    func playerSettings() {
        
        player.position = CGPoint(x: size.width / 2 + (size.width / 4), y: size.height - (size.height / 2))
        player.strokeColor = .black
        player.lineWidth = 1
        player.fillColor = .green
        addChild(player)
    }
    
    //MARK: - enemy settings
    func enemySettings() {
        enemy.position = CGPoint(x: size.width/2 - (size.width / 4), y: size.height - (size.height / 2))
        enemy.strokeColor = .black
        enemy.lineWidth = 1
        enemy.fillColor = .red
        addChild(enemy)
    }
    
    //MARK: - score label settings
    func scoreLabelSettings() {
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - (frame.maxY / 10))
        scoreLabel.fontColor = .white
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
    }
    
    //MARK: - player position = touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        move(node: player, to: touches.first!.location(in: self), speed: 100)
    }
    
    //MARK: - движение с одинаковой скоростью (я сделала чтобы скорость всегда была одинакова, как на уроке, независимо от расстояния, можно сделать через duration: 1 - скорость будет высокая на длинных расстояниях и низкая на коротких)
    func move(node: SKNode, to: CGPoint, speed: CGFloat, completion:(() -> Void)? = nil) {
        // рассчитаем длительность движения на основе скорости
        let x = node.position.x // получим х
        let y = node.position.y // получим y
        let distance = sqrt((x - to.x) * (x - to.x) + (y - to.y) * (y - to.y))
        let duration = TimeInterval(distance / speed)
        let move = SKAction.move(to: to, duration: duration) // действие движения
        node.run(move, completion: completion ?? { })
    }
    
    //MARK: - противник движется туда где мы находимся
    func moveEnemy() {
        self.score += 1
        move(node: enemy, to: player.position, speed: 80, completion: moveEnemy)
    }
    
    //MARK: - вызывается после того как показался следующий фрейм
    override func didEvaluateActions() {
        super.didEvaluateActions()
        
        if enemy.frame.intersects(player.frame) { // если враг пересек игрока (догнал) - сделаем переход на другую сцену
           
            // переход на сцену GameOver
            let scene = GameOverScene(size: size)
            let reveal = SKTransition.flipVertical(withDuration: 1.0)
            view?.presentScene(scene, transition: reveal)
        }
    }
    
    //MARK: - каждую 1 сек добавляется 1 очко
    func timeGame() {
        player.run(SKAction.wait(forDuration: 1.0)) {
            self.moveEnemy()
        }
    }
    
    //MARK: - каждые 5 сек радиус противника увеличивается на 1 пиксель и добавляется одно очко
    func enemyRadius() {
        enemy.run(SKAction.wait(forDuration: 5.0)) {
            self.enemy.xScale += 0.1
            self.enemy.yScale += 0.1
            self.score += 1
            self.enemyRadius()
        }
    }
}
