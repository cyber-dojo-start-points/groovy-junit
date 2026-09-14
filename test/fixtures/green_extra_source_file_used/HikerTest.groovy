import static org.junit.Assert.*
import org.junit.*

class HikerTest {
    @Test
    void life_the_universe_and_everything() {
        assertEquals 42, new Hiker().answer()
    }

    @Test
    void the_answer_is_two_digits_long() {
        assertEquals 2, new Hiker().digitsInAnswer()
    }
}
