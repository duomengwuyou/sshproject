// JScript 文件

DeleteFirstCategoryInfo=function(row)
{
            var deletesplit="";
            for(var i=0;i<row.length;i++)
            {
                        if(row.length==1)
                        {
                            deletesplit=row[i].data.categoryid;
                        }
                        else
                        {
                            
                            if(i<(row.length-1))
                            {
                                deletesplit=row[i].data.categoryid+","+deletesplit;
                            }
                            if(i==(row.length-1))
                           {
                                deletesplit=deletesplit+row[i].data.categoryid;
                           }  
                        }
             }  
            Ext.Ajax.request({
            url:"category.do?actionType=delete",
            method:"POST",
            params:{
                   categoryId:deletesplit
            },
            success:function()
            {
                   Ext.Msg.alert("恭喜您","删除成功了!");
                   //gird.store.reload();
                   FirstCategoryStore.reload();
            },
            failure:function()
            {
                   Ext.Msg.alert("提 示","删除失败了!");
            }
            });

}
