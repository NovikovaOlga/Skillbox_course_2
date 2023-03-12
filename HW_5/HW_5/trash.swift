//// d) создайте класс, который последовательно выполняет полученные задачи в фоновом режиме: в него можно добавить задачу (на ваш выбор — либо класс с функцией run(), либо блок () → Void). При добавлении задачи класс проверяет, выполняется ли сейчас другая задача. Если да, он добавляет эту задачу в очередь, если нет — сразу начинает выполнять задачу в фоновом потоке. После выполнения задачи класс проверяет, есть ли другие задачи в очереди. Если есть, то берёт ту, которая была добавлена раньше других, приступает к ней и удаляет её из очереди.
//import UIKit
//
//protocol beholderRun: class {
//    func run(imageView: UIImageView, string: String)
//}
//
//class heroyRaya: beholderRun {
//    func run(imageView: UIImageView, string: String) {
//        guard let url = URL(string: string) else { return }
//        DispatchQueue.global(qos: .utility).async {
//            guard let data = try? Data(contentsOf: url) else { return }
//            //    let data = (try! Data(contentsOf: url))
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                imageView.image = image
//            }
//        }
//    }
//}
//
//class ViewControllerD: UIViewController{
//    
//    let boxImageURL = ["https://avatars.mds.yandex.net/get-zen_doc/3990034/pub_605389b73729ca110ec93e28_6053960c3729ca110ee35b9e/scale_1200", "https://www.mirf.ru/wp-content/uploads/2021/03/Rajya-i-poslednij-drakon-06.png", "https://images.kinorium.com/movie/shot/1619044/w1500_47905039.jpg"]
//    
//    let runRaya = heroyRaya()
//    let runDragon = heroyRaya()
//    let runMonkey = heroyRaya()
//    
//    let queue = DispatchQueue.global(qos: .utility)
//   // let queue = DispatchQueue(label: "queueRayaImageStepByStep", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))
//   // let queue = DispatchQueue(label: "queueRayaImageStepByStep", attributes: .concurrent) /// очередь
//    
////    let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
////        print("Старт очереди")
////    }
//
// //   let semaphore = DispatchSemaphore(value: 0) /// количество потоков, проходящих одновременно (будем на 1 и снова на 0)
//    
//    @IBOutlet weak var imageViewUp: UIImageView!
//    @IBOutlet weak var imageViewDown: UIImageView!
//    
//    @IBAction func runButtonUp(_ sender: Any) {
//    //    print("Старт!")
//     //   semaphore.signal() /// подаем сигнал - первый пошел
//        queue.async {
//        //    self.semaphore.wait() // ждем пока не получим сигнал
//            print("Первая задача - начало")
//             
//            self.runButtonUpBody()
//            
//       //     self.semaphore.signal() /// подаем сигнал следующему потоку
//            print("Первая задача - конец")
//        }
//        
//        queue.async {
//        //    self.semaphore.wait()
//            print("Вторая задача - начало")
//            
//            self.runButtonUpBody()
//            
//         //   self.semaphore.signal()
//            print("Вторая задача - конец")
//        }
//        queue.async {
//         //   self.semaphore.wait()
//            print("Третья задача - начало")
//            
//            self.runButtonUpBody()
//            
//            print("Третья задача - конец")
//        }
//    }
//    
//    @IBAction func runButtonDown(_ sender: Any) {
//      //  semaphore.signal() /// подаем сигнал - первый пошел
//        queue.async {
//        //    self.semaphore.wait()
//            print("Последняя задача - начало")
//            self.runButtonDownBody()
//            print("Последняя задача - конец")
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imageViewUp.contentMode = .scaleAspectFill
//        imageViewDown.contentMode = .scaleAspectFill
//    }
//
//    func runButtonUpBody() {
//        for _ in (1...10) {
//            self.runRaya.run(imageView: self.imageViewUp, string: boxImageURL[0])
//            self.runRaya.run(imageView: self.imageViewUp, string: boxImageURL[1])
//            self.runRaya.run(imageView: self.imageViewUp, string: boxImageURL[2])
//        }
//    }
//    
//    func runButtonDownBody() {
//        var t = 0
//        for _ in (1...2) {
//            for i in self.boxImageURL {
//                let url = URL(string: i)!
//                t += 2
//                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + .seconds(t)) {
//                    let data = (try! Data(contentsOf: url))
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        self.imageViewDown.image = image
//                    }
//                }
//            }
//        }
//    }
//}
//
