package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Warehouse;

public interface IWarehouseDAO extends IBaseDAO<Warehouse> {
public List<Warehouse> findByWarehouseaddress(String add);
public Warehouse getCenterWarehosue();
}
