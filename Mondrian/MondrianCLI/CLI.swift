//
//  CLI.swift
//  MondrianCLI
//
//  Created by Matthew Buckley on 8/22/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

public final class CLI {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {
        print(arguments[2])
    }
}
