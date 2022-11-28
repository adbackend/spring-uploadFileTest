<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
	<button id="uploadBtn">에이작스 처리</button>

</body>
<style>
.uploadResult {
	width : 100%;
	background-color: gray;
}

.uploadResuslt ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	
	var cloneObj = $(".uploadDiv").clone();
	
	 $("#uploadBtn").on("click", function(e){

	 var formData = new FormData();
	 var inputFile = $("input[name='uploadFile']");
	 var files = inputFile[0].files;
	
	 console.log(files);
	
	 //add filedate to formdata
	 for(var i = 0; i < files.length; i++){
	 	formData.append("uploadFile", files[i]);
	 }

		 $.ajax({
			 url:'/uploadAjaxAction',
			 processData:false,
			 contentType:false, //보내는 타입
			 data:formData,
			 type:'POST',
			 dataType:'json',
			 success : function(result){
				 
		 		alert("Uploaded");
		 		console.log(result);
		 		
		 		showUploadedFile(result);
		 		
		 		$(".uploadDiv").html(cloneObj.html());
		 	 } // success end
		 }); // $.ajax end
				
	 });  
}); 
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; //5MB

			function checkExtension(fileName, fileSize) {

				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}

				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			} // function end
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					
					if(!obj.image){
						str += "<li><img src='/resources/img/attach.PNG'>" + obj.fileName + "</li>";
					}else{
						//str += "<li>" + obj.fileName + "</li>";
						
						var fileCallPath = encodeURIComponent(obj.uploadPath)
					}
				});
				
				uploadResult.append(str);
			} // function end
			

	</script>
</html>