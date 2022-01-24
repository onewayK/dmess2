package kr.nshare.common;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 
 * @author kwongunbo
 *
 */
public abstract class AbstractDAO {
	@Autowired
	@Resource(name="sqlSession")
	public SqlSession sqlSession;
}
