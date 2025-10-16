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

        describe("Login Screen") {
            context("when correct credentials are entered") {
                it("shows success alert") {
                    let idField = app.textFields["idTextField"]
                    let passwordField = app.secureTextFields["passwordTextField"]
                    let loginButton = app.buttons["loginButton"]

                    expect(idField.exists).to(beTrue())
                    expect(passwordField.exists).to(beTrue())
                    expect(loginButton.exists).to(beTrue())

                    idField.tap()
                    idField.typeText("admin")

                    passwordField.tap()
                    passwordField.typeText("password")

                    loginButton.tap()

                    let successAlert = app.alerts["成功"]
                    expect(successAlert.waitForExistence(timeout: 2)).to(beTrue())
                    expect(successAlert.staticTexts["ログイン成功"].exists).to(beTrue())
                }
            }

            context("when incorrect credentials are entered") {
                it("shows failure alert") {
                    let idField = app.textFields["idTextField"]
                    let passwordField = app.secureTextFields["passwordTextField"]
                    let loginButton = app.buttons["loginButton"]

                    expect(idField.exists).to(beTrue())
                    expect(passwordField.exists).to(beTrue())
                    expect(loginButton.exists).to(beTrue())

                    idField.tap()
                    idField.typeText("wrong")

                    passwordField.tap()
                    passwordField.typeText("credentials")

                    loginButton.tap()

                    let failureAlert = app.alerts["失敗"]
                    expect(failureAlert.waitForExistence(timeout: 2)).to(beTrue())
                    expect(failureAlert.staticTexts["IDまたはパスワードが違います"].exists).to(beTrue())
                }
            }
        }
    }
}
