//
//  WBadgeTests.swift
//  WMobileKit
//
//  Copyright 2016 Workiva Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Quick
import Nimble
@testable import WMobileKit

class WBadgeSpec: QuickSpec {
    override func spec() {
        describe("WBadgeSpec") {
            var subject: UIViewController!
            var badge: WBadge!
            var window: UIWindow!

            beforeEach({
                subject = UIViewController()

                window = UIWindow(frame: UIScreen.mainScreen().bounds)
                window.rootViewController = subject

                window.addSubview(subject.view)

                subject.beginAppearanceTransition(true, animated: false)
                subject.endAppearanceTransition()
            })

            afterEach({
                badge = nil
            })

            let verifyCommonInit = {
                // All views added programatically
                expect(badge.subviews.contains(badge.badgeView)).to(beTruthy())
                expect(badge.badgeView.subviews.contains(badge.countLabel)).to(beTruthy())
                expect(badge.subviews.contains(badge.borderView)).to(beTruthy())

                // Custom properties
                expect(badge.badgeColor) == UIColor(hex: 0x0094FF)
                expect(badge.countColor) == UIColor.whiteColor()
                expect(badge.borderColor) == UIColor.clearColor()
                expect(badge.borderWidth) == 0
                expect(badge.horizontalAlignment) == xAlignment.Left
                expect(badge.verticalAlignment) == yAlignment.Top
                expect(badge.automaticallyHide) == true
                expect(badge.count) == 0
                expect(badge.widthPadding) == 10.0
                expect(badge.heightPadding) == 0.0
                expect(badge.font) == UIFont.boldSystemFontOfSize(12)
                expect(badge.fontSize) == 12.0
                expect(badge.hidden) == true
                expect(badge.showValue) == true
            }

            describe("when app has been init") {
                it("should init with coder correctly and verify commonInit") {
                    badge = WBadge()

                    let path = NSTemporaryDirectory() as NSString
                    let locToSave = path.stringByAppendingPathComponent("WBadge")

                    NSKeyedArchiver.archiveRootObject(badge, toFile: locToSave)

                    let badge = NSKeyedUnarchiver.unarchiveObjectWithFile(locToSave) as! WBadge

                    expect(badge).toNot(equal(nil))

                    // default settings from commonInit and default public properties
                    verifyCommonInit()
                }

                it("should return the intrinsic size") {
                    badge = WBadge()

                    expect(badge.intrinsicContentSize()) == CGSize(width: badge.sizeForBadge().width, height: badge.sizeForBadge().height)
                }
            }

            describe("custom property behavior") {
                it("should use the convenience init with custom properties") {
                    badge = WBadge(4)

                    // Custom properties
                    expect(badge.count) == 4
                    expect(badge.countLabel.text) == "4"
                    expect(badge.hidden) == false
                    expect(badge.lockBadgeColor) == true
                }

                it("should use the basic init and manually set custom properties") {
                    badge = WBadge()

                    badge.badgeColor = UIColor.brownColor()
                    badge.countColor = UIColor.darkGrayColor()
                    badge.borderColor = UIColor.whiteColor()
                    badge.borderWidth = 2
                    badge.horizontalAlignment = xAlignment.Right
                    badge.horizontalAlignment = xAlignment.Center
                    badge.verticalAlignment = yAlignment.Bottom
                    badge.verticalAlignment = yAlignment.Center
                    badge.automaticallyHide = false
                    badge.count = 9
                    badge.widthPadding = 20.0
                    badge.heightPadding = 15.0
                    // Change the font and size
                    badge.font = UIFont.systemFontOfSize(18)
                    // Font size should not change the font type
                    badge.fontSize = 14
                    badge.cornerRadius = 13.0

                    // Custom properties
                    expect(badge.badgeColor) == UIColor.brownColor()
                    expect(badge.countColor) == UIColor.darkGrayColor()
                    expect(badge.borderColor) == UIColor.whiteColor()
                    expect(badge.borderWidth) == 2
                    expect(badge.horizontalAlignment) == xAlignment.Center
                    expect(badge.verticalAlignment) == yAlignment.Center
                    expect(badge.automaticallyHide) == false
                    expect(badge.count) == 9
                    expect(badge.widthPadding) == 20.0
                    expect(badge.heightPadding) == 15.0
                    // Font will not be the same since it is remade when the font size is changed
                    expect(badge.fontSize) == 14.0
                    expect(badge.cornerRadius) == 13.0
                    expect(badge.hidden) == false
                }
            }

            describe("count behavior") {
                it("should increment and display correctly") {
                    badge = WBadge(-1)

                    // Should stay hidden if < 1 by default
                    expect(badge.hidden) == true

                    badge.increment()

                    expect(badge.count) == 0
                    expect(badge.countLabel.text) == "0"
                    expect(badge.hidden) == true

                    badge.increment()

                    expect(badge.count) == 1
                    expect(badge.countLabel.text) == "1"
                    expect(badge.hidden) == false
                }

                it("should decrement and display correctly") {
                    badge = WBadge(1)

                    // Should stay visible if > 0 by default
                    expect(badge.hidden) == false

                    badge.decrement()

                    expect(badge.count) == 0
                    expect(badge.countLabel.text) == "0"
                    expect(badge.hidden) == true

                    badge.decrement()

                    expect(badge.count) == -1
                    expect(badge.countLabel.text) == "-1"
                    expect(badge.hidden) == true
                }

                it("should not autohide if automaticallyHide is false") {
                    badge = WBadge(1)
                    badge.automaticallyHide = false

                    // Should stay visible if > 0 by default
                    expect(badge.hidden) == false

                    badge.decrement()

                    expect(badge.count) == 0
                    expect(badge.countLabel.text) == "0"
                    expect(badge.hidden) == false

                    badge.increment()

                    expect(badge.count) == 1
                    expect(badge.countLabel.text) == "1"
                    expect(badge.hidden) == false
                }

                it ("should not show value if showValue is false") {
                    badge = WBadge(2)
                    badge.showValue = false

                    expect(badge.hidden) == false
                    expect(badge.count) == 2
                    expect(badge.countLabel.text) == " "
                }
                
                it("should lock the badge and border color when specified") {
                    badge = WBadge(1)
                    
                    badge.badgeColor = UIColor.redColor()
                    badge.borderColor = UIColor.whiteColor()
                    
                    badge.lockBadgeColor = true
                    badge.badgeView.backgroundColor = .clearColor()
                    badge.borderView.backgroundColor = .clearColor()
                    expect(badge.badgeView.backgroundColor) == UIColor.redColor()
                    expect(badge.borderView.backgroundColor) == UIColor.whiteColor()
                    
                    badge.lockBadgeColor = false
                    badge.badgeView.backgroundColor = .clearColor()
                    badge.borderView.backgroundColor = .clearColor()
                    expect(badge.badgeView.backgroundColor) == UIColor.clearColor()                    
                    expect(badge.borderView.backgroundColor) == UIColor.clearColor()
                }
            }
        }
    }
}