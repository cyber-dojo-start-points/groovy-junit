import static org.junit.Assert.*
import org.junit.*

class FizzBuzzTest {
    @Test
    void three_is_fizz() {
        assertEquals 'Fizz', new FizzBuzz().say(3)
    }
}
