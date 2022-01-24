/**
 * 
 */
/**
 * @author +impro
 *
 */
package kr.nshare.main.mapper;

import java.util.ArrayList;

import kr.nshare.member.service.MemberVO;

public interface TestTblMapper{
	public ArrayList<TestTbl> getTestTbl();
	public MemberVO loginCheck(MemberVO mt);
}