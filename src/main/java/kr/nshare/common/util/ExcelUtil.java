package kr.nshare.common.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.transformer.XLSTransformer;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelUtil {
	
	/**
	 * 
	 * @param field : 필드명
	 * @param title : excel title 에 출력될 내용
	 * @param width : cell의 사이즈
	 * @param option : 
 <pre>
 0=> 일반
 1=> 문자열     __gray__      일경우 배경gray로 표시함
 </pre>
	 * 
	 * @return
	 */
	public static HashMap getColumn(String field, String title,int width, int option)
	{
		HashMap columnHashMap = new HashMap(); 
		columnHashMap.put("column", field);
		columnHashMap.put("column_title", title);
		columnHashMap.put("column_width",getCellWidth(width));
		columnHashMap.put("option",option);
		return columnHashMap;
	}
	
	/**
	 * 컬럼 사이즈 계산용
	 * @param width
	 * @return
	 */
	public static int getCellWidth(int width)
	{
		return width*365;
	}
	
	/**
	 * excel 파일 생성 (단일 시트용)
	 * @param res
	 * @param downFileName
	 * @param sheetName
	 * @param columnList
	 * @param list
	 * @throws IOException
	 */
	public static void excelDwn(HttpServletResponse res, String downFileName, String sheetName , ArrayList<HashMap> columnList, ArrayList<HashMap> list) throws IOException
	{
		
		//1차로 workbook을 생성 
		HSSFWorkbook workbook=new HSSFWorkbook();
		//2차는 sheet생성 
		HSSFSheet sheet=workbook.createSheet(sheetName);
		
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		//엑셀의 행 
		HSSFRow row=null;
		//엑셀의 셀 
		HSSFCell cell=null;
		
		//스타일 정의
		Map<String, CellStyle> styles = createStyles(workbook);
		
		
		
		
		//title 설정
		
		
		//column 설정
		row=sheet.createRow((short)2);
		for(int j=0;j<columnList.size();j++){
			cell=row.createCell(j);
			 HashMap val = columnList.get(j);
			 cell.setCellValue(String.valueOf(val.get("column_title")));
			 cell.setCellStyle(styles.get("header"));
			 sheet.setColumnWidth(j, Integer.valueOf(String.valueOf(val.get("column_width"))));
		}
		
		
		//임의의 DB데이터 조회 
		if(list !=null &&list.size() >0){
		    int i=3;
		    for(Map mapobject : list){
		   
		    	
		    	// 시트에 하나의 행을 생성한다(i 값이 0이면 첫번째 줄에 해당) 
		        row=sheet.createRow((short)i);
		        i++;
		        
		        if(columnList !=null &&columnList.size() >0)
		        {
		        	
		        	for(int j=0;j<columnList.size();j++){
		                //생성된 row에 컬럼을 생성한다 
		                cell=row.createCell(j);
		                
		                HashMap val = columnList.get(j);
		                String value =  String.valueOf(mapobject.get(val.get("column")));
		                
		                if(val.get("option").equals("1"))
		                {
		                	//System.out.println("#########################");
//		                	System.out.println("==>"+value+"<==");
		                	if(value.equals("__gray__"))
		                	{
//		                		System.out.println("a");
		                		cell.setCellValue("");
		                		cell.setCellStyle(styles.get("gray"));
		                	}
		                	else
		                	{
//		                		System.out.println("b");
		                		cell.setCellValue(value);
		                		cell.setCellStyle(styles.get("cell"));
		                	}
//		                	System.out.println("#########################");
		                }
		                else
		                {
		                
			                cell.setCellValue(value);
			                cell.setCellStyle(styles.get("cell"));
		                }
		            }
		        }
		    }
		    
		    
		}
		res.setHeader("Content-disposition", "attachment; filename="+downFileName);
		workbook.write(res.getOutputStream());
	}
	
	/**
	 * sheet중복 체크 및 중복일때 LOOP CNT 붙임
	 * @param list
	 * @param sheetName
	 * @param loop
	 * @return
	 */
	public static String overlapCheck(ArrayList<HashMap> list, String sheetName, int loop)
	{
		int chk = 0;
		for(int i = 0;i<list.size();i++)
		{
			HashMap hm = list.get(i);
			String sheetNameOri = (String) hm.get("sheetName");
			if(sheetNameOri.equals(sheetName))
			{
				chk++;
			}
		}
		
		if(chk>1)
		{
			sheetName = sheetName + "_"+loop;
		}
		return sheetName;
	}
	
	/**
	 * 멀티 시트용
	 * @param res
	 * @param downFileName
	 * @param list : sheetName:Stirng , columnList:ArrayList<HashMap>, list:ArrayList<HashMap>
	 * @throws IOException
	 */
	public static void excelDwnMuitiSheet(HttpServletResponse res, String downFileName, ArrayList<HashMap> list) throws IOException
	{
		HSSFWorkbook workbook=new HSSFWorkbook();
		//String sheetName , ArrayList<HashMap> columnList,
		for(int i=0;i<list.size();i++)
		{
			HashMap hm = list.get(i);
			String sheetName = (String) hm.get("sheetName");
			
			//시트의 중복 이름 변경
			sheetName = overlapCheck(list, sheetName,i);
			
			ArrayList<HashMap> columnList = (ArrayList<HashMap>) hm.get("columnList");
			ArrayList<HashMap> dataList = (ArrayList<HashMap>) hm.get("list");
						
			//System.out.println("sheetName==>"+sheetName);
			//System.out.println("columnList size"+columnList.size());
			//System.out.println("size=>"+dataList.size());
			
			HSSFSheet sheet=workbook.createSheet(sheetName);
			
			HSSFCellStyle cellStyle = workbook.createCellStyle();
			//엑셀의 행 
			HSSFRow row=null;
			//엑셀의 셀 
			HSSFCell cell=null;
			
			//스타일 정의
			Map<String, CellStyle> styles = createStyles(workbook);
			
			//column 설정
			row=sheet.createRow((short)2);
			for(int j=0;j<columnList.size();j++){
				cell=row.createCell(j);
				 HashMap val = columnList.get(j);
				 cell.setCellValue(String.valueOf(val.get("column_title")));
				 cell.setCellStyle(styles.get("header"));
				 sheet.setColumnWidth(j, Integer.valueOf(String.valueOf(val.get("column_width"))));
			}
			
			
			//임의의 DB데이터 조회 
			if(dataList !=null &&dataList.size() >0){
			    int k=3;
			    for(Map mapobject : dataList){
			   
			    	
			    	// 시트에 하나의 행을 생성한다(i 값이 0이면 첫번째 줄에 해당) 
			        row=sheet.createRow((short)k);
			        k++;
			        
			        if(columnList !=null &&columnList.size() >0)
			        {
			        	
			        	for(int m=0;m<columnList.size();m++){
			                //생성된 row에 컬럼을 생성한다 
			                cell=row.createCell(m);
			                
			                HashMap val = columnList.get(m);
			                String value =  String.valueOf(mapobject.get(val.get("column")));
			                
			                String option = val.get("option").toString();
			                
			               
			                
			                if(option.equals("1"))
			                {
			                	//System.out.println("#########################");
			                	//System.out.println("a===>"+value+"<===");
			                	if(value.contains("__gray__"))
			                	{
			                		//System.out.println("a");
			                		cell.setCellValue("");
			                		cell.setCellStyle(styles.get("gray"));
			                	}
			                	else
			                	{
			                		
			                		cell.setCellValue(value);
			                		cell.setCellStyle(styles.get("cell"));
			                	}
			                	//System.out.println("#########################");
			                }
			                else
			                {
				                cell.setCellValue(value);
				                cell.setCellStyle(styles.get("cell"));
			                }
			            }
			        }
			    }
			    
			    
			}
			
		}
		res.setHeader("Content-disposition", "attachment; filename="+downFileName);
		workbook.write(res.getOutputStream());
	}
	/**
	 * poi 셀 스타일
	 * @param wb
	 * @return
	 */
	private static Map<String, CellStyle> createStyles(Workbook wb){
        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short)18);
        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFont(titleFont);
        styles.put("title", style);

        Font monthFont = wb.createFont();
        monthFont.setFontHeightInPoints((short)11);
        monthFont.setColor(IndexedColors.WHITE.getIndex());
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(monthFont);
        style.setWrapText(true);
        
        styles.put("header", style);

        style = wb.createCellStyle();
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setWrapText(true);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        
        styles.put("cell", style);
        
        Font alert_Font = wb.createFont();
        alert_Font.setFontHeightInPoints((short)11);
        alert_Font.setColor(IndexedColors.RED.getIndex());
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setWrapText(true);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setFont(alert_Font);
        styles.put("alert_cell", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("formula", style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("formula_2", style);

        monthFont.setFontHeightInPoints((short)11);
        monthFont.setColor(IndexedColors.WHITE.getIndex());
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(monthFont);
        style.setWrapText(true);
        styles.put("gray", style);
        
        return styles;
    }
	
	public static ArrayList<HashMap> convertFileStreamToArrayList(FileInputStream fis)
	{
		ArrayList<HashMap> list = new ArrayList<HashMap>();
		
		//파일을 읽기위해 엑셀파일을 가져온다 
	
		HSSFWorkbook workbook = null;
		
		try{
		workbook=new HSSFWorkbook(fis);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		int rowindex=0;
		int columnindex=0;
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		HSSFSheet sheet=workbook.getSheetAt(0);
		int rows=sheet.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows+1;rowindex++)
		{
			HashMap hm = new HashMap();
			HSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		    	int cells=row.getPhysicalNumberOfCells();
		        for(columnindex=0;columnindex<=cells;columnindex++)
		        {
		        	//셀값을 읽는다
		            HSSFCell cell=row.getCell(columnindex);
		            
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		                //타입별로 내용 읽기
		                switch (cell.getCellType()){
		                case HSSFCell.CELL_TYPE_FORMULA:
		                    value=cell.getCellFormula();
		                    break;
		                case HSSFCell.CELL_TYPE_NUMERIC:	
		                	cell.setCellType( HSSFCell.CELL_TYPE_STRING );
		            		value = cell.getStringCellValue();
		                //	value=""+cell.getNumericCellValue();
		                    break;
		                case HSSFCell.CELL_TYPE_STRING:
		                    value=cell.getStringCellValue()+"";
		                    break;
		                case HSSFCell.CELL_TYPE_BLANK:
		                    value=cell.getBooleanCellValue()+"";
		                    break;
		                case HSSFCell.CELL_TYPE_ERROR:
		                    value=cell.getErrorCellValue()+"";
		                    break;
		                }
		               
		            }
		            hm.put(String.valueOf(columnindex), value);
		        }
		       
	           
	            list.add(hm);
		        
		    }
		    
		}
		
		return list;
	}
	
	/**
	 * 템플릿 읽고 쓰기
	 * @param res
	 * @param downFileName
	 * @param list : sheetName:Stirng , columnList:ArrayList<HashMap>, list:ArrayList<HashMap>
	 * @throws IOException
	 */
	public static void readExcelDwnSingleSheet(HttpServletResponse res, String downFileName, HashMap hm) throws IOException
	{
		String tempPath = EgovProperties.getProperty("Globals.Excel.template");
        
        // 별도로 다운로드 만들기 귀찮으까 이런식으로 만들어서 바로 엑셀 생성후 다운 받게 
        try {
 
            InputStream is = new BufferedInputStream(new FileInputStream(tempPath));
            XLSTransformer xls = new XLSTransformer();
                        
            Workbook workbook = xls.transformXLS(is, hm);
                        
            res.setHeader("Content-Disposition", "attachment; filename=\"" + downFileName );
            OutputStream os = res.getOutputStream();
            workbook.write(os);
            
        } catch (Exception e) {
            e.printStackTrace();
        }

		
	}
}
