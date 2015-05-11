// /<reference path="../../JS/ext.js" />
// 加载效果
setTimeout(function() {
			Ext.get('loading').remove();
			Ext.get('loading-mask').fadeOut({
						remove : true
					});
		}, 2000);
// 得到用户ID
load();
// --设置一些共有参数
Ext.BLANK_IMAGE_URL = "images/s.gif";
Ext.QuickTips.init();
///=================================================头部
var top=new Ext.BoxComponent({
        el:"top",
        height:80
    });

//------------------------------------------north设置
var north=new Ext.Panel({
        border:false,
        region:"north",
        height:80,
        items:[top]
    });

//----------------------------------------------左边
var root=new Ext.tree.AsyncTreeNode({
        id:rootsid,
        text:"物流管理系统",
        loader:new Ext.tree.TreeLoader({
        	//url: "showList.do?actionType=doList",
        	url : "dynamicTree.do?actionType=doTree",
            listeners:{
                "beforeload":function(treeloader,node)
                {
                        treeloader.baseParams={
                        id:node.id,
                        method:'POST'
                        };
                }
            }
        })
    });
    
var treenode=new Ext.tree.TreePanel({
    //如果超出范围带自动滚动条
    autoScroll:true,
    animate:true,
    root:root,
    //默认根目录不显示
    rootVisible:false,
    border:false,
    animate:true,
    lines:true,
    enableDD:true,
    containerScroll:true,
    listeners:
    {
        "click":function(node,event)
        {
            //叶子节点点击不进入链接
            if (node.isLeaf()) {
			    // 显示叶子节点菜单
			    event.stopEvent();
				ALLEvents(node);
		    } else {
			        //不是叶子节点不触发事件
				    event.stopEvent();
				    //点击时展开
				    node.toggle();
		   }
            
        }
    }
});

// 加载时自动展开根节点
// treenode.getRootNode().toggle();
treenode.expandAll();

// 添加左边
var west = new Ext.Panel({
			// 自动收缩按钮
			collapsible : true,
			border : false,
			width : 225,
			layout : "accordion",
			extraCls : "roomtypegridbbar",
			// 添加动画效果
			layoutConfig : {
				animate : true
			},
			region : "west",
			title : 'NEU物流配送系统',
			//
			items : [{
						title : "<b>管理菜单</b>",
						autoScroll : true,
						iconCls : "hotelmanageicon",
						items : [treenode]
					}
			// ,{
			// iconCls:"gonggao",
			// title:"<b>客房注意问题</b>",
			// items: null
			// //items:[publishinfosgrid]
			// }
			]

		});
// -------------------------------------------------------右边
// 房间图片
var roomtypepicbox = new Ext.BoxComponent({
			el : "roomtypeSee"
		});

var roomTypeSeepanel = new Ext.Panel({
			border : false,
			items : [roomtypepicbox]
		});

// 东面布局
var east = new Ext.Panel({
			title : ' ',
			// 采用可折叠控件
			layout : "accordion",
			// 自动收缩按钮
			collapsible : true,
			// 加载时自动收起
			// collapsed:true,
			// 添加动画效果
			layoutConfig : {
				animate : true
			},
			border : false,
			width : 204,
			region : "east",
			items : [{
						iconCls : "roomtypeseeicon",
						title : "<b>各地物流配送图片欣赏</b>",
						items : [roomTypeSeepanel]
					}]
		});
// 右边自动隐藏
// east.hide();
// -------------------------------------------------中间
// 中间部分控件
var center = new Ext.TabPanel({

	// 距两边间距
	style : "padding:0 5px 0 5px",
	region : "center",
	// 默认选中第一个
	activeItem : 0,
	// 如果Tab过多会出现滚动条
	enableTabScroll : true,
	// 加载时渲染所有
	// deferredRender:false,
	layoutOnTabChange : true,
	items : [{
		xtype : "panel",
		id : "index",
		iconCls : "indexicon",
		title : "主页",
		html : "<iframe src='HomePage.jsp'scrolling='no' frameborder=0 width=100% height=100%></iframe>"
	}],
	plugins : new Ext.ux.TabCloseMenu()
});
var botton = new Ext.BoxComponent({
			el : "botton",
			height : 40
		});
// 页面布局南部
var south = new Ext.Panel({
			border : false,
			region : "south",
			height : 40,
			items : [botton]
		});
// ////////////////////////////////////////////////////////
// Boss布局
Ext.onReady(function() {
			var vp = new Ext.Viewport({
						layout : "border",
						items : [north, south,east, west, center]
					});
		});
