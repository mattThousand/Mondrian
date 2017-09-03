let cli = CLI()

do {
    try cli.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
