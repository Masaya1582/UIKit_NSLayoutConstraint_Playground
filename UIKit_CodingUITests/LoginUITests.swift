//
//  LoginUITests.swift
//  UIKit_CodingUITests
//
//  Created by Cookie-san on 2025/10/15.
//

import Quick
import Nimble
import UIKit_Coding
import RxCocoa
import RxCocoaRuntime
@testable import UIKit_Coding
import XCUIAutomation

final class LoginUITests: QuickSpec {
    override class func spec() {
        var app: XCUIApplication!

        beforeEach {
            app = XCUIApplication()
            app.launch()
        }

        describe("Login Flow") {
            func enterCredentials(id: String, password: String) {
                let idField = app.textFields["idTextField"]
                let passwordField = app.secureTextFields["passwordTextField"]
                let loginButton = app.buttons["loginButton"]

                expect(idField.waitForExistence(timeout: 1)).to(beTrue())
                expect(passwordField.exists).to(beTrue())
                expect(loginButton.exists).to(beTrue())

                idField.tap()
                idField.typeText(id)

                passwordField.tap()
                passwordField.typeText(password)

                loginButton.tap()
            }


            context("when valid credentials are entered") {
                it("shows success alert") {
                    enterCredentials(id: "admin", password: "password")
                    let alert = app.alerts["成功"]
                    expect(alert.waitForExistence(timeout: 2)).to(beTrue())
                    expect(alert.staticTexts["ログイン成功"].exists).to(beTrue())
                }
            }

            context("when invalid credentials are entered") {
                it("shows failure alert") {
                    enterCredentials(id: "wrong", password: "pass")
                    let alert = app.alerts["失敗"]
                    expect(alert.waitForExistence(timeout: 2)).to(beTrue())
                    expect(alert.staticTexts["IDまたはパスワードが違います"].exists).to(beTrue())
                }
            }
        }
    }
}
