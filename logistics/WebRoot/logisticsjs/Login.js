//1.我们首先创建一个全局变量
//2.我们在创建一个XmlHttpRequest对象
var xmlHttp;
function createXmlHttpRequest(){
    if(window.XMLHttpRequest){
        xmlHttp=new XMLHttpRequest();
        if(xmlHttp.overrideMimeType){
                xmlHttp.overrideMimeType("text/xml");
        }
    }else if(window.ActiveXObject){
        try{
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");   
        }catch(e){
            xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");   
        }
    }
    if(!xmlHttp){
        window.alert("你的浏览器不支持创建XMLhttpRequest对象");
    }
    return xmlHttp;
}


function ReBtn(){
    window.location.reload();
}
function ValidateCode(){
    createXmlHttpRequest();
    var url="URL/ValidateCode.aspx?Code="+document.getElementById("TxtCode").value;
    xmlHttp.open("GET",url,true); 
    //xmlHttp.onreadystatechange=ValidateResult;
    xmlHttp.send(null);
}
function validatorData(){
	var roleValue ;
	if(document.getElementById("role1").checked){
		roleValue = document.getElementById("role1").value;
	}else if(document.getElementById("role2").checked){
		roleValue = document.getElementById("role2").value;
	}else if(document.getElementById("role3").checked){
		roleValue = document.getElementById("role3").value;
	}
	//alert("测试！");
	//alert("loginForm.role "+document.getElementById("role1").checked);
	Ext.Ajax.request({
   			url:"login.do?actionType=doLogin",
   			//params:{user1:user,password1:password,role1:role},
   			params:{user:document.getElementById("user").value,password:document.getElementById("password").value,role:roleValue},
   			success:function(response,option){
	   			var obj=Ext.decode(response.responseText);
	   			if(obj.success){
		   			Ext.Msg.alert("恭喜你","登录成功了！");
		   			window.location.href="index.jsp"; 
	   			}else{
	   				Ext.Msg.alert("不好意思","用户账号或者密码错误");   
	   			}
   			},
   			failure:function(){   
                Ext.Msg.alert("坏消息","坏消息：你登陆出现异常了！");  
            }   
   	})
  }
function check(){
    var userName=document.getElementById("TxtName").value;
    var userPwd=document.getElementById("TxtPwd").value;
    if(Login.isRight(userName+"",userPwd+"").value>0){
        //判断用户状态是否可用
        if(Login.userState(userName+"").value==0){
             //得到用户权限类型
            Login.UserType(userName+"");
            //写入Session
            Login.WriteSession(userName+"");
            window.location.href='Index.aspx';
        }else{
            alert("对不起您的帐号己禁用");
        }          
    }else{
        alert("用户名或密码不正确!");  
    }
  }