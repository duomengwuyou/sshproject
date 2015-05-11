关于logistics项目的包的作用
src:
com.neusoft.logistics.bean          放实体类以及其hibernate的映射文件，其下类命名为“名词”
com.neusoft.logistics.action        放Struts Action，其下类命名为“动词+名词+Action”
com.neusoft.logistics.dao.inter           放Dao的接口，其下类命名为“I+名词+Dao”
com.neusoft.logistics.dao.impl	    放Dao的实现，其下类命名为“名词+DaoImpl”
com.neusoft.logistics.service.inter       放Service接口，其下类命名为“I+动词+Service”
com.neusoft.logistics.service.impl  放Service实现，其下类命名为“动词+ServiceImpl”
applicationContext-common.xml 		spring配置hibernate的文件，不要修改它  
applicationContext-actions.xml          spring配置Action的文件，struts-config的action-forward中的action的type属性
                                        type="org.springframework.web.struts.DelegatingActionProxy" name属性对应该文件中的id的值
applicationContext-services.xml         spring配置Service的文件
applicationContext-daos.xml             spring配置Dao的文件
hibernate.cfg.xml      Hibernate的数据库连接配置文件,只要增添mapping就行
WebRoot:
shared：文件夹下放置的是EXT的常用js,css和图片文件,不要修改该文件夹下的东西
templates:文件下放置css以及图片模板，其中default为默认的模板，新增模板可以在该文件夹下添加文件夹，例如tpl1,tpl2..., 每一个模板都是能完整定义界面的，可以相互替换的。
modules：文件夹下放置页面，可以新建文件夹
WEB-INF/struts-config.xml为struts配置文件
docs:
该文件夹下放置各种文档，包括sql,用例规约，需求文档等等，每种类型的文档最好建一个新的文件夹。

注意：如果我们使用CVS，我们所有的文件夹名称，文件名称不能是中文，切记。



