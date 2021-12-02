package com.wolf.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wolf.domain.ACommentDTO;
import com.wolf.domain.ACommentPageDTO;
import com.wolf.service.ACommentService;

@Controller
public class ACommentController {

	@Inject
	private ACommentService ACommentService;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/comment", method = RequestMethod.GET)
	public String commment(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("id","wolf");
		
		return "comment";
	}
	
	@RequestMapping(value="/commentPro")
    @ResponseBody
    public Map<String,Object> commmentget(@RequestParam Integer page) {		
		List<Map<String,String>> datalist = new ArrayList<Map<String,String>>();
		
		Map<String,String> data = null;
		
		ACommentPageDTO PageDTO = new ACommentPageDTO();
		PageDTO.setPage((page-1)*3); PageDTO.setPagesize(3);
		List<ACommentDTO> ACommentdto = ACommentService.getcomments(PageDTO);
		
		for(ACommentDTO s : ACommentdto) {
			data = new HashMap<String, String>();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
			
			data.put("memid",s.getMemId());
			data.put("star",Integer.toString(s.getStar()));
			data.put("comment",s.getComment());
			data.put("commentNum",Integer.toString(s.getCommentNum()));
			data.put("commentTime",simpleDateFormat.format(s.getDate()));
			data.put("picture", s.getPicture());
			
			datalist.add(data);
		}
		
		Map<String , Object> ACommmentDatas = new HashMap<String, Object>();
		ACommmentDatas.put("datas", datalist);
		
        return ACommmentDatas;
    }
	
	@RequestMapping(value="/commentCount")
	@ResponseBody
	public String commentcount() {
		return Integer.toString(ACommentService.getcommentCount());
	}
	
	@RequestMapping(value="/commentSerialize")
	public void commentSerialize(ACommentDTO ACommentdto) {
		ACommentService.insertcomment(ACommentdto);
	}

	@RequestMapping(value="/recommentPro")
	@ResponseBody
    public Map<String,Object> recommmentget(@RequestParam Integer commentNum , @RequestParam Integer page) {		
		List<Map<String,String>> datalist = new ArrayList<Map<String,String>>();
		
		Map<String,String> data = null;
		
		ACommentPageDTO PageDTO = new ACommentPageDTO();
		PageDTO.setPage((page-1)*3); PageDTO.setPagesize(3); PageDTO.setCommentNum(commentNum);
		List<ACommentDTO> ACommentdto = ACommentService.getrecomments(PageDTO);
		
		for(ACommentDTO s : ACommentdto) {
			data = new HashMap<String, String>();
			data.put("recomment",s.getComment());
			
			datalist.add(data);
		}
		
		Map<String , Object> ACommmentDatas = new HashMap<String, Object>();
		ACommmentDatas.put("datas", datalist);
		
        return ACommmentDatas;
    }
	
	@RequestMapping(value="/recommentCount")
	@ResponseBody
	public String recommentcount(@RequestParam Integer commentNum) {
		ACommentPageDTO PageDTO = new ACommentPageDTO();
		PageDTO.setCommentNum(commentNum);
		return Integer.toString(ACommentService.getrecommentCount(PageDTO));
	}
	
	@RequestMapping(value="/recommentSerialize")
	public void recommentSerialize(ACommentDTO ACommentdto) {
		ACommentService.insertRecomment(ACommentdto);
	}
	
	@RequestMapping(value="upload", method = RequestMethod.POST , consumes= {"multipart/form-data"})
	public void upload(MultipartFile file) throws IOException {
		
		UUID uid = UUID.randomUUID();
		String fileName = uid.toString()+"_"+file.getOriginalFilename();
		
		File targetFile = new File(uploadPath,fileName);
		FileCopyUtils.copy(file.getBytes(),targetFile);
		
		ACommentDTO acommentdto = new ACommentDTO();
		acommentdto.setPicture(fileName);
		ACommentService.insertPiture(acommentdto);
	}
}
