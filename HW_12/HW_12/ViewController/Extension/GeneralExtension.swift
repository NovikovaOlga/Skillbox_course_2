/* Здесь расширения классов и типов
 
 Обращаются:
 1) RocketViewController
 
 🦉 CGImagePropertyOrientation -  Значения этого типа определяют положение начальной точки координат пикселя (0,0) и направления осей координат относительно предполагаемой ориентации изображения на дисплее. Значения ориентации обычно содержатся в метаданных изображения, и правильное указание ориентации изображения может быть важно как для отображения изображения, так и для определенных задач обработки изображений, таких как распознавание лиц. Например, данные пикселей для изображения, полученного камерой устройства iOS, кодируются в собственной альбомной ориентации датчика камеры. Когда пользователь делает снимок, удерживая устройство в портретной ориентации, iOS записывает значение ориентации CGImagePropertyOrientation.right в результирующий файл изображения. Программное обеспечение, отображающее изображение, может затем, после считывания этого значения из метаданных файла, применить поворот на 90 ° по часовой стрелке к данным изображения, чтобы изображение отображалось в предполагаемой ориентации фотографа.

*/

import UIKit
import Vision // для VNFaceLandmarkRegion2D

// MARK: face detection (3+) - отрисовка признаков лица
extension CGMutablePath {
    // Вспомогательная функция для добавления строк в путь.
    func addPoints(in landmarkRegion: VNFaceLandmarkRegion2D,
                   applying affineTransform: CGAffineTransform,
                   closingWhenComplete closePath: Bool) {
        let pointCount = landmarkRegion.pointCount
        
        // Нарисуйте линию тогда и только тогда, когда путь содержит несколько точек.
        guard pointCount > 1 else {
            return
        }
        self.addLines(between: landmarkRegion.normalizedPoints, transform: affineTransform)
        
        if closePath {
            self.closeSubpath()
        }
    }
}

// Преобразуйте ориентацию UIImageOrientation в ориентацию CGImage для использования в анализе зрения.
extension CGImagePropertyOrientation {
    init(_ uiImageOrientation: UIImage.Orientation) {
        switch uiImageOrientation {
        case .up: self = .up
        case .down: self = .down
        case .left: self = .left
        case .right: self = .right
        case .upMirrored: self = .upMirrored
        case .downMirrored: self = .downMirrored
        case .leftMirrored: self = .leftMirrored
        case .rightMirrored: self = .rightMirrored
        default: self = .up
        }
    }
}
