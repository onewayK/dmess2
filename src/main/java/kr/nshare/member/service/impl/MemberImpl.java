package kr.nshare.member.service.impl;

import java.util.List;

import kr.nshare.member.service.MemberVO;
import kr.nshare.system.service.SystemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("memberImpl")
public class MemberImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAOService;
	
	/**
	 * 사용자 로그인 정보 체크
	 */
	@Override
	public int selectLoginCheck(MemberVO vo) throws Exception
	{
		String pass = "";
		vo.setUserpw(pass);
		return memberDAOService.selectLoginCheck(vo);
	}

	/**
	 * 사용자 로깅 정보 저장
	 */
	@Override
	public void insertMemberLog(MemberVO vo) throws Exception {
		memberDAOService.insertMemberLog(vo);
	}

	/**
	 * 사용자 접속로그  삭제
	 */
	@Override
	public void deleteMemberLogByMemberCode(String code) throws Exception {
		
		memberDAOService.deleteMemberLogByMemberCode(code);
	}
	
	@Override
	public List<SystemVO> selectMemberLogList(SystemVO vo) throws Exception {
		return memberDAOService.selectMemberLogList(vo);
	}

	@Override
	public int selectMemberLogListCnt(SystemVO vo) throws Exception {
		return memberDAOService.selectMemberLogListCnt(vo);
	}

	@Override
	public List<MemberVO> selectMemberInstitutionList(MemberVO vo) throws Exception {
		return memberDAOService.selectMemberInstitutionList(vo);
	}

	@Override
	public List<MemberVO> selectMemberInstitutionListAndTemplate(MemberVO vo) throws Exception {
		return memberDAOService.selectMemberInstitutionListAndTemplate(vo);
	}
	
	@Override
	public List<MemberVO> selectMemberByInstitutionCode(String code) throws Exception {
		return memberDAOService.selectMemberByInstitutionCode(code);
	}
	
}
