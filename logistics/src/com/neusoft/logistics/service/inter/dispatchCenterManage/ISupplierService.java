package com.neusoft.logistics.service.inter.dispatchCenterManage;

import com.neusoft.logistics.bean.Supplier;

public interface ISupplierService {
public String getAllSuppliers();

public String saveSupplier(Supplier supplier);

public String delete(String[] root);

public String modSupplier(Supplier supplier);
}
