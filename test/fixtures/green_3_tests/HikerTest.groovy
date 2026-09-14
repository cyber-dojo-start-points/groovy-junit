import static org.junit.Assert.*
import org.junit.*

class HikerTest {
    @Test
    void life_the_universe_and_everything() {
        assertEquals 42, new Hiker().answer()
    }

    @Test
    void the_answer_is_even() {
        assertEquals 0, new Hiker().answer() % 2
    }

    @Test
    void the_hiker_is_called_arthur() {
        assertEquals 'Arthur Dent', new Hiker().name()
    }
}
