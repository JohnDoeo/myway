package com.xasxt.ems.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
public class ImportUtil {

	 @SuppressWarnings("resource")
	public List<List<Object>> importExcel(InputStream in,String backname) throws IOException{
		 Workbook wb = null;
		    if(backname.equals("xls")){//word2003
		    	wb = new HSSFWorkbook(in);
		    }else{
		        wb = new XSSFWorkbook(in);//word2007
		    }
		    Sheet sheet = null;
		    Row row = null;
		    List<List<Object>> list = new ArrayList<List<Object>>();
		int sheetNum = wb.getNumberOfSheets();
		    for(int i=0;i<sheetNum;i++){
		    	  sheet = wb.getSheetAt(i);
		    	  if(sheet==null){
		    		 continue; 
		    	  }
		    	 
		    	int firstrow =  sheet.getFirstRowNum();
		    	int lastrow  =  sheet.getLastRowNum()+1;
		        for(int j =firstrow+2;j<lastrow;j++){
		        	  row = sheet.getRow(j);
		        	  if(row==null||row.getFirstCellNum()==j){
		        		  continue;
		        	  }
		        	
		        	  List<Object> li = new ArrayList<Object>();
		        	  int firstcell = row.getFirstCellNum();
		        	  int lastcell = row.getLastCellNum();
		        	  for(int y=firstcell;y<lastcell;y++){
		        		     String val = (getCellValue(row.getCell(y))).replace(" ","");
		        		     li.add(val);
		        	  }
		        	  list.add(li);
		        }  
		    }
		    
		   return list;
	 }
	 
	 @SuppressWarnings("deprecation")
	public String getCellValue(Cell cell){
		  String value = "";
		  cell.setCellType(XSSFCell.CELL_TYPE_STRING);  
		  value  =  cell.getStringCellValue();
		return value;
	}
}
