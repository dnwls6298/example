package com.wolf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wolf.domain.ACommentDTO;
import com.wolf.service.ACommentService;

@Controller
public class ACommentController {

	@Inject
	private ACommentService ACommentService;
	
	@RequestMapping(value = "/comment", method = RequestMethod.GET)
	public String commment() {
		
		return "comment";
	}
	
	@RequestMapping(value="/requestObject")
    @ResponseBody
    public Map<String,Object> commmentget() {		
		List<Map<String,String>> datalist = new ArrayList<Map<String,String>>();
		
		Map<String,String> data = null;
		
		List<ACommentDTO> ACommentdto = ACommentService.getcomments();
		
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
