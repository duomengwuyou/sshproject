<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head >
    <title>物流配送系统--登 陆</title>
    <link href="css/Loading.css" rel="stylesheet" type="text/css" />
	<link href="css/css.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet"  type="text/css" href="ext/resources/css/ext-all.css" />
	<link rel="stylesheet" type="text/css" href="ext/resources/css/xtheme-galdaka.css" />
	<style type="text/css">
	    .cbox{border:0px solid #D6D6D6;float:right;width:140px;height:80px}
	    .cbox img{margin-bottom:3px;vertical-align:middle}
	</style>
	<script src="ext/adapter/ext/ext-base.js" type="text/javascript"></script>
	<script src="ext/ext-all.js"type="text/javascript"></script>
	<script src="hotelmanagejs/skin.js" type="text/javascript"></script>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="logisticsjs/Login.js"></script>
</head>
<body >
   <form align="center" name = "loginForm">
    <div align="center" style="text-align:center; background-image:url(images/Login.gif);width:435px;height:283px;position: relative; top: 143px;left: 35%">
        <div style="left: 30px; width: 328px; position: relative; top: 133px; height: 134px">
            <div style="width: 322px; height: 25px; text-align: center">
                <span style="font-size: 12pt"> <span>帐 &nbsp;号：</span></span><input
                    id="user" style="width: 190px" type="text" /></div>
            <div style="width: 322px; height: 25px; text-align: center">
                <span style="font-size: 12pt"><span>密 &nbsp;码：</span></span><input id="password" type="password" style="width: 190px"  /></div>
            <div style="width: 322px; height: 25px; text-align: center">
            	<input type="radio" hidden="true" checked = "checked" value="staff" name="role" id = "role1"  >
            	<input type="radio" hidden="true" value="manager" name="role" id = "role2">
            	<input type="radio" hidden="true" value="admin" name="role" id = "role3">
            </div>
            <div style="width: 320px; height: 35px">
            </div>
            <div style="width: 320px; height: 33px; text-align: center;">
                &nbsp; 
                <input id="Login" type="button" value="登  陆"  onclick=" validatorData();" style="width: 75px" class="btn"/>
                &nbsp; &nbsp;&nbsp; &nbsp; 
                <input id="Reset" style="width: 75px" type="reset" value="重  置" class="btn" /></div>
        </div>
    </div>
   </form>
</body>
</html>
