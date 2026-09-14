import static org.junit.Assert.*
import org.junit.*

class AnswerSizeTest {
    @Test
    void the_answer_is_three_digits_long() {
        assertEquals 3, new Hiker().answer().toString().length()
    }
}
