/**
 * 
 */
/**
 * @author +impro
 *
 */
package kr.nshare.member.service.mapper;
 

import java.util.List;

import kr.nshare.member.service.MemberVO;
import kr.nshare.system.service.SystemVO;

public interface MemberMapper{
		public int selectLoginCheck(MemberVO vo) throws Exception;
		
		//로깅정보 저장
		public void insertMemberLog(MemberVO vo) throws Exception;
		
		
		//접속로그 출력
		public List<SystemVO> selectMemberLogList(SystemVO vo) throws Exception;
		public int selectMemberLogListCnt(SystemVO vo) throws Exception;
		
		//접속로그 삭제
		public void deleteMemberLogByMemberCode(String code) throws Exception;
		
		
		//사용자에 해당하는 기관 리스트 목록변환(훈련)
		public List<MemberVO> selectMemberInstitutionList(MemberVO vo)  throws Exception;
		
		//사용자에 해당하는 기관 리스트 목록변환(템플릿)
		public List<MemberVO> selectMemberInstitutionListAndTemplate(MemberVO vo)  throws Exception;
		
		//기관에 속한 모든 계정 code 불러오기
		public List<MemberVO> selectMemberByInstitutionCode(String code)  throws Exception;
}