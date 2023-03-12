
// приватный 
#import "ObjViewControllerDialog.h"


// 3.Создайте один проект и сделайте каждую задачу на Objective-C в виде отдельного контроллера, в каждом из которых есть одно текстовое поле, кнопка и лейбл. При нажатии на кнопку в лейбл должно выводиться:
// 3.1.Текущее значение текстфилда и все предыдущие, для которых была нажата кнопка. Разделитель — пробел. Например, в поле ввели «Никита», нажали кнопку — в лейбл выведется «Никита». В поле ввели «Антон» и нажали на кнопку — в лейбл выведется «Антон Никита», и так далее.
@interface ObjViewControllerDialog ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ObjViewControllerDialog

NSMutableArray* textFieldValues; //Динамическая упорядоченная коллекция объектов. Класс NSMutableArray объявляет программный интерфейс для объектов, которые управляют изменяемым массивом объектов. Этот класс добавляет операции вставки и удаления к базовому поведению обработки массивов, унаследованному от NSArray.


- (void)viewDidLoad { // синтаксис функции (- не является статической, относится к экземпляру класса; + аналогично тому, если бы в swift написали static) void - тип возращаемого значения (в С образных языках, в отличии от swift надо обязательно писать тип возращамого значения, даже если void, () - не обязательно ставить
    [super viewDidLoad];
    textFieldValues = [NSMutableArray array];
}

- (IBAction)button:(id)sender {
    [textFieldValues addObject: [self.textField text]];
    self.label.text = [textFieldValues componentsJoinedByString:@" "];
    self.textField.text = nil;
}
@end
