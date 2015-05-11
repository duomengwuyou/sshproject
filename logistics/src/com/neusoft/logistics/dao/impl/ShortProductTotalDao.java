package com.neusoft.logistics.dao.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;

import com.neusoft.logistics.bean.ShortProductTotal;
import com.neusoft.logistics.dao.inter.IShortProductTotalDao;

public class ShortProductTotalDao extends  BaseHibernateDAO<ShortProductTotal> implements IShortProductTotalDao{

	private List<ShortProductTotal> shortProductsTotal;
	private static final Log log = LogFactory.getLog(ShortProductTotalDao.class);
	public ShortProductTotalDao() {
		super(log, ShortProductTotal.class);
		// TODO Auto-generated constructor stub
	}

	public static Log getLog() {
		return log;
	}

	public void setShortProductsTotal(List<ShortProductTotal> shortProductsTotal) {
		this.shortProductsTotal = shortProductsTotal;
	}

	public List<ShortProductTotal> getShortProductsTotal(){

		shortProductsTotal=new ArrayList<ShortProductTotal>();
		Session session = this.getSession();
		try{
			List lists = (List)session.createSQLQuery("select * from short_product_total t").list();

			System.out.println("总缺货Dao：   有多少条记录："+lists.size());
			for (Iterator iter = lists.iterator();iter.hasNext();) {
				ShortProductTotal temp=new ShortProductTotal();
				Object[] obj = (Object[])iter.next();

				//System.out.println("总缺货Dao：   有多少列："+obj.length);
				//System.out.println(obj[0].toString()+"  "+obj[1].toString()+" 	"+obj[2].toString()+"  "+obj[3].toString());

				//设置productID
				if(obj[0]!=null){
					temp.setProductId(Integer.valueOf(obj[0].toString()));
				}else{
					temp.setProductId(Integer.parseInt(obj[1].toString()));
				}

				//设置productQuantity
				if(obj[2]!=null){
					if(obj[3]!=null){
						temp.setShortQuantityTotal(Integer.parseInt(obj[2].toString())+Integer.parseInt(obj[3].toString()));
					}else{
						temp.setShortQuantityTotal(Integer.parseInt(obj[2].toString()));
					}		
				}else{
					if(obj[3]!=null){
						temp.setShortQuantityTotal(Integer.parseInt(obj[3].toString()));
					}
					else{
						temp.setShortQuantityTotal(0);
					}
				}	
				System.out.println(" 商品Id "+temp.getProductId());
				shortProductsTotal.add(temp);
			}

		}catch(Exception e){
			e.printStackTrace();
//			session.getTransaction().rollback();
		}finally{
//			for(ShortProductTotal s:shortProductsTotal){
//			System.out.println("proId: "+s.getProductId()+"  "+"proQuantity"+s.getShortQuantityTotal());
//			}
//			session.close();
		}
		return shortProductsTotal;
	}
}
