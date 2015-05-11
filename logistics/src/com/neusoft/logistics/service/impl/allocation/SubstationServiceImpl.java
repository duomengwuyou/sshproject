package com.neusoft.logistics.service.impl.allocation;

import java.util.List;

import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.dao.impl.SubstationDAO;
import com.neusoft.logistics.service.inter.allocation.ISubstationService;
import com.neusoft.logistics.utils.JSONHelper;

/**
 * 
 * @author 宋延杰
 * 
 */
public class SubstationServiceImpl implements ISubstationService{
	private SubstationDAO substationDAO;
	public SubstationDAO getSubstationDAO() {
		return substationDAO;
	}
	public void setSubstationDAO(SubstationDAO substationDAO) {
		this.substationDAO = substationDAO;
	}
	/**
	 * 转成json
	 */
	public String substationToJSON(List<Substation> substationList){
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		if(substationList.size()>0){
			for(Substation s:substationList){
				json.AddItem("substationId", Integer.toString(s.getSubstationid()));
				json.AddItem("substationAdd", s.getSubstationadd());
				json.ItemOK();
			}
		}
		String jsons="";
		jsons = json.toString();
		return jsons;
	}
	/**
	 * 查询全部分站
	 */
	public String findAllSubstation(){
		List<Substation> substationList;
		substationList = substationDAO.findAll();
		return this.substationToJSON(substationList);
	}
}
