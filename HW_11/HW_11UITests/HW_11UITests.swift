
import XCTest

class HW_11UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK:  корректности обработки неправильных данных в интерфейсе (UI-тесты), не менее трёх сценариев;
    func testPassword() throws { //логин +, пароль -
        let app = XCUIApplication()
        app.launch()
        
        let loginTextField = app.textFields["Login"]
        let passwordTextField = app.textFields["Password"]
        let button = app.buttons["Войти"]//.staticTexts["Войти"]
        
        
        loginTextField.press(forDuration: 0.1)
        loginTextField.typeText("login@gmail.com")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("qwerty")
        
        button.tap()
        
        let message = app.staticTexts["В пароле нет заглавных букв и цифр"]
        XCTAssertFalse(message.exists)
    }

    func testEmail() throws { //логин -, пароль +

        let app = XCUIApplication()
        app.launch()
        
        let loginTextField = app.textFields["Login"]
        let passwordTextField = app.textFields["Password"]
        let button = app.buttons["Войти"]//.staticTexts["Войти"]
        
        
        loginTextField.press(forDuration: 0.1)
        loginTextField.typeText("login@gmail")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("Qwerty1")
        
        button.tap()
        
        let message = app.staticTexts["Неверный логин (формат электронной почты)"]
        XCTAssertFalse(message.exists)
    }
    
    func testEmailPassword() throws { //логин -, пароль -

        let app = XCUIApplication()
        app.launch()
        
        let loginTextField = app.textFields["Login"]
        let passwordTextField = app.textFields["Password"]
        let button = app.buttons["Войти"]//.staticTexts["Войти"]
        
        
        loginTextField.press(forDuration: 0.1)
        loginTextField.typeText("login@gmail")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("Qwerty")
        
        button.tap()
        
        let message = app.staticTexts["Неверный логин (формат электронной почты) и неверный пароль"]
        XCTAssertFalse(message.exists)
    }
    
    // MARK: корректности обработки правильных данных в интерфейсе.
    
    func testEmailPasswordGood() throws { //логин +, пароль +

        let app = XCUIApplication()
        app.launch()
        
        let loginTextField = app.textFields["Login"]
        let passwordTextField = app.textFields["Password"]
        let button = app.buttons["Войти"]//.staticTexts["Войти"]
        
        
        loginTextField.press(forDuration: 0.1)
        loginTextField.typeText("login@gmail.com")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("Qwerty1")
        
        button.tap()
        
        let message = app.staticTexts["Корректные данные для авторизации"]
        XCTAssertFalse(message.exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
