//
//  FocusingViewDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/8/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

/// The object that acts as the delegate of the focusing view.
///
/// The delegate must adopt the FocusingViewDelegate protocol.
///
/// The delegate object is responsible for managing the focusing view focus state.
protocol FocusingViewDelegate: class {
    
    /// Tells the delegate that the view became focused.
    ///
    /// - Parameters:
    ///     - focusingView: An object informing the delegate that view became focused.
    func focusingViewDidBecomeFocused(_ focusingView: FocusingView)
    
    /// Tells the delegate that the view resign the focus.
    ///
    /// - Parameters:
    ///     - focusingView: An object informing the delegate that view resign focus.
    func focusingViewDidResignedFocus(_ focusingView: FocusingView)
}
