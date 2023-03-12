/*Что нужно сделать
 
 1 Прочитайте статью про утечку памяти: https://hackernoon.com/swift-avoiding-memory-leaks-by-examples-f901883d96e5.
 2 Изучите инструменты, которые есть в Xcode: https://www.raywenderlich.com/397-instruments-tutorial-with-swift-getting-started.
 3 Прочитайте статью: https://swiftbook.ru/post/tutorials/tutorial-po-instrumentam-na-swift/.
 4 Напишите как можно больше примеров (с кодом), в которых по-разному создаются утечки памяти.
 Ответ: со строки 35 этого файла
 5 Опишите, что нужно сделать, чтобы во время выполнения программы вывести значение любого свойства или функции.
 Ответ: необходимо утсановить breakpoint  в нужной строке, запустить приложение выполнить его до точки остановки и в нижнем меню набрать "po valueTextField", где valueTextField - наше значение
 
 6 Опишите, что нужно сделать, чтобы во время выполнения программы поменять значение у любого свойства.
 Ответ: необходимо утсановить breakpoint  в нужной строке, запустить приложение выполнить его до точки остановки и в нижнем меню набрать "expression valueTextField" = "0", где valueTextField - изменяемое значение, 0 - значение, на которое изменяем.
 
 7 Укажите, как с помощью брейкпоинтов отслеживать изменения значений у выбранного свойства.
 Ответ: необходимо утсановить breakpoint  в нужной строке, запустить приложение выполнить его до точки остановки и в нижнем меню правой кнопкой мышки в открывшемся меню выбрать "Watch "valueTextField"".
 
 8 Укажите, как отслеживать вызов системных функций.
 Ответ: в верхнем меню product -> profile (создадим другую сборку), в открывшемся меню выберем Time Profiler -> Choose
 
 
 9 Выберите любые семь инструментов Xcode и опишите, для чего они используются.
 Ответ:
 1 Blanc: документ трассировки, который можно настроить с помощью инструментов из библиотеки
 2 Activity Monitor: отслеживает статистику использования процессора, памяти, диска и сети для процессов и системы
 3 Allocation: отслеживает виртуальную память и справку процесса, предоставляя имена классов и, при необходимости, истории сохранения / выпуска объектов
 4 App Launch: запуск приложения (производительность) с профилем времени 5 секунд и трассировкой состояния потока
 5 Core Data: отслеживает активность файловой системы Core Data, включая ошибки, выборки и сохранения
 6 Game Performance: понимание ключевых областей производительности, критически важных для производительности игры и плавной частоты кадров
 7 Time Profile: выполняет выборку процессов, запущенных на процессорах системы, с минимальными затратами времени на основе временных затрат (лучше использовать на реальных устройствах, так как при использовании симулятора используется мощность компьютера и данные будут отличаться)
 
 
 */
import Foundation
import UIKit

//Пример 1: круговая ссылка
class Animal{
    weak var raccoon: Animal? //
    
    init() {
        print(" + racoon ")
    }
    
}

class MemoryLeaks: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let h1 = Animal()
        let h2 = Animal()
        
        h1.raccoon = h2
        h2.raccoon = h1
    }
  
}

// Пример 2: ссылка на самого себя

class MemoryLeaks2: UIViewController {
   
    var forest:(() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forest = {
            self.drawingTrees()
        }
      }
    
    func drawingTrees() {
        print("Hello raccoon forest!")
    }
}

// Пример 3: когда контроллер 1 ссылается на контроллер 2, контроллер 2 ссылается на контроллер 3 и контроллер 3 ссылается на контроллер 1 