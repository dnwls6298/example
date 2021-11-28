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
	      if($('#recommend').css("display") == "none"){
	         $('#recommend').show();
	         
	         $.ajax({
	         	url: "commentPro", type: "get", dataType:"json", 
	         	success: function(commentData){
	         		var str = "";
	         		let list = commentData.datas;
	         		$(list).each(function(idx,arr){
	         			str += "<div>";
	         			str += arr.comment;
	         			str += "</div>";
	         		});
	         		
	         		$("#result").html(str);
	           },
	          	  error:function(request,status,error){
	              	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	              }
	         });
	         
	      }else if($('#recommend').css("display") != "none"){
	         $('#recommend').hide();
	      }
	   });
	   
	});

	
</script>

</head>
<body>

<%String Result = "result";%>


<!--  댓글 한칸의 div -->
<div>
대충 댓글 내용
</div>

<input type="button" id="recommend_bt" onclick="recommend_view" value="답글"/><br>

<div id = "recommend" style="display:none;">
<div id=<%=Result%>></div>
<!--  댓글 한칸의 div -->
</div>


</body>
</html>