package com.neusoft.logistics.utils;
public class Encrypt {
	public static String encrypt(String encypted,String encrypting){
		StringBuffer buffer=new StringBuffer();
		if(encypted!=null&&encrypting!=null){
			buffer
			.append(Integer.toHexString(encypted.substring(0, encypted.length()/2).hashCode()/3))
			.append(Integer.toHexString(encrypting.substring(encrypting.length()/2).hashCode()/7))
			.append(Integer.toHexString(encypted.substring(encypted.length()/2).hashCode()*7))
			.append(Integer.toHexString(encypted.substring(encypted.length()/2).hashCode()*3))
			.append(Integer.toHexString("logistics".hashCode())).append(Integer.toHexString("neusoft".hashCode()));
		}
		return buffer.toString().substring(0, 20);
	}
}
