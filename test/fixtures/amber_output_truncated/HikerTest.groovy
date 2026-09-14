import static org.junit.Assert.*
import org.junit.*

class HikerTest {
    @Test
    void life_the_universe_and_everything() {
        for (int i = 0; i != 20000; i++) {
            System.out.println "debug: i is ${i}"
        }
        assertEquals 42, new Hiker().answer()
    }
}
