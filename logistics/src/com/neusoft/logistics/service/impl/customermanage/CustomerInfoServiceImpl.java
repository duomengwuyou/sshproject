package com.neusoft.logistics.service.impl.customermanage;

import java.util.HashSet;
import java.util.Set;

import java.util.List;

import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.dao.inter.ICustomerDAO;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.service.inter.customermanage.ICustomerInfoService;
import com.neusoft.logistics.utils.JSONHelper;

/**
 * 客户信息管理  包括增、删、改、查
 * @author 张文华
 *
 */
public class CustomerInfoServiceImpl implements ICustomerInfoService {

	
	private ICustomerDAO customerDAO;
	private IOrderDAO orderDAO;
	public ICustomerDAO getCustomerDAO() {
		return customerDAO;
	}

	public void setCustomerDAO(ICustomerDAO customerDAO) {
		this.customerDAO = customerDAO;
	}

	
	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	public String getAllCustomers(){
		List<Customer> customers = customerDAO.findAll();
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		for(Customer customer:customers){

			json.AddItem("customerId", Integer.toString(customer.getCustomerid()));
			json.AddItem("customerName", customer.getCustomername());
			json.AddItem("idcard", customer.getIdcard());
			if(customer.getWorkplace()==null||customer.getWorkplace().equals("")){
				customer.setWorkplace("暂无数据");
			}
			json.AddItem("workPlace", customer.getWorkplace());
			if(customer.getPhone()==null||customer.getPhone().equals("")){
				customer.setPhone("暂无数据");
			}
			json.AddItem("phone", customer.getPhone());
			json.AddItem("mobile", customer.getMobile());
			json.AddItem("address", customer.getAddress());
			if(customer.getCustomerzipcode()==null||customer.getCustomerzipcode().equals("")){
				customer.setCustomerzipcode("暂无数据");
			}
			json.AddItem("customerZipCode", customer.getCustomerzipcode());
			if(customer.getEmail()==null||customer.getEmail().equals("")){
				customer.setEmail("暂无数据");
			}
			json.AddItem("email", customer.getEmail());
			json.ItemOK();
		}
		 json.setTotalCount(customers.size());
         String jsons="";
         jsons = json.toString();
		return jsons;
	}
	
	public String getSearchCustomers(Customer customer){
		List<Customer> customers = customerDAO.findCustomer(customer);
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		for(Customer customer1:customers){

			json.AddItem("customerId", Integer.toString(customer1.getCustomerid()));
			json.AddItem("customerName", customer1.getCustomername());
			json.AddItem("idcard", customer1.getIdcard());
			if(customer1.getWorkplace()==null||customer1.getWorkplace().equals("")){
				customer1.setWorkplace("暂无数据");
			}
			json.AddItem("workPlace", customer1.getWorkplace());
			if(customer1.getPhone()==null||customer1.getPhone().equals("")){
				customer1.setPhone("暂无数据");
			}
			json.AddItem("phone", customer1.getPhone());
			json.AddItem("mobile", customer1.getMobile());
			json.AddItem("address", customer1.getAddress());
			if(customer1.getCustomerzipcode()==null||customer1.getCustomerzipcode().equals("")){
				customer1.setCustomerzipcode("暂无数据");
			}
			json.AddItem("customerZipCode", customer1.getCustomerzipcode());
			if(customer1.getEmail()==null||customer1.getEmail().equals("")){
				customer1.setEmail("暂无数据");
			}
			json.AddItem("email", customer1.getEmail());
			json.ItemOK();
		}
		 json.setTotalCount(customers.size());
         String jsons="";
         jsons = json.toString();
		return jsons;
	}
	
	public void addCustomer(Customer customer) {
		// TODO Auto-generated method stub
		customerDAO.save(customer);
	}

	public void delCustomer(Customer customer) {
		// TODO Auto-generated method stub
			customerDAO.delete(customer);
	}

	public void modCustomer(Customer customer) {
		// TODO Auto-generated method stub
		customerDAO.attachDirty(customer);
	}
	
	public Customer findCustomerById(int id){
		return customerDAO.findById(id);
	}
	public static void main(String args[]){
		CustomerInfoServiceImpl service = new CustomerInfoServiceImpl();
		Customer c = new Customer("liyafang", "123", "东北大学","123", "123", "沈阳", "123", "liyafang@163.com", new HashSet(0));
		service.addCustomer(c);
	}
	
	public List<Order> findOrderByCustomer(int customerId){
		return orderDAO.findOrderByCustomer(customerId);
	}
	
}
