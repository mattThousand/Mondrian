//
//  MondrianError.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/15/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation

public enum MondrianError: Error {
    
    case partition(String)

    /// Triggers a fatal error
    ///
    /// - parameter errorMessage: an error message string
    ///
    static func fail(withErrorMessage errorMessage: String = "Something went wrong. Sorry!") -> Never  {
        fatalError(errorMessage)
    }
}
