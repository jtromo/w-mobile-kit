//
//  WLabel.swift
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

import Foundation

@objc public protocol WLabelDelegate {
    optional func lineCountChanged(lineCount: Int)
}

public class WLabel: UILabel {
    public weak var delegate: WLabelDelegate?

    // Trigger on bounds change and notify the delegate of the new line count
    public override var bounds: CGRect {
        didSet {
            delegate?.lineCountChanged?(dynamicLineCount())
        }
    }
}
