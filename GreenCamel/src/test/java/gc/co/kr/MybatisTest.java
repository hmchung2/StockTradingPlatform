package gc.co.kr;

import static org.junit.Assert.assertNotNull;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:/config/spring/spring-mvc.xml"})
public class MybatisTest {
	
	@Autowired
	private DataSource dataSource;
	
	
	@Autowired	
	private SqlSessionFactory sqlFactory;
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	
	@Ignore	
	@Test
	public void DataSourceCreatetest() throws Exception{
		System.out.println("datasource : " + dataSource);
		assertNotNull(dataSource);
	}	
	
	@Ignore
	@Test
	public void mybatisCreatetest() throws Exception{
		assertNotNull(sqlFactory);
		assertNotNull(sessionTemplate);
		
	}
	
	

	
}
