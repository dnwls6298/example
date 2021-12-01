<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	
	
	
	</script>
	<style type="text/css">
	
		.star{
			width: 30px;
			height: 30px;
			border-style:none;
			background-image: url("${pageContext.request.contextPath}/resources/images/grayStar.png"); 
			background-size: contain;
		}
	</style>
	
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>

<button class="star" id="star1"></button>