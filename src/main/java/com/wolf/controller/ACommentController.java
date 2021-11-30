package com.wolf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wolf.domain.ACommentDTO;
import com.wolf.domain.ACommentPageDTO;
import com.wolf.service.ACommentService;

@Controller
public class ACommentController {

	@Inject
	private ACommentService ACommentService;
	
	@RequestMapping(value = "/comment", method = RequestMethod.GET)
	public String commment() {
		
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
			data.put("comment",s.getComment());
			data.put("commentNum",Integer.toString(s.getCommentNum()));
			
			datalist.add(data);
		}
		
		Map<String , Object> ACommmentDatas = new HashMap<String, Object>();
		ACommmentDatas.put("datas", datalist);
		
        return ACommmentDatas;
    }
	
	@RequestMapping(value="/commentCount")
	@ResponseBody
	public String recommentcount() {
		return Integer.toString(ACommentService.getRecommentCount());
	}
	
	@RequestMapping(value="/recommentSerialize")
	public void recommentSerialize(ACommentDTO ACommentdto) {
		ACommentService.insertRecomment(ACommentdto);
	}

	@RequestMapping(value="/recommentPro")
	@ResponseBody
    public Map<String,Object> recommmentget(@RequestParam Integer commentNum) {		
		List<Map<String,String>> datalist = new ArrayList<Map<String,String>>();
		
		Map<String,String> data = null;
		
		ACommentPageDTO PageDTO = new ACommentPageDTO();
		PageDTO.setPage((commentNum-1)*3); PageDTO.setPagesize(3);
		List<ACommentDTO> ACommentdto = ACommentService.getcomments(PageDTO);
		
		for(ACommentDTO s : ACommentdto) {
			data = new HashMap<String, String>();
			data.put("comment",s.getComment());
			
			datalist.add(data);
		}
		
		Map<String , Object> ACommmentDatas = new HashMap<String, Object>();
		ACommmentDatas.put("datas", datalist);
		
        return ACommmentDatas;
    }
}
