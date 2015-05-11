// JScript 文件

DeleteGoodsInfo=function(row)
{
            var deletesplit="";
            for(var i=0;i<row.length;i++)
            {
                        if(row.length==1)
                        {
                            deletesplit=row[i].data.goodsId;
                        }
                        else
                        {
                            
                            if(i<(row.length-1))
                            {
                                deletesplit=row[i].data.goodsId+","+deletesplit;
                            }
                            if(i==(row.length-1))
                           {
                                deletesplit=deletesplit+row[i].data.goodsId;
                           } 
                        }
             } 
                    
            Ext.Ajax.request({
            //url:"servlet/DeleteGoodsServlet",
            method:"POST",
            params:{
                   goodsid:deletesplit
            },
            success:function()
            {
                   Ext.Msg.alert("恭喜您","删除成功了!");
                   //gird.store.reload();
                   GoodsInfostore.reload();
            },
            failure:function()
            {
                   Ext.Msg.alert("提 示","删除失败了!");
            }
            });

}
