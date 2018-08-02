package com.xasxt.ems.web;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.xasxt.ems.bean.Grade;
import com.xasxt.ems.bean.Student;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.StudentService;
import com.xasxt.ems.utils.ExportUtil;
import com.xasxt.ems.utils.ImportUtil;

@RestController
public class StudentController {

	@Autowired
	private StudentService studentService;
	
	@RequestMapping("findStudentWithPage")
	public Map<String,Object> findStudentWithPage(int page,int rows,String sex,String sName,String gName,String eState){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		map.put("sex", sex);
		map.put("sName", sName);
		map.put("gName", gName);
		map.put("eState", eState);
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("rows", studentService.findStudentWithPage(map));
		result.put("total", studentService.getStudentCount());
		return result;
	}
	
	@RequestMapping("getGradeList")
	public List<Grade> getGradeList(){
		return studentService.getGradeList();
	}
	
	@RequestMapping("importStudentInfo")
	public String importStudentInfo(@RequestParam("stuinfo") CommonsMultipartFile file,
			HttpServletRequest request) throws IOException{
		Subject subject=SecurityUtils.getSubject();
		Session session=subject.getSession();
		User user=(User)session.getAttribute("user");
		int flag=0;
		try {
			String filename = file.getOriginalFilename();
			int index = filename.lastIndexOf(".");
			String backname = filename.substring(index+1,filename.length());
			InputStream in = file.getInputStream();
			List<List<Object>> list = new ImportUtil().importExcel(in, backname);

			for(int i=0;i<list.size();i++){
				Student student = new Student();
				student.setuId(user.getuId());
				student.setsNum(list.get(i).get(0).toString());
				student.setsName(list.get(i).get(1).toString());
				student.setSex(list.get(i).get(2).toString());
				student.setsTel(list.get(i).get(3).toString());
				student.setSchool(list.get(i).get(4).toString());
				student.setMajor(list.get(i).get(5).toString());
				student.setIdCard(list.get(i).get(6).toString());
				student.setGraduateTime(list.get(i).get(7).toString());
				String gName = list.get(i).get(8).toString();
				student.setgName(list.get(i).get(8).toString());
				student.seteState(list.get(i).get(9).toString());
				student.setEmploymentDate(list.get(i).get(10).toString());
				student.setCompany(list.get(i).get(11).toString());
				student.setRemark(list.get(i).get(12).toString());
				int gradeId = studentService.getGradeIdByName(gName);
				student.setGradeId(gradeId);
				flag = studentService.addStudentInfo(student);
				if(flag==0){
					return "-1";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}
	
	@RequestMapping("addStudentInfo")
	public int addStudentInfo(Student student){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		student.setuId(user.getuId());
		int flag = 0;
		try {
			flag = studentService.addStudentInfo(student);
		} catch (Exception e) {
			return -1;
		}
		return flag;
	}
	
	@RequestMapping("exportStudentInfo")
	public void exportStudentInfo(HttpServletRequest request,HttpServletResponse response,String sName,String gName,String sex,int sIds[]) throws IOException{
		try {
			 List<Student> list = null; 
				if(sIds != null && sIds.length>0){
					list = new ArrayList<Student>();
					for(int sId : sIds){
						Student student = studentService.getStudentById(sId);
						list.add(student);
					}
				} else {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("page", null);
					map.put("rows", null);
					map.put("sName", sName);
					map.put("gName", gName);
					map.put("sex", sex);
					list = studentService.findStudentWithPage(map);
				}
				String path = request.getSession().getServletContext().getRealPath("/")+"\\userFile\\学生信息.xlsx";
			    Workbook wb = new ExportUtil().export(path, list);
			    response.setContentType("application/x-msdownload;");
				response.setHeader("Content-disposition", "attachment; filename="+ new String("学生信息.xlsx".getBytes("utf-8"), "ISO8859-1"));
				OutputStream out = response.getOutputStream();
				wb.write(out);
				out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("getStudentInfoById")
	public Student getStudentInfoById(int sId){
		return studentService.getStudentById(sId);
	}
	
	@RequestMapping("delStudentInfo")
	public boolean delStudentInfo(@RequestParam("sIds[]")int sIds[]){
		boolean flag = false;
		for(int sId : sIds){
			if(studentService.delStudentInfo(sId)!=0)
				flag = true;
		}
		return flag;
	}
	
	@RequestMapping("editStudentInfo")
	public int editStudentInfo(Student student){
		if(student.geteState()==null || student.geteState().equals("")){
			Student student2 = getStudentInfoById(student.getsId());
			student.setEmploymentDate(student2.getEmploymentDate());
			student.setCompany(student2.getCompany());
			student.seteState(student2.geteState());
		}
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		student.setuId(user.getuId());
		int flag = 0;
		try {
			flag = studentService.editStudentInfo(student);
		} catch (Exception e) {
			return -1;
		}
		return flag;	
	}
	
	@RequestMapping("getJobCount")
	public Map<String,Object> getJobCount(String flag){
		Map<String,Object> result = new HashMap<String,Object>();
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		List<Student> list = studentService.getStudentListForState(); 
		List<String> nameList = new ArrayList<String>();
		List<String> countList = new ArrayList<String>();
			if(flag.equals("zhu")){
				for(Student student : list){
					nameList.add(student.geteState());
					countList.add(student.getCount()+"");
				}
				result.put("nameList", nameList);
				result.put("countList", countList);
			} else if (flag.equals("bing")){
				for(Student student : list){
					Map<String,Object> map = new HashMap<String,Object>();
					nameList.add(student.geteState());
					map.put("name", student.geteState());
					map.put("value", student.getCount());
					dataList.add(map);
				}
				result.put("nameList", nameList);
				result.put("dataList", dataList);
			} else if(flag.equals("zhu1")){
				List<String> manList = new ArrayList<String>();
				List<String> womenList = new ArrayList<String>();
				for(Student student : list){
					nameList.add(student.geteState());
					String[] sexs = student.getSexs().split(",");
					int man=0;
					int women=0;
					for(String sex : sexs){
						if(sex.equals("男")){
							man++;
						}else{
							women++;
						}
					}
					manList.add(man+"");
					womenList.add(women+"");
				}
				result.put("manList", manList);
				result.put("womenList", womenList);
				result.put("nameList", nameList);
			}
		return result;
	}
	
}
