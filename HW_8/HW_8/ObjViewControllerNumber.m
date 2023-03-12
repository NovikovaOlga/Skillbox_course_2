
#import "ObjViewControllerNumber.h"
// Значение 2 в степени числа из текстового поля, если в текстовое поле введено целое число. Если в текстовом поле не введено целое число, то «Введите целое число в строку».
@interface ObjViewControllerNumber ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ObjViewControllerNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)button:(id)sender {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if (_textField.text.length > 0) {
        if ([self.textField.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            double powered = pow(2, self.textField.text.intValue);
            self.label.text = [NSString stringWithFormat:@"%.0f", powered];
            self.textField.text = nil;
        } else {
            self.label.text = @"Введите целое число в строку";
        }
    } else {
        self.label.text = @"Вы не ввели данные для расчета";
    }
}
@end
