<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head></head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员注册</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js" ></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />

<style>
body {
	margin-top: 20px;
	margin: 0 auto;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}

font {
	color: #3164af;
	font-size: 18px;
	font-weight: normal;
	padding: 0 10px;
}
</style>
</head>
<body>

	<!-- 引入header.jsp -->
	<jsp:include page="/jsp/header.jsp"></jsp:include>

	<div class="container"
		style="width: 100%; background: url('${pageContext.request.contextPath}/img/regist_bg.jpg');">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8"
				style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
				<font>会员注册</font>USER REGISTER
				<form class="form-horizontal" name="fm"  action="${pageContext.request.contextPath }/UserServlet?method=regist"  method="post"  style="margin-top: 5px;">
					
					<input type="hidden" name="method" value="regist">
					
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="username" name="username"
								placeholder="请输入用户名">
						</div>
						<div class="col-sm-4">
							<span id="msg"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="inputPassword3" name="password"
								placeholder="请输入密码">
						</div>
					</div>
					<div class="form-group">
						<label for="confirmpwd" class="col-sm-2 control-label">确认密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="confirmpwd" name="confirmpwd"
								placeholder="请输入确认密码">
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-6">
							<input type="email" class="form-control" id="inputEmail3" name="email"
								placeholder="Email">
						</div>
					</div>
					<div class="form-group">
						<label for="usercaption" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="usercaption" name="name"
								placeholder="请输入姓名">
						</div>
					</div>
					<div class="form-group opt">
						<label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-6">
							<label class="radio-inline"> 
								<input type="radio" name="sex" id="inlineRadio1" value="male">
								男
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="sex" id="inlineRadio2" value="female">
								女
							</label>
						</div>
					</div>
					<div class="form-group">
						<label for="date" class="col-sm-2 control-label">出生日期</label>
						<div class="col-sm-6">
							<input type="date" class="form-control" name="birthday">
						</div>
					</div>

					<div class="form-group">
						<label for="date" class="col-sm-2 control-label">验证码</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="checkCode">

						</div>
						<div class="col-sm-2">
							<img src="../image/captcha.jhtml" />
						</div>

					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" width="100" value="注册" name="submit"
								style="background: url('../images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0); height: 35px; width: 100px; color: white;">
						</div>
					</div>
				</form>
			</div>

			<div class="col-md-2"></div>

		</div>
	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="/jsp/footer.jsp"></jsp:include>


<!-- AJAX异步校验用户名 -->
<script>
$(function(){
	//页面加载完毕，获取用户名文本框为其绑定失去焦点事件
	$("#username").blur(function(){
		//获取到用户名
		var val=this.value;
		//截取字符串前后空格
		var vv=$.trim(val);
		if(vv!=""){
			//向服务端发起Ajax请求
			$.get("${pageContext.request.contextPath}/UserServlet?method=findUser",{"um":vv},function(data){
				/* alert(data); */
				//$("#msg").html(data);
				if(data=="success"){
					$("#msg").html("用户名可以注册");
					$("#msg").css("color","green");
				}
				if(data=="fail"){
					$("#msg").html("用户名已经存在");
					//jquery:curd标签，控制标签属性/样式 ,ajax
					$("#msg").css("color","red");
				}
				
			});
			
		}else{
			$("#msg").html("请录入合法的用户名");
			$("#msg").css("color","red");
		}
	});
	
	/* 
	$("#fm").validate({
		rules:{
			username:{
				required:true
			},
			password:{
				required:true,
				rangelength:[5,10]
			},
			confirmpwd:{
				equalTo:"#loginPwd"
			},
			email:{
				email:"email"
			}
		},
		messages:{
			username:{
				required:"账户不能为空"
			},
			loginPwd:{
				required:"密码不能为空",
				rangelength:"长度必须是{0}位到{1}位"
			},
			reLoginPwd:{
				equalTo:"2次密码不一致"
			}
		}
	}); */
});
</script>


</body>
</html>




