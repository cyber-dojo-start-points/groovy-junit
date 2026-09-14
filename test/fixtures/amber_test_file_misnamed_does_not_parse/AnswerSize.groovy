import static org.junit.Assert.*
import org.junit.*

class AnswerSize {
    @Test
    void the_answer_is_two_digits_long() {
        assertEquals 2, new Hiker().answer().toString().length()
}
