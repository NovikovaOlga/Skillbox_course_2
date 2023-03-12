// MARK: - Builder

// Строитель — это порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово. Строитель даёт возможность использовать один и тот же код строительства для получения разных представлений объектов.

// Пример: машина для колеровки красок

class RGBcolor {
    var red = 0
    var green = 0
    var blue = 0
}

protocol RGBcolorBuilder {
    func red(_ quantity: Int)
    func green(_ quantity: Int)
    func blue(_ quantity: Int)
}

class ColorBox: RGBcolorBuilder {

    let color: RGBcolor // финальный цвет
    
    init(formula: RGBcolor) {
        color = formula
    }
    
    func red(_ quantity: Int) {
        color.red = quantity
    }
    
    func green(_ quantity: Int) {
        color.green = quantity
    }
    
    func blue(_ quantity: Int) {
        color.blue = quantity
    }
}

class Director {
    
    func code_00YY83069(builder: RGBcolorBuilder) -> RGBcolor {
       let builder = ColorBox(formula: RGBcolor())
        builder.red(239)
        builder.green(228)
        builder.blue(216)
        print("codeDulex: 00YY83069, codeRGB: 239 228 216 (#efe4d8)")
        return builder.color
    }
    
    func code_35YY64633(builder: RGBcolorBuilder) -> RGBcolor {
       let builder = ColorBox(formula: RGBcolor())
        builder.red(255)
        builder.green(195)
        builder.blue(72)
        print("codeDulex: 35YY64633, codeRGB: 255 195 72 (#ffc348)")
        return builder.color
    }
    
    func code_30GG33453(builder: RGBcolorBuilder) -> RGBcolor {
       let builder = ColorBox(formula: RGBcolor())
        builder.red(0)
        builder.green(171)
        builder.blue(130)
        print("codeDulex: 30GG33453, codeRGB: 0 171 130 (#00ab82)")
        return builder.color
    }
    
    func code_70RR15400(builder: RGBcolorBuilder) -> RGBcolor {
       let builder = ColorBox(formula: RGBcolor())
        builder.red(162)
        builder.green(57)
        builder.blue(85)
        print("codeDulex: 70RR15400, codeRGB: 162 57 85 (#a23955)")
        return builder.color
    }
    
    func code_50BB11321(builder: RGBcolorBuilder) -> RGBcolor {
       let builder = ColorBox(formula: RGBcolor())
        builder.red(0)
        builder.green(84)
        builder.blue(138)
        print("codeDulex: 50BB11321, codeRGB: 0 84 138 (#00548a)")
        return builder.color
    }
}

print("Your color: \(Director().code_70RR15400(builder: ColorBox(formula: RGBcolor())))") // этикетка с запрошенным цветом


/* https://masterkraski.ru/koler/dulex.php?
Код цвета: 00YY83069
Код RGB: 239 228 216 (#efe4d8)

Код цвета: 35YY64633
Код RGB: 255 195 72 (#ffc348)

Код цвета: 30GG33453
Код RGB: 0 171 130 (#00ab82)

Код цвета: 70RR15400
Код RGB: 162 57 85 (#a23955)
 
Код цвета: 50BB11321
Код RGB: 0 84 138 (#00548a)
 */
