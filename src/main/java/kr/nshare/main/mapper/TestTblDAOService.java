package kr.nshare.main.mapper;

import java.util.ArrayList;

import kr.nshare.common.AbstractDAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
@Service("TestTblDAOService")
public class TestTblDAOService extends AbstractDAO  implements TestTblDAO{
	@Override
	public ArrayList<TestTbl> getTestTbl() {
		ArrayList<TestTbl> result = new ArrayList<TestTbl>();
		TestTblMapper mapper = sqlSession.getMapper(TestTblMapper.class);
		result = mapper.getTestTbl();
		return result;
	}

	
}
