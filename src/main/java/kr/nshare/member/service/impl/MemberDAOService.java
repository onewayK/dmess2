package kr.nshare.member.service.impl;

import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.member.service.MemberVO;
import kr.nshare.member.service.mapper.MemberMapper;
import kr.nshare.system.service.SystemVO;

import org.springframework.stereotype.Service;
@Service("memberDAOService")
public class MemberDAOService extends AbstractDAO implements MemberDAO {

	
	@Override
	public int selectLoginCheck(MemberVO vo) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectLoginCheck(vo);
	}

	@Override
	public void insertMemberLog(MemberVO vo) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		mapper.insertMemberLog(vo);
	}

	@Override
	public List<SystemVO> selectMemberLogList(SystemVO vo) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMemberLogList(vo);
	}

	@Override
	public int selectMemberLogListCnt(SystemVO vo) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMemberLogListCnt(vo);
	}

	/**
	 * 접속 로그 삭제
	 */
	@Override
	public void deleteMemberLogByMemberCode(String code) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		mapper.deleteMemberLogByMemberCode(code);
	}
	
	@Override
	public List<MemberVO> selectMemberInstitutionList(MemberVO vo) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMemberInstitutionList(vo);
	}

	@Override
	public List<MemberVO> selectMemberInstitutionListAndTemplate(MemberVO vo) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMemberInstitutionListAndTemplate(vo);
	}
	
	@Override
	public List<MemberVO> selectMemberByInstitutionCode(String code) throws Exception {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMemberByInstitutionCode(code);
	}
}
