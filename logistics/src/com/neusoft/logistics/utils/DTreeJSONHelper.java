package com.neusoft.logistics.utils;
import java.util.ArrayList;
import java.util.List;
/**
 * @author 周诗龙
 * 生成动态树的封装的操作
 */
public class DTreeJSONHelper {
	/**
	 * 对应JSON的singleInfo成员
	 */
    public String singleInfo = "";
    private String _error = "";
    private boolean _success = true;
    private long _totalCount = 0;
    private List<String> arrData = new ArrayList<String>();
    private List<String> arrDataItem = new ArrayList<String>();
    public DTreeJSONHelper(){}
    /**
	 * 对应于JSON的success成员
	 */
    public boolean getSuccess(){
    	return _success;
    }
    public void setSuccess(boolean success){
    	//如设置为true则清空error
    	if(success){
    		_error="";
    	}
    	_success = success;
    }
    /**
	 * 对应于JSON的error成员
	 */
    public String getError(){
    	return _error;
    }
    public void setError(String error){
        //如设置error，则自动设置success为false
    	if(error!=""){
    		_success = false;
    	}
    	_error=error;
    }
    /**
	 * 总数量
	 */
    public long getTotalCount(){
    	return _totalCount;
    }
    public void setTotalCount(long totalCount){
    	_totalCount = totalCount;
    }
    /**
	 * 重置，每次新生成一个json对象时必须执行该方法
	 */
    public void reset(){
    	 _success = true;
         _error = "";
         singleInfo = "";
         arrData.clear();
         arrDataItem.clear();
    }
    public void addItem(String name, String value){
        if (name.equals("leaf")&& value.equals("1")){
            value = "true";
            arrData.add("" + name + ":" + "" + value + "");
        }else if (name.equals("leaf")&&value.equals("0")){
            value = "false";
            arrData.add("" + name + ":" + "" + value + "");
        }else{
            arrData.add("" + name + ":\"" + "" + value + "\"");
        }
    }
    public void itemOk(){
        arrData.add("<BR>");
        //返回总记录条数
        this._totalCount++;
    }
    /**
	 * 序列化JSON对象，得到返回的JSON代码
	 */
    public  String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        int index = 0;
        sb.append("{");
        if (arrData.size() <= 0){
            sb.append("}");
        }else{
            for(String val : arrData){
                index++;
                if (val != "<BR>"){
                    sb.append(val + ",");
                }else{
                	sb = sb.replace(sb.length() - 1, sb.length(),"");
                    sb.append("},");
                    if (index < arrData.size()){
                        sb.append("{");
                    }
                }
            }
            //System.out.println("DTreeJSONHelper中的sb为："+sb);
            sb = sb.replace(sb.length() - 1, sb.length(),"");
            sb.append("");
        }
        sb.append("]");
        return sb.toString();
    }
}
