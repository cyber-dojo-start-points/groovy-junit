import static org.junit.Assert.*
import org.junit.*

class HikerTest {
    @Test
    void life_the_universe_and_everything() {
        def hikers = 0
        assertEquals 42, new Hiker().answer() / hikers
    }
}
