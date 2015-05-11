package com.neusoft.logistics.service.inter.customermanage;


import java.util.List;

import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.bean.Order;

/**
 * 客户信息管理  包括增、删、改、查
 * @author 张文华
 *
 */
public interface ICustomerInfoService {
	public String getAllCustomers();
	public String getSearchCustomers(Customer customer);
	public void addCustomer(Customer customer);
	public void delCustomer(Customer customer);
	public void modCustomer(Customer customer);
	public Customer findCustomerById(int id);
	public List<Order> findOrderByCustomer(int customerId);
}
