//
//  AccountFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import DemocracySwiftUI
import Foundation
import SharedSwiftUI

enum AccountFlow: Int, UserInputFlow {
    case username = 0
    case email
    case password
    case phone
    case acceptTerms
    
    static var flowTitle: String = "Account"
    
    var title: String {
        switch self {
        case .username: "Create a Username"
        case .password: "Create a Password"
        case .email: "Add Your Email"
        case .phone: "Add Your Phone Number"
        case .acceptTerms: "Agree to Democracy's Terms and Conditions"
        }
    }
    
    var subtitle: String {
        switch self {
        case .username:
            "Create a unique username for your account."
            
        case .password:
            "Create a password that meets the password requirements listed below."
            
        case .email:
            "Add a primary email for your account."
            
        case .phone:
            "Add a phone number to receive SMS notifications."
            
        case .acceptTerms:
            """
            By tapping I agree, you agree to create an
            account and to Democracy's terms and privacy policy.
            """
        }
    }
    
    var canGoBack: Bool {
        switch self {
        case .email, .password, .phone, .acceptTerms:
            true
        case .username:
            false
        }
    }
}

// MARK: - PasswordCaseRepresentable
extension AccountFlow: PasswordCaseRepresentable {
    
    var isPasswordCase: Bool {
        switch self {
        case .username, .email, .phone, .acceptTerms:
            false
        case .password:
            true
        }
    }
    
    static var passwordCase: AccountFlow {
        Self.password
    }
}
