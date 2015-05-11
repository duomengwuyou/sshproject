package com.neusoft.logistics.service.inter.allocation;

import java.util.List;

import com.neusoft.logistics.bean.Substation;

/**
 * 
 * @author 宋延杰
 * 
 */
public interface ISubstationService {
	public String substationToJSON(List<Substation> substationList);
	public String findAllSubstation();
}
