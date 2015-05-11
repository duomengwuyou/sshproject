package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;

public interface ITaskOrderDAO extends IBaseDAO<TaskOrder> {
public List<TaskOrder> listTaksOrdersBySubstation(Substation substation);
public List<TaskOrder> listTaksOrdersBySubstation(Substation substation,String start, String end);
public List<TaskOrder> listTaksOrdersBySubstation(Substation substation,String date, String type, String state);
public List<TaskOrder> listTaksOrdersBySubstation(Substation substation,String date, String type, String state, String deliverman);
public void modifyTastState(int taskorderId);
public int modifyDiliverman(int taskorderid, int dilivermanid);
public List<TaskOrder> findByOrder(Order order);
public User getLessBusyDeliverman(int substationId);
public void modifyTastStateToDispatch(int taskorderId);
public void modifyTastState(int taskorderId,String state);
}
