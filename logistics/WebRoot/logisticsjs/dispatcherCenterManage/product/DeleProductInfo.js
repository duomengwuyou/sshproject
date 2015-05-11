/**
 * 删除商品
 * 张文华
 */

DeleteProductInfo=function(row)
{alert(row);
            var deletesplit="";
            for(var i=0;i<row.length;i++)
            {
                        if(row.length==1)
                        {
                            deletesplit=row[i].data.productId;
                        }
                        else
                        {
                            
                            if(i<(row.length-1))
                            {
                                deletesplit=row[i].data.productId+","+deletesplit;
                            }
                            if(i==(row.length-1))
                           {
                                deletesplit=deletesplit+row[i].data.productId;
                           } 
                        }
             } 
                // alert(deletesplit);   
            Ext.Ajax.request({
            url:"productInfo.do?actionType=delete",
            method:"POST",
            params:{
                   productIds:deletesplit
            },
            success:function()
            {
                   Ext.Msg.alert("恭喜您","删除成功了!");
                   //gird.store.reload();
                   ProductInfostore.reload();
            },
            failure:function()
            {
                   Ext.Msg.alert("提 示","删除失败了!");
            }
            });

}
