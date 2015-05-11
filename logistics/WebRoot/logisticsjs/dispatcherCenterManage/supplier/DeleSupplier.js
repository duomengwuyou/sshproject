// JScript 文件
/**
 * 删除供应商
 * @author:罗荣博
 */
DeleteSupplierInfo=function(row){
    var deletesplit="";
    for(var i=0;i<row.length;i++){
        if(row.length==1){
            deletesplit=row[i].data.supplierId;
        }
        else{
           if(i<(row.length-1)){
                deletesplit=row[i].data.supplierId+","+deletesplit;
            }
            if(i==(row.length-1)){
                deletesplit=deletesplit+row[i].data.supplierId;
           } 
        }
    } 
            
    Ext.Ajax.request({
    url:"supplierManage.do?actionType=delete",
    method:"POST",
    params:{
           supplierid:deletesplit
    },
    success:function(){
           Ext.Msg.alert("恭喜您","删除成功了!");
           SupplierStore.reload();
    },
    failure:function(){
           Ext.Msg.alert("提 示","删除失败了!");
    }
    });
}
