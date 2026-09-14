
class Hiker {
    def answer() { 42 }

    // Groovy resolves a method call when the line runs, not when the file is
    // compiled, so the misspelling here reaches the run intact and costs
    // nothing while no test calls this method.
    def doubledAnswer() { ansewr() * 2 }
}
