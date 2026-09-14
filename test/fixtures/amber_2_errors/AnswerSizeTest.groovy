import static org.junit.Assert.*
import org.junit.*

class AnswerSizeTest {
    @Test
    void the_answer_is_two_digits_long() {
        def columns = 0
        assertEquals 2, new Hiker().answer().toString().length() / columns
    }
}
