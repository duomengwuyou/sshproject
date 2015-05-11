package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import com.neusoft.logistics.bean.Supplier;
import com.neusoft.logistics.dao.inter.ISupplierDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.ISupplierService;
import com.neusoft.logistics.utils.JSONHelper;

public class SupplierServiceImpl implements ISupplierService {
	private ISupplierDAO supplierDAO;

	public ISupplierDAO getSupplierDAO() {
		return supplierDAO;
	}

	public void setSupplierDAO(ISupplierDAO supplierDAO) {
		this.supplierDAO = supplierDAO;
	}

	public String getAllSuppliers() {
		System.out.println(this.getClass()+" getAllSuppliers");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		for(Supplier supplier:supplierDAO.findAll()){
			json.AddItem("supplierId", String.valueOf(supplier.getSupplierid()));
			json.AddItem("supplierName", supplier.getSuppliername());
			json.AddItem("supplierAdd", supplier.getSupplieradd());
			json.AddItem("contactPerson", supplier.getContactperson());
			json.AddItem("supplierTel", supplier.getSuppliertel());
			json.AddItem("bank", supplier.getBank());
			json.AddItem("bankAccount", supplier.getBankaccount());
			json.AddItem("fax", supplier.getFax());
			json.AddItem("supplierZipCode", supplier.getSupplierzipcode());
			json.AddItem("legalPerson", supplier.getLegalperson());
			json.AddItem("supplierRemark", supplier.getSupplierremark());
			json.ItemOK();
		}
		// TODO Auto-generated method stub
		return json.toString();
	}

	public String saveSupplier(Supplier supplier) {
		supplierDAO.save(supplier);
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

	public String delete(String[] root) {
		for(int i=0;i<root.length;i++){
			supplierDAO.delete(supplierDAO.findById(Integer.valueOf(root[i])));
		}
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

	public String modSupplier(Supplier supplier) {
		System.out.println(this.getClass()+" execute mod");
		supplierDAO.findById(supplier.getSupplierid()).setBank(supplier.getBank());
		supplierDAO.findById(supplier.getSupplierid()).setBankaccount(supplier.getBankaccount());
		supplierDAO.findById(supplier.getSupplierid()).setContactperson(supplier.getContactperson());
		supplierDAO.findById(supplier.getSupplierid()).setFax(supplier.getFax());
		supplierDAO.findById(supplier.getSupplierid()).setLegalperson(supplier.getLegalperson());
		supplierDAO.findById(supplier.getSupplierid()).setSupplieradd(supplier.getSupplieradd());
		supplierDAO.findById(supplier.getSupplierid()).setSuppliername(supplier.getSuppliername());
		supplierDAO.findById(supplier.getSupplierid()).setSupplierremark(supplier.getSupplierremark());
		supplierDAO.findById(supplier.getSupplierid()).setSuppliertel(supplier.getSuppliertel());
		supplierDAO.findById(supplier.getSupplierid()).setSupplierzipcode(supplier.getSupplierzipcode()); 
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

}
