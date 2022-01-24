package kr.nshare.block_exclude;

import javax.inject.Inject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;

/**
 * packageName              : java.kr.nshare.block_exclude           <p>
 * <p>
 * fileName                 : BlockExcludeTest
 * <p>
 * author                   : USER
 * <p>
 * date                     : 2021-12-14
 * <p>
 * description :
 * <p>
 * ===========================================================
 * <p>
 * DATE              AUTHOR                        NOTE
 * <p>
 * -----------------------------------------------------------
 * <p>
 * 2021-12-14            USER                      최초 생성
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
    "file:WEB-INF/spring/appServlet/servlet-context.xml",
    "file:WEB-INF/spring/*.xml"
})
@WebAppConfiguration
public class BlockExcludeTest {

    @Inject
    private WebAppConfiguration wac;

    private MockMvc mockMvc;

    @Test
    public void test(){
        System.out.println("hello");
    }

}
