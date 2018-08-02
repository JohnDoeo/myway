package com.xasxt.ems.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.xasxt.ems.bean.Student;

public class ExportUtil {

	public Workbook export(String path, List<Student> list) throws IOException {
		File file = new File(path);
		InputStream in = new FileInputStream(file);
		Workbook wb = getWorkbook(path, in);
		Sheet sheet = wb.getSheet("sheet1");
		CellStyle cs = addCellStyle(wb);
		for (int j = 0; j < list.size(); j++) {
			Row row = sheet.createRow(j + 2);
			Student stu = list.get(j);
			Cell cell = row.createCell(0);
			cell.setCellValue(stu.getsName());
			cell.setCellStyle(cs);
			Cell cell1 = row.createCell(1);
			cell1.setCellValue(stu.getsName());
			cell1.setCellStyle(cs);
			Cell cell2 = row.createCell(2);
			cell2.setCellValue(stu.getSex());
			cell2.setCellStyle(cs);
			Cell cell3 = row.createCell(3);
			cell3.setCellValue(stu.getsTel());
			cell3.setCellStyle(cs);
			Cell cell4 = row.createCell(4);
			cell4.setCellValue(stu.getSchool());
			cell4.setCellStyle(cs);
			Cell cell5 = row.createCell(5);
			cell5.setCellValue(stu.getMajor());
			cell5.setCellStyle(cs);
			Cell cell6 = row.createCell(6);
			cell6.setCellValue(stu.getIdCard());
			cell6.setCellStyle(cs);
			Cell cell7 = row.createCell(7);
			cell7.setCellValue(stu.getGraduateTime());
			cell7.setCellStyle(cs);
			Cell cell8 = row.createCell(8);
			cell8.setCellValue(stu.getgName());
			cell8.setCellStyle(cs);
			Cell cell9 = row.createCell(9);
			cell9.setCellValue(stu.geteState());
			cell9.setCellStyle(cs);
			Cell cell10 = row.createCell(10);
			cell10.setCellValue(stu.getEmploymentDate());
			cell10.setCellStyle(cs);
			Cell cell11 = row.createCell(11);
			cell11.setCellValue(stu.getCompany());
			cell11.setCellStyle(cs);
			Cell cell12 = row.createCell(12);
			cell12.setCellValue(stu.getRemark());
			cell12.setCellStyle(cs);
		}
		return wb;
	}

	public CellStyle addCellStyle(Workbook wb) {
		CellStyle cs = wb.createCellStyle();
		cs.setAlignment(HorizontalAlignment.CENTER);
		cs.setBorderBottom(BorderStyle.THIN);
		cs.setBorderLeft(BorderStyle.THIN);
		cs.setBorderRight(BorderStyle.THIN);
		cs.setBorderTop(BorderStyle.THIN);

		Font font = wb.createFont();
		// font.setBold(true);
		font.setFontName("宋体");
		// font.setColor(HSSFColor.RED.index);
		cs.setFont(font);
		return cs;
	}

	public Workbook getWorkbook(String path, InputStream in) throws IOException {
		Workbook wb = null;
		if (path.equals("xls")) {// word2003
			wb = new HSSFWorkbook(in);
		} else {
			wb = new XSSFWorkbook(in);// word2007
		}
		return wb;
	}
}
