package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Customer;

public interface ICustomerDAO extends IBaseDAO<Customer> {
	public List<Customer> findCustomer(Customer customer);
}
