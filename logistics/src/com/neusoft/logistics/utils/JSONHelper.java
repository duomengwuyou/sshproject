package com.neusoft.logistics.utils;

import java.util.ArrayList;
import java.util.List;

public class JSONHelper {
	private String singleInfo = null;
	private String error = null;
	private boolean success = true;
	private int totalCount = 0;
	private List<String> arrData = new ArrayList<String>();
	private List<String> arrDataItem = new ArrayList<String>();
	public JSONHelper(){}
	public String getSingleInfo() {
		return singleInfo;
	}
	public void setSingleInfo(String singleInfo) {
		this.singleInfo = singleInfo;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public boolean isSuccess() {
		return success;
	}
	/*
	 * 对应于JSON的success成员,如设置为true则清空error
	 */
	public void setSuccess(boolean success) {
		if(success){
			this.error = null;
		}
		this.success = success;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public List<String> getArrData() {
		return arrData;
	}
	public void setArrData(List<String> arrData) {
		this.arrData = arrData;
	}
	public List<String> getArrDataItem() {
		return arrDataItem;
	}
	public void setArrDataItem(List<String> arrDataItem) {
		this.arrDataItem = arrDataItem;
	}
	/*
	 * 重置，每次新生成一个json对象时必须执行该方法
	 */
	public void Reset(){
		this.success = true;
		this.error = null;
		this.singleInfo = null;
		this.arrData.clear();
		this.arrDataItem.clear();
	}
	public void AddItem(String name,String value){
		this.arrData.add("\"" + name + "\":" + "\"" + value + "\"");
	}
	public void ItemOK(){
		this.arrData.add("<BR>");
		this.totalCount++;
	}
	@Override
	public String toString(){
		StringBuffer sb = new StringBuffer();
        sb.append("{");
        sb.append("totalCount:" + this.totalCount + ",");
        sb.append("success:" + this.success+",");
        //sb.append("error:\"" + this.error.replace("\"", "\\\"")+ "\",");
        //sb.append("singleInfo:\"" + singleInfo.replace("\"", "\\\"") + "\",");
        sb.append("data:[");
        int index = 0;
        sb.append("{");
        if (arrData.size() <= 0)
        {
            sb.append("}]");
        }
        else
        {
            for  (String val : arrData)
            {
                index++;

                if (val != "<BR>")
                {
                    sb.append(val + ",");
                }
                else
                {
                    sb = sb.replace(sb.length() - 1, sb.length(),"");
                    sb.append("},");
                    if (index < arrData.size())
                    {
                        sb.append("{");
                    }
                }
            }
            sb = sb.replace(sb.length() - 1, sb.length() , "");
            sb.append("]");
        }
        sb.append("}");
        return sb.toString();
    }
}

