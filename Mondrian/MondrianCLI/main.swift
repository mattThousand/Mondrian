//
//  main.swift
//  MondrianCLI
//
//  Created by Matthew Buckley on 9/10/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

let cli = CLI()

do {
    try cli.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
