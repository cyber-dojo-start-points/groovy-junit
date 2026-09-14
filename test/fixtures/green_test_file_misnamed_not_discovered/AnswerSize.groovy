import static org.junit.Assert.*
import org.junit.*

class AnswerSize {
    @Test
    void the_answer_is_nine_digits_long() {
        assertEquals 9, new Hiker().answer().toString().length()
    }
}
