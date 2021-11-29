<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	$(function() {
	   $('#recommend_bt').click(function() {
	      if($('#recomments').css("display") == "none"){
	         $('#recomments').show();
	         
	         pagebt(1);
	         
	         $.ajax({
		         	url: "commentCount", type: "post", dataType: "text",
		         	success: function(data){
 		         		var count = parseInt(data);
 		         		var Pagecount = 0;
 		         		if(count%2==0){
 		         			Pagecount = count/2;
 		         		}else{
 		         			Pagecount = parseInt(count/2 + 1);
 		         		}
 		         		
  		         		var str = "";
  		         			
		         		for (var i = 1 ; i<=Pagecount ; i++ ){
		         			str += "<a onclick=pagebt(";
		         			str += i;
		         			str += ") href=javascript:;>"
		         			str += i;
		         			str += "</a>";
		         		}
		         		
		         		$("#pageNumber").html(str);
		           },
		          	  error:function(request,status,error){
		              	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		              }
		         });
	         
	      }else if($('#recomments').css("display") != "none"){
	         $('#recomments').hide();
	      }
	   });
	   
/* 	   $('.recommend_bt').click(function() {
		   var tagId = $(this).attr('id');
		   alert(tagId);
	   }); */
	});

	function pagebt(a){
		alert(a);
		var page = a;
		
		$.ajax({
         	url: "commentPro", type: "get", dataType:"json", data:{"page":page},
         	success: function(commentData){
         		var str = "";
         		let list = commentData.datas;
         		
         		$(list).each(function(idx,arr){
         			str += "<div>";
         			str += arr.comment;
         			str += "</div>";
         		});
         		
         		$("#recomment").html(str);
         		
           },
          	  error:function(request,status,error){
              	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
         });
	}
	
</script>

</head>
<body>

<%String Result = "result";%>


<!--  댓글 한칸의 div -->
<div>
대충 댓글 내용
</div>

<input type="button" class="recommend_bt" id="recommend_bt" onclick="recommend_view" value="답글"/><br>

<div id = "recomments" style="display:none;">

	<div id = "recomment"></div>
	<div id = "pageNumber"></div>
</div>
<!--  댓글 한칸의 div -->

</body>
</html>