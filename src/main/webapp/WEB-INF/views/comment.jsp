<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	$(function() {//첫 페이지 로딩시
		var	id = '<%=(String)session.getAttribute("id")%>';
		
		if(id == "null"){
 			$('#comment_box').hide();
 		}else{
			$.ajax({
				url:"checkcomment" , type:"post" , dataType:"json", data:{"memid":id} ,
				success: function(commentData){
					var str = "";
	         		let list = commentData.datas;
	         		
	         		if(list!=""){
	         			$(list).each(function(idx,arr){
 	         			
		         			for(var i = 1 ; i <= arr.star ; i++){
		         				str += "<img class=starpic alt='' src=${pageContext.request.contextPath}/resources/images/yellowStar.png>";
		         			}
		         			for(var i = 1 ; i <= 5-arr.star ; i++){
		         				str += "<img class=starpic alt='' src=${pageContext.request.contextPath}/resources/images/grayStar.png>";
		         			}
		         			str += arr.commentTime;
		         			str += "<div>(";
		         			str += arr.memid;
		         			str += ")";
			       			str += "<span class=editbutton ><button onclick=deletecomment(";
			       			str += arr.commentNum;
			       			str += ")>삭제</button><button onclick=updatecomment("
			       			str += arr.commentNum;		
			       			str += ")>수정</button></span></div>";
			       			if(arr.picture != null){
			       				str += "<img class=commentpic alt='' src=${pageContext.request.contextPath}/resources/images/comment_picture/";
			         			str += arr.picture;
			         			str += ">";
			       			}
			       			str += "<div>";
		         			str += arr.comment;
		         			str += "</div>";
	         			});
	         			
	         			$("#comment_box").html(str);
	         			
	         		}
				},
				error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
 		}
		
		pagebt(1); // 1페이지 눌렀을 때 함수 호출
		pageCreate(1); // 1번째 칸의 페이지 함수 호출
		
		//별점
		var ystar = 'url("${pageContext.request.contextPath}/resources/images/yellowStar.png")';
		var gstar = 'url("${pageContext.request.contextPath}/resources/images/grayStar.png")';
		 
		$('#star1').hover(function() {
			
			$('#star1').css('background-image', ystar);
			$('#star2').css('background-image', gstar);
			$('#star3').css('background-image', gstar);
			$('#star4').css('background-image', gstar);
			$('#star5').css('background-image', gstar);
			$('#star').val(1);
		});
		
		$('#star2').hover(function() {
			$('#star1').css("background-image", ystar);
			$('#star2').css("background-image", ystar);
			$('#star3').css("background-image", gstar);
			$('#star4').css("background-image", gstar);
			$('#star5').css("background-image", gstar);
			$('#star').val(2);
		});
		
		$('#star3').hover(function() {
			$('#star1').css("background-image", ystar);
			$('#star2').css("background-image", ystar);
			$('#star3').css("background-image", ystar);
			$('#star4').css("background-image", gstar);
			$('#star5').css("background-image", gstar);
			$('#star').val(3);
		});
		
		$('#star4').hover(function() {
			$('#star1').css("background-image", ystar);
			$('#star2').css("background-image", ystar);
			$('#star3').css("background-image", ystar);
			$('#star4').css("background-image", ystar);
			$('#star5').css("background-image", gstar);
			$('#star').val(4);
		});
		
		$('#star5').hover(function() {
			$('#star1').css("background-image", ystar);
			$('#star2').css("background-image", ystar);
			$('#star3').css("background-image", ystar);
			$('#star4').css("background-image", ystar);
			$('#star5').css("background-image", ystar);
			$('#star').val(5);
		});
		
	});

	function insertcomment(){ //댓글 작성버튼을 눌렀을 때
		
		var fileForm = /(.*?)\.(jpg|jpeg|png)$/;
		var imgfile = $('#file').val();
	
		
		if(checkNull($('#comment').val())){
			alert("댓글을 입력해 주세요");
		}else if($('#star').val()=="0"){
			alert("별점을 선택해 주세요");
		}else{
			if(imgfile!=""){ 
				if(!imgfile.match(fileForm)) {
			    	alert("jpg,png 파일만 업로드 가능");
			    }else{
			    	var form = $("#commentPicture_subform")[0];
					var formData = new FormData(form);
					
					$.ajax({
						url:"commentSerialize", type:"post", data:$("#comment_subform").serialize(), async: false,

						success: function(){},
						error:function(request,status,error){
				           	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
					
					$.ajax({
						url:"upload", type:"post", data:formData, enctype: "multipart/form-data", async: false,
						processData: false,contentType: false, cache: false, timeout: 300000,
						success: function(){},
						error:function(request,status,error){
						}
					});
			    }
			}else{
				$.ajax({
					url:"commentSerialize", type:"post", data:$("#comment_subform").serialize(), async: false,

					success: function(){},
					error:function(request,status,error){
					}
				});
			}
		}	
	}
	
	function insertrecomment(id){ //답글 작성 버튼을 눌렀을 때
		var str="#";
		var subid = $(id).closest('form').attr('id'); //data로 보낼 form 태그 추출 (해당 버튼의 가까운'form'태그의 id)
		str += subid; 

		$.ajax({
			url:"recommentSerialize" , type:"post" , data:$(str).serialize(),
			success: function(){},
			error:function(request,status,error){
			} 
		});
	}
	
	function checkNull(input){
		if(input== null||input.replace(/ /gi,"")==""){
			return true;
		}else{
			return false;
		}
	}
	
	
	function pageCreate(a){ //댓글 a칸의 페이지 메소드
		$.ajax({	//ajax로 전체 댓글의 갯수를 가져온다
         	url: "commentCount", type: "post", dataType: "text",
         	success: function(data){ // success - 앞의 ajax 문구가 정상적으로 작동했을 때 실행하는 함수 / data - 가져온 값
	         	var count = parseInt(data); // count - 가져온 댓글의 갯수를 숫자형로 형변화
	         	var Pagecount = 0;  //페이지 갯수 0으로 초기값
	         	
	         	if(count%3==0){ //댓글의 갯수를 n개로 나누어서 만들어야할 전체 페이지 갯수를 추출
	         		Pagecount = count/3;
	         	}else{
	         		Pagecount = parseInt(count/3 + 1);
	         	}
	         		
				var str = "";
				var prev = a-1;
				var next = a+1;
					
				if(a>1){ //첫번째 칸만 아니라면 [이전]버튼 생성 
					str += "<a onclick=pageCreate(";
			 		str += prev;
			 		str += ") href=javascript:;>[이전]  </a>";
				}
				
				if(Pagecount < 5*a){ //n개로 나누었을 때 댓글의 갯수보다 (불러올a칸xn개)가 많으면 댓글의 갯수만큼 제한
					for (var i = (prev*5)+1 ; i<=Pagecount ; i++ ){
				 		str += "<a onclick=pagebt(";
				 		str += i;
				 		str += ") href=javascript:;>"
				 		str += i;
				 		str += "  </a>";
				 		}
				}else{ //아니라면 n개를 전부 생성
					for (var i = (prev*5)+1 ; i<=a*5 ; i++ ){
				 		str += "<a onclick=pagebt(";
				 		str += i;
				 		str += ") href=javascript:;>"
				 		str += i;
				 		str += "  </a>";
			 		}
				}

				if(Pagecount > 5*a){ //(불러올a칸xn개)가 댓글의 갯수보다 부족하면 [다음]버튼 생성 
					str += "<a onclick=pageCreate(";
			 		str += next;
			 		str += ") href=javascript:;>[다음]</a>"
				}
				//전체 페이지갯수를 n개로 나누어서 a칸을 호출할 때 어떻게 만들지를 문자열 str에 더해주기
				
			 	$("#pageNumber").html(str);
				//작성한 str을 id가 pageNumber인 div에 넣어준다
				
			},
				error:function(request,status,error){ // success - 값 가져오기 실패시
              	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); // 에러창 호출
			}
		});
	}
		
	function pagebt(a){ //댓글을 호출하는 메소드
		var page = a;
		
		$.ajax({
         	url: "commentPro", type: "post", dataType:"json", data:{"page":page},
         	success: function(commentData){
         		var str = "";
         		let list = commentData.datas;
         		$(list).each(function(idx,arr){
         			for(var i = 1 ; i <= arr.star ; i++){
         				str += "<img class=starpic alt='' src=${pageContext.request.contextPath}/resources/images/yellowStar.png>";
         			}
         			for(var i = 1 ; i <= 5-arr.star ; i++){
         				str += "<img class=starpic alt='' src=${pageContext.request.contextPath}/resources/images/grayStar.png>";
         			}
         			str += arr.commentTime;
         			str += "<div>("
         			str += arr.memid;
         			str += ")</div>";
	       			if(arr.picture != null){
	       				str += "<img class=commentpic alt='' src=${pageContext.request.contextPath}/resources/images/comment_picture/";
	         			str += arr.picture;
	         			str += ">";
	       			}
	       			str += "<div>";
         			str += arr.comment;
         			str += "</div><input type=button onclick=recommentbt(";
         			str += arr.commentNum;		
         			str += ") value=답글";
         			str += recommentcount(arr.commentNum);
         			str += "><div class=recommentbox id=recommentbox";
         			str += arr.commentNum;
         			str += " style=display:none;><div id=recomment";
        			str += arr.commentNum;
         			str += "></div><div id=RepageNumber";
         			str += arr.commentNum;
         			str += "></div><form class=recomment_subform id=recomment_subform";
         			str += arr.commentNum;
         			str += "><textarea name=comment></textarea>";
         			str += "<input name=memId type=text value=<%=(String)session.getAttribute("id")%> style=display:none;>";
         			str += "<input name=recomment type=text value=";
         			str += arr.commentNum;
         			str += " style=display:none;>";
         			str += "<button id=submit_recomment";
         			str += arr.commentNum;
         			str += " onclick=insertrecomment(this)>답글 작성</button></form></div><hr>";
         			
         			
         		});
         		
				$("#comments").html(str);
				
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	function recommentbt(a){ //답글 버튼을 눌렀을 때
		var commentNum = a;
		if($("#recommentbox"+commentNum).css("display") == "none"){
		$("#recommentbox"+commentNum).show();
			repagebt(1,commentNum);
			RepageCreate(1,commentNum);
		}else if($("#recommentbox"+commentNum).css("display") != "none"){
	         $("#recommentbox"+commentNum).hide();
		}	
	}
	
	function repagebt(a,b){ //답글을 불러오는 메소드
		var page = a;
		var commentNum = b;
		var id = '<%=(String)session.getAttribute("id")%>';
		
		$.ajax({
			url:"recommentPro", type:"post", async: false , dataType:"json", data:{"page":page ,"commentNum":commentNum},
			success: function(commentData){
				var str = "";
				let list = commentData.datas;
					
				$(list).each(function(idx,arr){
					str += arr.commentTime;
	        		str += "<div>";
	        		str += "<div>("
	         		str += arr.memid;
	         		str += ")";
		       		str +="</div>";
	         		str += arr.recomment;
	         		str += "</div><hr>";
				});
					
				$("#recomment"+commentNum).html(str);
				
				
				
				if(id == "null"){
					$('.recomment_subform').hide();
				}
				
			},
				error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		$.ajax({
			url:"checkrecomment" , type:"post" , dataType:"json", data:{"memid":id , "recommentNum":b} ,
			success: function(commentData){
				var str = "";
         		let list = commentData.datas;
         		
         		if(list!=""){
         			$(list).each(function(idx,arr){
	         			
	         			str += arr.commentTime;
	         			str += "<div>(";
	         			str += arr.memid;
	         			str += ")";
		       			str += "<span class=editbutton ><button onclick=deleterecomment(";
		       			str += arr.commentNum;
		       			str += ")>삭제</button><button onclick=updaterecomment("
		       			str += arr.commentNum;		
		       			str += ")>수정</button></span></div><div>";
	         			str += arr.comment;
	         			str += "</div>";
         			});
         			
         			$("#recomment_box"+b).html(str);
         			
         		}
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		
		
	}
	
	function recommentcount(a){
 		var commentNum = a;
 		var count = 0;
 		
		$.ajax({	//ajax로 특정 답글의 갯수를 가져온다
         	url: "recommentCount", type: "post", async: false , dataType: "text", data:{"commentNum":commentNum},
         	//url-controller에 연결할 변수 / type-?? / async - 리턴을 받기 위한 동기식방법 / datatype - 가져올 데이터타입 / data - 건내줄 데이터 / 
         	success: function(data){
         		count = data;
         	},
         	error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		return count;
	}
	
	function RepageCreate(aa,b){ //b답글의 a칸의 페이지 메소드
				var commentNum = b;
				var count = recommentcount(commentNum);
				
				var a = aa;
	         	
	         	if(count%3==0){ //댓글의 갯수를 n개로 나누어서 만들어야할 전체 페이지 갯수를 추출
	         		Pagecount = count/3;
	         	}else{
	         		Pagecount = parseInt(count/3 + 1);
	         	}
	         		
				var str = "";
				var prev = a-1;
				var next = a+1;
				var commentnum = b;
					
				if(a>1){ //첫번째 칸만 아니라면 [이전]버튼 생성 
					str += "<a onclick=RepageCreate(";
			 		str += prev;
			 		str += ",";
			 		str += commentnum;
			 		str += ") href=javascript:;>[이전]  </a>";
				}
				
				if(Pagecount < 5*a){ //n개로 나누었을 때 댓글의 갯수보다 (불러올a칸xn개)가 많으면 댓글의 갯수만큼 제한
					for (var i = (prev*5)+1 ; i<=Pagecount ; i++ ){
				 		str += "<a onclick=repagebt(";
				 		str += i;
				 		str += ",";
				 		str += commentnum;
				 		str += ") href=javascript:;>"
				 		str += i;
				 		str += "  </a>";
				 		}
				}else{ //아니라면 n개를 전부 생성
					for (var i = (prev*5)+1 ; i<=a*5 ; i++ ){
				 		str += "<a onclick=repagebt(";
				 		str += i;
				 		str += ",";
				 		str += commentnum;
				 		str += ") href=javascript:;>"
				 		str += i;
				 		str += "  </a>";
			 		}
				}

				if(Pagecount > 5*a){ //(불러올a칸xn개)가 댓글의 갯수보다 부족하면 [다음]버튼 생성 
					str += "<a onclick=RepageCreate(";
			 		str += next;
			 		str += ",";
			 		str += commentnum;
			 		str += ") href=javascript:;>[다음]</a>"
				}
				//전체 페이지갯수를 n개로 나누어서 a칸을 호출할 때 어떻게 만들지를 문자열 str에 더해주기
				
			 	$("#RepageNumber"+commentnum).html(str);
				//작성한 str을 id가 pageNumber인 div에 넣어준다
				
	}
	
	function deletecomment(a){
		$.ajax({	
         	url: "deletecomment", type: "post", data:{"commentnum":a},
         	success: function(){},
         	error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		location.reload();
	}
	
</script>
<style type="text/css">
textarea {
    width: 25em;
    height: 6em;
    resize: none;
}

.recommentbox{
	margin-left: 50px;
	background-color: #CCCCCC;
}

.star{
	width: 30px;
	height: 30px;
	border-style:none;
	background-image: url("${pageContext.request.contextPath}/resources/images/grayStar.png");
	background-size: contain;
	background-color: inherit;
}

a{
	text-decoration: none;
	color: black;
}

#comments > .commentpic{
	width: 400px;
	height: 300px;
}

#comments > .starpic{
	width: 30px;
	height: 30px;
	margin: 2px;
}

.editbutton {
	float: right;
}

#comment_box > .starpic{
	width: 30px;
	height: 30px;
	margin: 2px; 
}

#comment_box > .commentpic{
	width: 400px;
	height: 300px;
}

#commentlist{
	size: 8em;
	background-color: gray;
}

#comment_box {
	background-color: #FFFFCC;
}

</style>

</head>
<body>

<div id = comment_box>
	<div id = starbox>
	별점:<button class="star" id="star1"></button>
	<button class="star" id="star2"></button>
	<button class="star" id="star3"></button>
	<button class="star" id="star4"></button>
	<button class="star" id="star5"></button>
	</div>
	
	<form id="comment_subform">
	<input id="star" name="star" type="text" value="0" style="display:none;"><br>
	<input id="memId" name="memId" type="text" value="<%=(String)session.getAttribute("id")%>" style="display:none;">
	<textarea id="comment" name="comment"></textarea>
	<button id="submit_comment" onclick="insertcomment()">댓글 작성</button>
	</form>
	
	<form id="commentPicture_subform" enctype="multipart/form-data">
	리뷰사진 첨부:<input type="file" id="file" name="file" accept=".jpg, .png">
	</form>
</div>


<hr>
<div id=commentlist>댓글 목록</div>
<hr>


<div id = "comments"></div>
<div id = "pageNumber"></div>

</body>
</html>