prompt PL/SQL Developer import file
prompt Created on 2011年8月9日 by ttc
set feedback off
set define off
prompt Dropping L_ROLE...
drop table L_ROLE cascade constraints;
prompt Dropping L_USER...
drop table L_USER cascade constraints;
prompt Dropping L_WAREHOUSE...
drop table L_WAREHOUSE cascade constraints;
prompt Dropping L_SUBSTATION...
drop table L_SUBSTATION cascade constraints;
prompt Dropping L_CUSTOMER...
drop table L_CUSTOMER cascade constraints;
prompt Dropping L_ORDER...
drop table L_ORDER cascade constraints;
prompt Dropping L_ALLOCATIONORDER...
drop table L_ALLOCATIONORDER cascade constraints;
prompt Dropping L_CANCELORDER...
drop table L_CANCELORDER cascade constraints;
prompt Dropping L_CATEGORY...
drop table L_CATEGORY cascade constraints;
prompt Dropping L_SUPPLIER...
drop table L_SUPPLIER cascade constraints;
prompt Dropping L_PRODUCT...
drop table L_PRODUCT cascade constraints;
prompt Dropping L_CHANGEPRODUCTORDER...
drop table L_CHANGEPRODUCTORDER cascade constraints;
prompt Dropping L_OUTSTORAGEORDER...
drop table L_OUTSTORAGEORDER cascade constraints;
prompt Dropping L_DISPATCHORDER...
drop table L_DISPATCHORDER cascade constraints;
prompt Dropping L_DISPATCHORDERITEM...
drop table L_DISPATCHORDERITEM cascade constraints;
prompt Dropping L_FEEDBACKORDER...
drop table L_FEEDBACKORDER cascade constraints;
prompt Dropping L_TASKORDER...
drop table L_TASKORDER cascade constraints;
prompt Dropping L_FUNCTION...
drop table L_FUNCTION cascade constraints;
prompt Dropping L_ORDERITEM...
drop table L_ORDERITEM cascade constraints;
prompt Dropping L_OUTSTORAGEORDERITEM...
drop table L_OUTSTORAGEORDERITEM cascade constraints;
prompt Dropping L_PURCHASEINSTORAGEORDER...
drop table L_PURCHASEINSTORAGEORDER cascade constraints;
prompt Dropping L_PURCHASEPRODUCTORDER...
drop table L_PURCHASEPRODUCTORDER cascade constraints;
prompt Dropping L_PURCHASEPINSTORAGEORDERITEM...
drop table L_PURCHASEPINSTORAGEORDERITEM cascade constraints;
prompt Dropping L_RETURNPRODUCTORDER...
drop table L_RETURNPRODUCTORDER cascade constraints;
prompt Dropping L_SHORTAGEORDER...
drop table L_SHORTAGEORDER cascade constraints;
prompt Dropping L_SIGNEDORDER...
drop table L_SIGNEDORDER cascade constraints;
prompt Dropping L_STORAGEINFO...
drop table L_STORAGEINFO cascade constraints;
prompt Dropping L_SUBSATIONINSTORAGEORDER...
drop table L_SUBSATIONINSTORAGEORDER cascade constraints;
prompt Dropping L_SUBSATIONINSTORAGEORDERITEM...
drop table L_SUBSATIONINSTORAGEORDERITEM cascade constraints;
prompt Dropping L_SUBSTATIONEMPLOYEE...
drop table L_SUBSTATIONEMPLOYEE cascade constraints;
prompt Dropping L_TAKEPRODUCTORDER...
drop table L_TAKEPRODUCTORDER cascade constraints;
prompt Creating L_ROLE...
create table L_ROLE
(
  ROLEID   NUMBER(10) not null,
  ROLENAME VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ROLE
  add primary key (ROLEID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating L_USER...
create table L_USER
(
  USERID   NUMBER(10) not null,
  ROLE     NUMBER(10),
  USERNAME VARCHAR2(20),
  PASSWD   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_USER
  add primary key (USERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_USER
  add constraint FK8712EBDE1C9BC35C foreign key (ROLE)
  references L_ROLE (ROLEID);

prompt Creating L_WAREHOUSE...
create table L_WAREHOUSE
(
  WAREHOUSEID      NUMBER(10) not null,
  WAREHOUSEMANAGER NUMBER(10),
  WAREHOUSENAME    VARCHAR2(20),
  WAREHOUSEADDRESS VARCHAR2(40),
  WAREHOUSETYPE    VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_WAREHOUSE
  add primary key (WAREHOUSEID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_WAREHOUSE
  add constraint FKA2D5670CF1171C5 foreign key (WAREHOUSEMANAGER)
  references L_USER (USERID);

prompt Creating L_SUBSTATION...
create table L_SUBSTATION
(
  SUBSTATIONID  NUMBER(10) not null,
  WAREHOUSE     NUMBER(10),
  SUBSTATIONADD VARCHAR2(40),
  SUBSTATIONTEL VARCHAR2(14)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSTATION
  add primary key (SUBSTATIONID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSTATION
  add constraint FK79E914C7DEF5B916 foreign key (WAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);

prompt Creating L_CUSTOMER...
create table L_CUSTOMER
(
  CUSTOMERID      NUMBER(10) not null,
  CUSTOMERNAME    VARCHAR2(20),
  IDCARD          VARCHAR2(20),
  WORKPLACE       VARCHAR2(40),
  PHONE           VARCHAR2(14),
  MOBILE          VARCHAR2(14),
  ADDRESS         VARCHAR2(40),
  CUSTOMERZIPCODE VARCHAR2(12),
  EMAIL           VARCHAR2(40)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CUSTOMER
  add primary key (CUSTOMERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating L_ORDER...
create table L_ORDER
(
  ORDERID            NUMBER(10) not null,
  CHECKOUTSUBSTATION NUMBER(10),
  DELIVERSUBSTATION  NUMBER(10),
  OPERATOR           NUMBER(10),
  CUSTOMER           NUMBER(10),
  ORDERSTATE         VARCHAR2(20),
  REQUIREDDATE       DATE,
  ORDERDATE          DATE,
  ORDERTYPE          VARCHAR2(10),
  RECEIVEADD         VARCHAR2(40),
  RECEIVEPERSON      VARCHAR2(20),
  RECEIVEPERSONTEL   VARCHAR2(14),
  RECEIVEPERSONZIP   VARCHAR2(10),
  INVOICEREQUIRED    NUMBER(10),
  PAYER              VARCHAR2(20),
  PAYERADD           VARCHAR2(40),
  PAYERTEL           VARCHAR2(14),
  PAYERZIPCODE       VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ORDER
  add primary key (ORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ORDER
  add constraint FK5AF5897B806D0A2C foreign key (CUSTOMER)
  references L_CUSTOMER (CUSTOMERID);
alter table L_ORDER
  add constraint FK5AF5897BD15B433D foreign key (DELIVERSUBSTATION)
  references L_SUBSTATION (SUBSTATIONID);
alter table L_ORDER
  add constraint FK5AF5897BD2C0921E foreign key (CHECKOUTSUBSTATION)
  references L_SUBSTATION (SUBSTATIONID);
alter table L_ORDER
  add constraint FK5AF5897BFE91D6DF foreign key (OPERATOR)
  references L_USER (USERID);

prompt Creating L_ALLOCATIONORDER...
create table L_ALLOCATIONORDER
(
  ALLOCATIONORDERID NUMBER(10) not null,
  OPERATOR          NUMBER(10),
  FROMORDER         NUMBER(10),
  ALLOCATIONDATE    DATE,
  ALLOCATIONSTATE   VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ALLOCATIONORDER
  add primary key (ALLOCATIONORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ALLOCATIONORDER
  add constraint FKD5A59C5B75E8BCC2 foreign key (FROMORDER)
  references L_ORDER (ORDERID);
alter table L_ALLOCATIONORDER
  add constraint FKD5A59C5BFE91D6DF foreign key (OPERATOR)
  references L_USER (USERID);

prompt Creating L_CANCELORDER...
create table L_CANCELORDER
(
  CANCELORDERID NUMBER(10) not null,
  FROMORDER     NUMBER(10),
  CANCELREASON  VARCHAR2(255),
  CANCELDATE    DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CANCELORDER
  add primary key (CANCELORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CANCELORDER
  add constraint FKCD59358175E8BCC2 foreign key (FROMORDER)
  references L_ORDER (ORDERID);

prompt Creating L_CATEGORY...
create table L_CATEGORY
(
  CATEGORYID     NUMBER(10) not null,
  PARENTCATEGORY NUMBER(10),
  CATEGORYNAME   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CATEGORY
  add primary key (CATEGORYID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CATEGORY
  add constraint FKBCDB7391C0C44316 foreign key (PARENTCATEGORY)
  references L_CATEGORY (CATEGORYID);

prompt Creating L_SUPPLIER...
create table L_SUPPLIER
(
  SUPPLIERID      NUMBER(10) not null,
  SUPPLIERNAME    VARCHAR2(20),
  SUPPLIERADD     VARCHAR2(40),
  CONTACTPERSON   VARCHAR2(20),
  SUPPLIERTEL     VARCHAR2(14),
  BANK            VARCHAR2(40),
  BANKACCOUNT     VARCHAR2(40),
  FAX             VARCHAR2(14),
  SUPPLIERZIPCODE VARCHAR2(10),
  LEGALPERSON     VARCHAR2(20),
  SUPPLIERREMARK  VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUPPLIER
  add primary key (SUPPLIERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating L_PRODUCT...
create table L_PRODUCT
(
  PRODUCTID       NUMBER(10) not null,
  SUPPLIER        NUMBER(10),
  CATEGORY        NUMBER(10),
  PRODUCTNAME     VARCHAR2(20),
  UNIT            VARCHAR2(10),
  ORIGINALPRICE   FLOAT,
  DISCOUNT        FLOAT,
  COSTPRICE       FLOAT,
  PRODUCTTYPE     VARCHAR2(10),
  MANUFACTURER    VARCHAR2(20),
  GUARANTEEPERIOD DATE,
  RETURNABLE      NUMBER(10),
  CHANGEABLE      NUMBER(10),
  PRODUCTREMARK   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PRODUCT
  add primary key (PRODUCTID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PRODUCT
  add constraint FKA939F3DC3E2F846C foreign key (CATEGORY)
  references L_CATEGORY (CATEGORYID);
alter table L_PRODUCT
  add constraint FKA939F3DC71E1FE08 foreign key (SUPPLIER)
  references L_SUPPLIER (SUPPLIERID);

prompt Creating L_CHANGEPRODUCTORDER...
create table L_CHANGEPRODUCTORDER
(
  CHANGEPRODUCTORDERID NUMBER(10) not null,
  PRODUCT              NUMBER(10),
  FROMORDER            NUMBER(10),
  CHANGEQUANTITY       NUMBER(10),
  CHANGEREASON         VARCHAR2(255),
  CHANGEDATE           DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CHANGEPRODUCTORDER
  add primary key (CHANGEPRODUCTORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_CHANGEPRODUCTORDER
  add constraint FK946A4A42694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);
alter table L_CHANGEPRODUCTORDER
  add constraint FK946A4A4275E8BCC2 foreign key (FROMORDER)
  references L_ORDER (ORDERID);

prompt Creating L_OUTSTORAGEORDER...
create table L_OUTSTORAGEORDER
(
  OUTSTORAGEORDERID NUMBER(10) not null,
  WAREHOUSE         NUMBER(10),
  OUTSTORAGEDATE    DATE,
  OUTSTORAGEREMARK  VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_OUTSTORAGEORDER
  add primary key (OUTSTORAGEORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_OUTSTORAGEORDER
  add constraint FK64649DEEDEF5B916 foreign key (WAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);

prompt Creating L_DISPATCHORDER...
create table L_DISPATCHORDER
(
  DISPATCHORDERID    NUMBER(10) not null,
  WAREHOUSE          NUMBER(10),
  SIGNEDMAN          NUMBER(10),
  OPERATOR           NUMBER(10),
  OUTSTORAGEORDER    NUMBER(10),
  DISPATCHMAN        NUMBER(10),
  DIPATCHORDERREMARK VARCHAR2(255),
  DIPATCHDATE        DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_DISPATCHORDER
  add primary key (DISPATCHORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_DISPATCHORDER
  add constraint FKBAE174415BF104DB foreign key (DISPATCHMAN)
  references L_USER (USERID);
alter table L_DISPATCHORDER
  add constraint FKBAE174415C963EF9 foreign key (SIGNEDMAN)
  references L_USER (USERID);
alter table L_DISPATCHORDER
  add constraint FKBAE174415F5E4392 foreign key (OUTSTORAGEORDER)
  references L_OUTSTORAGEORDER (OUTSTORAGEORDERID);
alter table L_DISPATCHORDER
  add constraint FKBAE17441DEF5B916 foreign key (WAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);
alter table L_DISPATCHORDER
  add constraint FKBAE17441FE91D6DF foreign key (OPERATOR)
  references L_USER (USERID);

prompt Creating L_DISPATCHORDERITEM...
create table L_DISPATCHORDERITEM
(
  DISPATCHORDERITEMID NUMBER(10) not null,
  DISPATCHORDER       NUMBER(10),
  PRODUCT             NUMBER(10),
  PRODUCTQUANTITY     NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_DISPATCHORDERITEM
  add primary key (DISPATCHORDERITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_DISPATCHORDERITEM
  add constraint FKC8BDDED4254C0998 foreign key (DISPATCHORDER)
  references L_DISPATCHORDER (DISPATCHORDERID);
alter table L_DISPATCHORDERITEM
  add constraint FKC8BDDED4694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);

prompt Creating L_FEEDBACKORDER...
create table L_FEEDBACKORDER
(
  FEEDBACKORDERID NUMBER(10) not null,
  TASKORDER       NUMBER(10),
  TASKSTATE       VARCHAR2(10),
  SATISFACTION    NUMBER(10),
  FEEDBACKREMARK  VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_FEEDBACKORDER
  add primary key (FEEDBACKORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_FEEDBACKORDER
  add constraint FKC4DA7C16E2A64D42 foreign key (TASKORDER)
  references L_TASKORDER (TASKORDERID);

prompt Creating L_TASKORDER...
create table L_TASKORDER
(
  TASKORDERID    NUMBER(10) not null,
  FORORDER       NUMBER(10),
  DELIVERMAN     NUMBER(10),
  OPERATOR       NUMBER(10),
  TASKORDERSTATE VARCHAR2(10),
  TASKORDERTYPE  VARCHAR2(10),
  OPERATEDATE    DATE,
  FEEDBACKORDER  NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_TASKORDER
  add primary key (TASKORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_TASKORDER
  add constraint FK8CE718965CA57C50 foreign key (DELIVERMAN)
  references L_USER (USERID);
alter table L_TASKORDER
  add constraint FK8CE718968C9EA303 foreign key (FORORDER)
  references L_ORDER (ORDERID);
alter table L_TASKORDER
  add constraint FK8CE71896B0B03922 foreign key (FEEDBACKORDER)
  references L_FEEDBACKORDER (FEEDBACKORDERID);
alter table L_TASKORDER
  add constraint FK8CE71896FE91D6DF foreign key (OPERATOR)
  references L_USER (USERID);

prompt Creating L_FUNCTION...
create table L_FUNCTION
(
  FUNCTIONID   NUMBER not null,
  ROLEID       NUMBER,
  PARENT       NUMBER,
  FUNCTIONNAME VARCHAR2(40),
  ISLEAF       VARCHAR2(2),
  ICONCLS      VARCHAR2(20),
  ROLE         NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_FUNCTION
  add constraint PK_L_FUNCTION primary key (FUNCTIONID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_FUNCTION
  add constraint FKC282A6B1C9BC35C foreign key (ROLE)
  references L_ROLE (ROLEID);
alter table L_FUNCTION
  add constraint FK_PARENT foreign key (PARENT)
  references L_FUNCTION (FUNCTIONID);
alter table L_FUNCTION
  add constraint FK_ROLEID foreign key (ROLEID)
  references L_ROLE (ROLEID);

prompt Creating L_ORDERITEM...
create table L_ORDERITEM
(
  ORDERITEMID     NUMBER(10) not null,
  PRODUCT         NUMBER(10),
  TOORDER         NUMBER(10),
  FIRSTCATERGORY  VARCHAR2(10),
  SECONDCATEGORY  VARCHAR2(10),
  PRODUCTNAME     VARCHAR2(20),
  UNIT            VARCHAR2(10),
  ORIGINALPRICE   FLOAT,
  DISCOUNT        FLOAT,
  PRODUCTREMARK   VARCHAR2(255),
  ORDERITEMAMOUNT NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ORDERITEM
  add primary key (ORDERITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_ORDERITEM
  add constraint FK69F0C70E2C476091 foreign key (TOORDER)
  references L_ORDER (ORDERID);
alter table L_ORDERITEM
  add constraint FK69F0C70E694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);

prompt Creating L_OUTSTORAGEORDERITEM...
create table L_OUTSTORAGEORDERITEM
(
  OUTSTORAGEORDERITEMID NUMBER(10) not null,
  PRODUCT               NUMBER(10),
  OUTSTORAGEORDER       NUMBER(10),
  PRODUCTQUANTITY       NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_OUTSTORAGEORDERITEM
  add primary key (OUTSTORAGEORDERITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_OUTSTORAGEORDERITEM
  add constraint FK440A6A015F5E4392 foreign key (OUTSTORAGEORDER)
  references L_OUTSTORAGEORDER (OUTSTORAGEORDERID);
alter table L_OUTSTORAGEORDERITEM
  add constraint FK440A6A01694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);

prompt Creating L_PURCHASEINSTORAGEORDER...
create table L_PURCHASEINSTORAGEORDER
(
  PURCHASEINSTORAGEORDERID NUMBER(10) not null,
  PRODUCTPURCHASESTATE     VARCHAR2(10),
  PURCHASEDATE             DATE,
  PUCHASEREMARK            VARCHAR2(255),
  WAREHOUSE                NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PURCHASEINSTORAGEORDER
  add primary key (PURCHASEINSTORAGEORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PURCHASEINSTORAGEORDER
  add constraint FK8A1FE3ECDEF5B916 foreign key (WAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);

prompt Creating L_PURCHASEPRODUCTORDER...
create table L_PURCHASEPRODUCTORDER
(
  PURCHASEPRODUCTORDERID NUMBER(10) not null,
  PRODUCT                NUMBER(10),
  PRODUCTQUANTITY        NUMBER(10),
  PURCHASEREMARK         VARCHAR2(255),
  PURCHASEDATE           DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PURCHASEPRODUCTORDER
  add primary key (PURCHASEPRODUCTORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PURCHASEPRODUCTORDER
  add constraint FKE9395D53694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);

prompt Creating L_PURCHASEPINSTORAGEORDERITEM...
create table L_PURCHASEPINSTORAGEORDERITEM
(
  PURCHASEINSTORAGEORDERITEMID NUMBER(10) not null,
  PRODUCT                      NUMBER(10),
  PURCHASEPRODUCTORDER         NUMBER(10),
  PURCHASEINSTORAGEORDER       NUMBER(10),
  REALPURCHASEQUANTITY         NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PURCHASEPINSTORAGEORDERITEM
  add primary key (PURCHASEINSTORAGEORDERITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_PURCHASEPINSTORAGEORDERITEM
  add constraint FK4231E2A7694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);
alter table L_PURCHASEPINSTORAGEORDERITEM
  add constraint FK4231E2A7E3924CF0 foreign key (PURCHASEPRODUCTORDER)
  references L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID);
alter table L_PURCHASEPINSTORAGEORDERITEM
  add constraint FK4231E2A7F6C86FA2 foreign key (PURCHASEINSTORAGEORDER)
  references L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID);

prompt Creating L_RETURNPRODUCTORDER...
create table L_RETURNPRODUCTORDER
(
  RETURNPRODUCTORDERID         NUMBER(10) not null,
  PRODUCT                      NUMBER(10),
  SUBWAREHOUSE                 NUMBER(10),
  CENTERWAREHOUSE              NUMBER(10),
  RETURNQUANTITY               NUMBER(10),
  RETURNREASON                 VARCHAR2(255),
  FROMORDER                    NUMBER(10),
  RETURNDATE                   DATE,
  RETURNTOSUBWAREHOUSESTATE    VARCHAR2(10),
  RETURNTOCENTERWAREHOUSESTATE VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_RETURNPRODUCTORDER
  add primary key (RETURNPRODUCTORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_RETURNPRODUCTORDER
  add constraint FK70EF33C23B0AFC61 foreign key (CENTERWAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);
alter table L_RETURNPRODUCTORDER
  add constraint FK70EF33C2694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);
alter table L_RETURNPRODUCTORDER
  add constraint FK70EF33C2E46602D6 foreign key (SUBWAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);

prompt Creating L_SHORTAGEORDER...
create table L_SHORTAGEORDER
(
  SHORTAGEORDERID  NUMBER(10) not null,
  PRODUCT          NUMBER(10),
  FROMORDER        NUMBER(10),
  SHORTAGEQUANTITY NUMBER(10),
  SHORTAGESTATE    VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SHORTAGEORDER
  add primary key (SHORTAGEORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SHORTAGEORDER
  add constraint FK5BB59358694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);
alter table L_SHORTAGEORDER
  add constraint FK5BB5935875E8BCC2 foreign key (FROMORDER)
  references L_ORDER (ORDERID);

prompt Creating L_SIGNEDORDER...
create table L_SIGNEDORDER
(
  SIGNEDORDERID      NUMBER(10) not null,
  DELIVERMAN         NUMBER(10),
  TASKORDER          NUMBER(10),
  SUBSATION          NUMBER(10),
  CUSTOMERSIGNATURE  VARCHAR2(20),
  CUSTOMERFEEDBACK   VARCHAR2(255),
  SIGNEDDATE         DATE,
  SIGNEDORDERREMARK  VARCHAR2(255),
  DELIVERREQIUREMENT VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SIGNEDORDER
  add primary key (SIGNEDORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SIGNEDORDER
  add constraint FK19170A1F5CA57C50 foreign key (DELIVERMAN)
  references L_USER (USERID);
alter table L_SIGNEDORDER
  add constraint FK19170A1FC7C98206 foreign key (SUBSATION)
  references L_SUBSTATION (SUBSTATIONID);
alter table L_SIGNEDORDER
  add constraint FK19170A1FE2A64D42 foreign key (TASKORDER)
  references L_TASKORDER (TASKORDERID);

prompt Creating L_STORAGEINFO...
create table L_STORAGEINFO
(
  STORAGEINFOID   NUMBER(10) not null,
  PRODUCT         NUMBER(10),
  WAREHOUSE       NUMBER(10),
  WARNINGQUANTITY NUMBER(10),
  MAXQUANTITY     NUMBER(10),
  REMAINQUANTITY  NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_STORAGEINFO
  add primary key (STORAGEINFOID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_STORAGEINFO
  add constraint FKADBD216694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);
alter table L_STORAGEINFO
  add constraint FKADBD216DEF5B916 foreign key (WAREHOUSE)
  references L_WAREHOUSE (WAREHOUSEID);

prompt Creating L_SUBSATIONINSTORAGEORDER...
create table L_SUBSATIONINSTORAGEORDER
(
  SUBSATIONINSTORAGEORDERID NUMBER(10) not null,
  DISPATCHORDER             NUMBER(10),
  INSTORAGEDATE             DATE,
  INSTORAGEREMARK           VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSATIONINSTORAGEORDER
  add primary key (SUBSATIONINSTORAGEORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSATIONINSTORAGEORDER
  add constraint FK5E657967254C0998 foreign key (DISPATCHORDER)
  references L_DISPATCHORDER (DISPATCHORDERID);

prompt Creating L_SUBSATIONINSTORAGEORDERITEM...
create table L_SUBSATIONINSTORAGEORDERITEM
(
  SUBSATIONINSTORAGEORDERITEMID NUMBER(10) not null,
  PRODUCT                       NUMBER(10),
  SUBSATIONINSTORAGEORDER       NUMBER(10),
  PRODUCTQUANTITY               NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSATIONINSTORAGEORDERITEM
  add primary key (SUBSATIONINSTORAGEORDERITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSATIONINSTORAGEORDERITEM
  add constraint FK52CEE0FA694E816E foreign key (PRODUCT)
  references L_PRODUCT (PRODUCTID);
alter table L_SUBSATIONINSTORAGEORDERITEM
  add constraint FK52CEE0FAF4B7DE56 foreign key (SUBSATIONINSTORAGEORDER)
  references L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID);

prompt Creating L_SUBSTATIONEMPLOYEE...
create table L_SUBSTATIONEMPLOYEE
(
  SUBSTATION NUMBER(10) not null,
  DELIVERMAN NUMBER(10) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSTATIONEMPLOYEE
  add primary key (DELIVERMAN, SUBSTATION)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSTATIONEMPLOYEE
  add unique (DELIVERMAN)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_SUBSTATIONEMPLOYEE
  add constraint FK909034755CA57C50 foreign key (DELIVERMAN)
  references L_USER (USERID);
alter table L_SUBSTATIONEMPLOYEE
  add constraint FK909034757C98A458 foreign key (SUBSTATION)
  references L_SUBSTATION (SUBSTATIONID);

prompt Creating L_TAKEPRODUCTORDER...
create table L_TAKEPRODUCTORDER
(
  TAKEPRODUCTORDERID NUMBER(10) not null,
  TAKER              VARCHAR2(100),
  TASKORDER          NUMBER(10),
  TAKEDATE           DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_TAKEPRODUCTORDER
  add primary key (TAKEPRODUCTORDERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table L_TAKEPRODUCTORDER
  add constraint FK5BAE7D59E2A64D42 foreign key (TASKORDER)
  references L_TASKORDER (TASKORDERID);

prompt Disabling triggers for L_ROLE...
alter table L_ROLE disable all triggers;
prompt Disabling triggers for L_USER...
alter table L_USER disable all triggers;
prompt Disabling triggers for L_WAREHOUSE...
alter table L_WAREHOUSE disable all triggers;
prompt Disabling triggers for L_SUBSTATION...
alter table L_SUBSTATION disable all triggers;
prompt Disabling triggers for L_CUSTOMER...
alter table L_CUSTOMER disable all triggers;
prompt Disabling triggers for L_ORDER...
alter table L_ORDER disable all triggers;
prompt Disabling triggers for L_ALLOCATIONORDER...
alter table L_ALLOCATIONORDER disable all triggers;
prompt Disabling triggers for L_CANCELORDER...
alter table L_CANCELORDER disable all triggers;
prompt Disabling triggers for L_CATEGORY...
alter table L_CATEGORY disable all triggers;
prompt Disabling triggers for L_SUPPLIER...
alter table L_SUPPLIER disable all triggers;
prompt Disabling triggers for L_PRODUCT...
alter table L_PRODUCT disable all triggers;
prompt Disabling triggers for L_CHANGEPRODUCTORDER...
alter table L_CHANGEPRODUCTORDER disable all triggers;
prompt Disabling triggers for L_OUTSTORAGEORDER...
alter table L_OUTSTORAGEORDER disable all triggers;
prompt Disabling triggers for L_DISPATCHORDER...
alter table L_DISPATCHORDER disable all triggers;
prompt Disabling triggers for L_DISPATCHORDERITEM...
alter table L_DISPATCHORDERITEM disable all triggers;
prompt Disabling triggers for L_FEEDBACKORDER...
alter table L_FEEDBACKORDER disable all triggers;
prompt Disabling triggers for L_TASKORDER...
alter table L_TASKORDER disable all triggers;
prompt Disabling triggers for L_FUNCTION...
alter table L_FUNCTION disable all triggers;
prompt Disabling triggers for L_ORDERITEM...
alter table L_ORDERITEM disable all triggers;
prompt Disabling triggers for L_OUTSTORAGEORDERITEM...
alter table L_OUTSTORAGEORDERITEM disable all triggers;
prompt Disabling triggers for L_PURCHASEINSTORAGEORDER...
alter table L_PURCHASEINSTORAGEORDER disable all triggers;
prompt Disabling triggers for L_PURCHASEPRODUCTORDER...
alter table L_PURCHASEPRODUCTORDER disable all triggers;
prompt Disabling triggers for L_PURCHASEPINSTORAGEORDERITEM...
alter table L_PURCHASEPINSTORAGEORDERITEM disable all triggers;
prompt Disabling triggers for L_RETURNPRODUCTORDER...
alter table L_RETURNPRODUCTORDER disable all triggers;
prompt Disabling triggers for L_SHORTAGEORDER...
alter table L_SHORTAGEORDER disable all triggers;
prompt Disabling triggers for L_SIGNEDORDER...
alter table L_SIGNEDORDER disable all triggers;
prompt Disabling triggers for L_STORAGEINFO...
alter table L_STORAGEINFO disable all triggers;
prompt Disabling triggers for L_SUBSATIONINSTORAGEORDER...
alter table L_SUBSATIONINSTORAGEORDER disable all triggers;
prompt Disabling triggers for L_SUBSATIONINSTORAGEORDERITEM...
alter table L_SUBSATIONINSTORAGEORDERITEM disable all triggers;
prompt Disabling triggers for L_SUBSTATIONEMPLOYEE...
alter table L_SUBSTATIONEMPLOYEE disable all triggers;
prompt Disabling triggers for L_TAKEPRODUCTORDER...
alter table L_TAKEPRODUCTORDER disable all triggers;
prompt Disabling foreign key constraints for L_USER...
alter table L_USER disable constraint FK8712EBDE1C9BC35C;
prompt Disabling foreign key constraints for L_WAREHOUSE...
alter table L_WAREHOUSE disable constraint FKA2D5670CF1171C5;
prompt Disabling foreign key constraints for L_SUBSTATION...
alter table L_SUBSTATION disable constraint FK79E914C7DEF5B916;
prompt Disabling foreign key constraints for L_ORDER...
alter table L_ORDER disable constraint FK5AF5897B806D0A2C;
alter table L_ORDER disable constraint FK5AF5897BD15B433D;
alter table L_ORDER disable constraint FK5AF5897BD2C0921E;
alter table L_ORDER disable constraint FK5AF5897BFE91D6DF;
prompt Disabling foreign key constraints for L_ALLOCATIONORDER...
alter table L_ALLOCATIONORDER disable constraint FKD5A59C5B75E8BCC2;
alter table L_ALLOCATIONORDER disable constraint FKD5A59C5BFE91D6DF;
prompt Disabling foreign key constraints for L_CANCELORDER...
alter table L_CANCELORDER disable constraint FKCD59358175E8BCC2;
prompt Disabling foreign key constraints for L_CATEGORY...
alter table L_CATEGORY disable constraint FKBCDB7391C0C44316;
prompt Disabling foreign key constraints for L_PRODUCT...
alter table L_PRODUCT disable constraint FKA939F3DC3E2F846C;
alter table L_PRODUCT disable constraint FKA939F3DC71E1FE08;
prompt Disabling foreign key constraints for L_CHANGEPRODUCTORDER...
alter table L_CHANGEPRODUCTORDER disable constraint FK946A4A42694E816E;
alter table L_CHANGEPRODUCTORDER disable constraint FK946A4A4275E8BCC2;
prompt Disabling foreign key constraints for L_OUTSTORAGEORDER...
alter table L_OUTSTORAGEORDER disable constraint FK64649DEEDEF5B916;
prompt Disabling foreign key constraints for L_DISPATCHORDER...
alter table L_DISPATCHORDER disable constraint FKBAE174415BF104DB;
alter table L_DISPATCHORDER disable constraint FKBAE174415C963EF9;
alter table L_DISPATCHORDER disable constraint FKBAE174415F5E4392;
alter table L_DISPATCHORDER disable constraint FKBAE17441DEF5B916;
alter table L_DISPATCHORDER disable constraint FKBAE17441FE91D6DF;
prompt Disabling foreign key constraints for L_DISPATCHORDERITEM...
alter table L_DISPATCHORDERITEM disable constraint FKC8BDDED4254C0998;
alter table L_DISPATCHORDERITEM disable constraint FKC8BDDED4694E816E;
prompt Disabling foreign key constraints for L_FEEDBACKORDER...
alter table L_FEEDBACKORDER disable constraint FKC4DA7C16E2A64D42;
prompt Disabling foreign key constraints for L_TASKORDER...
alter table L_TASKORDER disable constraint FK8CE718965CA57C50;
alter table L_TASKORDER disable constraint FK8CE718968C9EA303;
alter table L_TASKORDER disable constraint FK8CE71896B0B03922;
alter table L_TASKORDER disable constraint FK8CE71896FE91D6DF;
prompt Disabling foreign key constraints for L_FUNCTION...
alter table L_FUNCTION disable constraint FKC282A6B1C9BC35C;
alter table L_FUNCTION disable constraint FK_PARENT;
alter table L_FUNCTION disable constraint FK_ROLEID;
prompt Disabling foreign key constraints for L_ORDERITEM...
alter table L_ORDERITEM disable constraint FK69F0C70E2C476091;
alter table L_ORDERITEM disable constraint FK69F0C70E694E816E;
prompt Disabling foreign key constraints for L_OUTSTORAGEORDERITEM...
alter table L_OUTSTORAGEORDERITEM disable constraint FK440A6A015F5E4392;
alter table L_OUTSTORAGEORDERITEM disable constraint FK440A6A01694E816E;
prompt Disabling foreign key constraints for L_PURCHASEINSTORAGEORDER...
alter table L_PURCHASEINSTORAGEORDER disable constraint FK8A1FE3ECDEF5B916;
prompt Disabling foreign key constraints for L_PURCHASEPRODUCTORDER...
alter table L_PURCHASEPRODUCTORDER disable constraint FKE9395D53694E816E;
prompt Disabling foreign key constraints for L_PURCHASEPINSTORAGEORDERITEM...
alter table L_PURCHASEPINSTORAGEORDERITEM disable constraint FK4231E2A7694E816E;
alter table L_PURCHASEPINSTORAGEORDERITEM disable constraint FK4231E2A7E3924CF0;
alter table L_PURCHASEPINSTORAGEORDERITEM disable constraint FK4231E2A7F6C86FA2;
prompt Disabling foreign key constraints for L_RETURNPRODUCTORDER...
alter table L_RETURNPRODUCTORDER disable constraint FK70EF33C23B0AFC61;
alter table L_RETURNPRODUCTORDER disable constraint FK70EF33C2694E816E;
alter table L_RETURNPRODUCTORDER disable constraint FK70EF33C2E46602D6;
prompt Disabling foreign key constraints for L_SHORTAGEORDER...
alter table L_SHORTAGEORDER disable constraint FK5BB59358694E816E;
alter table L_SHORTAGEORDER disable constraint FK5BB5935875E8BCC2;
prompt Disabling foreign key constraints for L_SIGNEDORDER...
alter table L_SIGNEDORDER disable constraint FK19170A1F5CA57C50;
alter table L_SIGNEDORDER disable constraint FK19170A1FC7C98206;
alter table L_SIGNEDORDER disable constraint FK19170A1FE2A64D42;
prompt Disabling foreign key constraints for L_STORAGEINFO...
alter table L_STORAGEINFO disable constraint FKADBD216694E816E;
alter table L_STORAGEINFO disable constraint FKADBD216DEF5B916;
prompt Disabling foreign key constraints for L_SUBSATIONINSTORAGEORDER...
alter table L_SUBSATIONINSTORAGEORDER disable constraint FK5E657967254C0998;
prompt Disabling foreign key constraints for L_SUBSATIONINSTORAGEORDERITEM...
alter table L_SUBSATIONINSTORAGEORDERITEM disable constraint FK52CEE0FA694E816E;
alter table L_SUBSATIONINSTORAGEORDERITEM disable constraint FK52CEE0FAF4B7DE56;
prompt Disabling foreign key constraints for L_SUBSTATIONEMPLOYEE...
alter table L_SUBSTATIONEMPLOYEE disable constraint FK909034755CA57C50;
alter table L_SUBSTATIONEMPLOYEE disable constraint FK909034757C98A458;
prompt Disabling foreign key constraints for L_TAKEPRODUCTORDER...
alter table L_TAKEPRODUCTORDER disable constraint FK5BAE7D59E2A64D42;
prompt Loading L_ROLE...
insert into L_ROLE (ROLEID, ROLENAME)
values (1, '客户服务中心管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (2, '调度中心管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (3, '分站管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (4, '中心库房管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (5, '分站库房管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (6, '配送中心管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (7, '财务管理员');
insert into L_ROLE (ROLEID, ROLENAME)
values (8, '配送员');
insert into L_ROLE (ROLEID, ROLENAME)
values (0, '系统管理员');
commit;
prompt 9 records loaded
prompt Loading L_USER...
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (84, 8, '配送员D', '84');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (85, 8, '配送员E', '85');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (86, 8, '配送员F', '86');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (87, 8, '配送员G', '87');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (888, 8, '配送员H', '888');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (89, 8, '配送员I', '89');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (81, 8, '配送员A', '81');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (82, 8, '配送员B', '82');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (83, 8, '配送员C', '83');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (32, 3, '李莎', '32');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (31, 3, '李莎', '31');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (99, 5, '周诗龙', '99');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (11, 1, '小猫', '11');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (22, 2, '小美', '22');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (33, 3, '李莎', '33');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (44, 4, '李亚方', '44');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (55, 5, '李亚方', '55');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (66, 6, '李亚方', '66');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (88, 0, '李亚方', '88');
insert into L_USER (USERID, ROLE, USERNAME, PASSWD)
values (373, 5, '莎莎', 'ss');
commit;
prompt 20 records loaded
prompt Loading L_WAREHOUSE...
insert into L_WAREHOUSE (WAREHOUSEID, WAREHOUSEMANAGER, WAREHOUSENAME, WAREHOUSEADDRESS, WAREHOUSETYPE)
values (804, 373, '地字号', '辽宁沈阳', '分库');
insert into L_WAREHOUSE (WAREHOUSEID, WAREHOUSEMANAGER, WAREHOUSENAME, WAREHOUSEADDRESS, WAREHOUSETYPE)
values (805, 44, '天字号', '辽宁沈阳', '中心库房');
insert into L_WAREHOUSE (WAREHOUSEID, WAREHOUSEMANAGER, WAREHOUSENAME, WAREHOUSEADDRESS, WAREHOUSETYPE)
values (806, 99, '坤字号', '上海', '分库');
insert into L_WAREHOUSE (WAREHOUSEID, WAREHOUSEMANAGER, WAREHOUSENAME, WAREHOUSEADDRESS, WAREHOUSETYPE)
values (807, 55, '坤龙分库房', '山东', '分库');
commit;
prompt 4 records loaded
prompt Loading L_SUBSTATION...
insert into L_SUBSTATION (SUBSTATIONID, WAREHOUSE, SUBSTATIONADD, SUBSTATIONTEL)
values (1000, 804, '辽宁沈阳', '13998874428');
insert into L_SUBSTATION (SUBSTATIONID, WAREHOUSE, SUBSTATIONADD, SUBSTATIONTEL)
values (1001, 807, '山东', '13998874429');
insert into L_SUBSTATION (SUBSTATIONID, WAREHOUSE, SUBSTATIONADD, SUBSTATIONTEL)
values (1002, 806, '上海', '13998874428');
commit;
prompt 3 records loaded
prompt Loading L_CUSTOMER...
insert into L_CUSTOMER (CUSTOMERID, CUSTOMERNAME, IDCARD, WORKPLACE, PHONE, MOBILE, ADDRESS, CUSTOMERZIPCODE, EMAIL)
values (798, '张文华', '140121198910666666', '东软集团', '024-83682222', '13840331029', '东大九舍A区', '110004', '123@163.com');
insert into L_CUSTOMER (CUSTOMERID, CUSTOMERNAME, IDCARD, WORKPLACE, PHONE, MOBILE, ADDRESS, CUSTOMERZIPCODE, EMAIL)
values (800, '宋延杰', '140777777777777x', '东软', null, '13998874429', '东大九舍A区', '77', null);
insert into L_CUSTOMER (CUSTOMERID, CUSTOMERNAME, IDCARD, WORKPLACE, PHONE, MOBILE, ADDRESS, CUSTOMERZIPCODE, EMAIL)
values (803, '李莎', '234', null, null, '324', '东大', null, null);
insert into L_CUSTOMER (CUSTOMERID, CUSTOMERNAME, IDCARD, WORKPLACE, PHONE, MOBILE, ADDRESS, CUSTOMERZIPCODE, EMAIL)
values (1243, '周诗龙', '1401555555555555', '东软集团', '024-5555555', '139666666666', '东北大学三舍', '110004', '126@126.com');
insert into L_CUSTOMER (CUSTOMERID, CUSTOMERNAME, IDCARD, WORKPLACE, PHONE, MOBILE, ADDRESS, CUSTOMERZIPCODE, EMAIL)
values (801, '李亚方', '123435455657676787', null, null, '13998855555', '东大三舍', null, null);
insert into L_CUSTOMER (CUSTOMERID, CUSTOMERNAME, IDCARD, WORKPLACE, PHONE, MOBILE, ADDRESS, CUSTOMERZIPCODE, EMAIL)
values (2071, '陈秀能', '213', '东软', '024-34325235', '13745234523', '东大', null, '21@126.com');
commit;
prompt 6 records loaded
prompt Loading L_ORDER...
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (921, 1000, 1001, 88, 800, '已调度', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '张小猫', null, '123456789', '110004');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (926, 1001, 1000, 88, 800, '已调度', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('03-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '张小猫', null, '123456789', '110004');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (946, null, 1000, 11, 803, '已调度', to_date('01-08-2011', 'dd-mm-yyyy'), to_date('26-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (965, null, 1002, 88, 801, '已调度', to_date('02-09-2011', 'dd-mm-yyyy'), to_date('31-07-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (971, null, null, 88, 801, '缺货', to_date('17-08-2011', 'dd-mm-yyyy'), to_date('31-07-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (994, null, 1001, 31, 798, '已领货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1049, null, 1001, 11, 800, '已完成', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1123, null, 1001, 88, 798, '已调度', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1245, null, 1001, 11, 1243, '已分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1248, null, 1001, 11, 803, '已分配', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1285, null, 1001, 11, 800, '已分配', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '小猫', '辽宁', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1288, null, 1001, 11, 800, '已分配', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '小猫', '辽宁', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1325, null, 1001, 11, 1243, '已调度', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1330, null, 1001, 11, 1243, '已调度', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1766, null, 1001, 11, 1243, '已调度', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1769, null, 1002, 11, 1243, '已调度', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1844, null, null, 11, 798, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '张文华', '13840331029', '110004', 0, '小猫', '东大', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1867, null, null, 88, 800, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '张文华', '沈阳', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2138, null, null, 11, 798, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2141, null, null, 11, 1243, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (863, 1002, 1001, 88, 803, '已领货', to_date('07-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '异地收费', '东大', '李莎', '324', null, 0, '小猫', '东北大学', '1123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (885, 1000, 1000, 88, 800, '已分配', to_date('06-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '小美', '沈阳', '123456789', '110004');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (891, null, 1000, 88, 798, '已调度', to_date('08-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (979, null, 1002, 88, 803, '已调度', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('31-07-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (984, null, 1002, 88, 801, '已调度', to_date('26-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (990, null, null, 31, 803, '缺货', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('01-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1005, null, 1001, 11, 801, '已领货', to_date('06-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1033, null, 1001, 11, 801, '已分配', to_date('06-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1086, null, 1000, 88, 803, '已调度', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1091, 1000, 1000, 88, 803, '已调度', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '异地收费', '东大', '李莎', '324', null, 0, '张文华', '东大', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1111, null, null, 88, 801, '缺货', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1254, 1001, 1000, 11, 1243, '已完成', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '异地收费', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, '小美', '东大', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1291, null, 1001, 11, 800, '分站到货', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1323, null, 1001, 11, 1243, '已完成', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1327, null, null, 11, 1243, '缺货', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1351, null, 1001, 88, 798, '已分配', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1356, null, 1001, 88, 800, '已分配', to_date('31-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1359, null, 1000, 88, 801, '已调度', to_date('02-09-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1367, null, 1000, 88, 1243, '已调度', to_date('10-09-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1380, null, 1001, 88, 801, '已调度', to_date('22-08-2011', 'dd-mm-yyyy'), to_date('07-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1393, null, 1000, 88, 803, '已调度', to_date('31-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1396, null, null, 88, 801, '缺货', to_date('07-09-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1554, null, null, 88, 1243, '可分配', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1757, null, null, 11, 803, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1834, 1000, 1002, 11, 803, '中心库房出库', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大', '李莎', '324', null, 0, '小美', '辽宁省沈阳市', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1859, null, 1000, 88, 803, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1964, null, null, 88, 800, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (956, null, 1000, 88, 800, '已调度', to_date('31-08-2011', 'dd-mm-yyyy'), to_date('02-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (831, null, 1001, 88, 800, '已完成', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (996, null, 1002, 31, 800, '中心库房出库', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (889, null, 1002, 88, 803, '已调度', to_date('08-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (894, null, 1001, 88, 798, '已完成', to_date('08-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (940, null, 1002, 88, 803, '中心库房出库', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('01-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (962, null, 1001, 11, 800, '已完成', to_date('01-08-2011', 'dd-mm-yyyy'), to_date('31-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1035, null, 1001, 11, 801, '已分配', to_date('06-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1213, null, 1002, 88, 801, '中心库房出库', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1220, null, 1001, 88, 800, '已分配', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1231, null, null, 88, 801, '缺货', to_date('08-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1505, null, null, 11, 1243, '可分配', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1613, null, null, 88, 801, '缺货', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1729, null, null, 88, 803, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1733, null, 1001, 11, 798, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '张文华', '13840331029', '110004', 0, '张文华', '潍坊', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1740, null, 1001, 11, 798, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '张文华', '13840331029', '110004', 0, '张文华', '潍坊', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1743, null, 1000, 11, 800, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '张文华', '山西', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1979, null, null, 88, 800, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2017, null, null, 88, 1243, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2035, null, null, 88, 800, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2072, null, 1002, 11, 2071, '中心库房出库', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大', '陈秀能', '13745234523', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2094, null, 1002, 11, 1243, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2143, 1002, 1002, 11, 800, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '张文华', '沈阳', '12', '23');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (857, null, 1000, 88, 801, '已分配', to_date('08-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (913, null, 1001, 33, 800, '已领货', to_date('26-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (918, null, 1002, 11, 800, '中心库房出库', to_date('06-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1007, null, 1001, 88, 803, '已完成', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('31-07-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1015, null, 1001, 88, 803, '已分配', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('05-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1029, null, 1002, 32, 800, '中心库房出库', to_date('18-08-2011', 'dd-mm-yyyy'), to_date('01-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1127, null, 1002, 88, 798, '中心库房出库', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '张文华', '13840331029', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1129, 1000, 1001, 88, 801, '已调度', to_date('10-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '异地收费', '东大三舍', '李亚方', '13998855555', null, 0, '李亚方', '辽宁', '123', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1155, null, 1001, 88, 800, '已调度', to_date('09-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1347, null, 1002, 88, 803, '中心库房出库', to_date('27-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1364, null, 1000, 88, 801, '已完成', to_date('25-08-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1387, null, 1002, 88, 803, '中心库房出库', to_date('10-09-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (1401, null, 1000, 88, 801, '已调度', to_date('07-09-2011', 'dd-mm-yyyy'), to_date('08-08-2011', 'dd-mm-yyyy'), '新订', '东大三舍', '李亚方', '13998855555', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2014, null, null, 88, 803, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大', '李莎', '324', null, 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2025, null, null, 88, 800, '可分配', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东大九舍A区', '宋延杰', '13998874429', '77', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2030, 1000, 1001, 88, 800, '已调度', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '宋延杰', '13998874429', '77', 0, '小美', '沈阳', '213', '123');
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2038, null, 1001, 88, 1243, '已调度', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '新订', '东北大学三舍', '周诗龙', '139666666666', '110004', 0, null, null, null, null);
insert into L_ORDER (ORDERID, CHECKOUTSUBSTATION, DELIVERSUBSTATION, OPERATOR, CUSTOMER, ORDERSTATE, REQUIREDDATE, ORDERDATE, ORDERTYPE, RECEIVEADD, RECEIVEPERSON, RECEIVEPERSONTEL, RECEIVEPERSONZIP, INVOICEREQUIRED, PAYER, PAYERADD, PAYERTEL, PAYERZIPCODE)
values (2041, null, null, 88, 798, '缺货', to_date('11-08-2011', 'dd-mm-yyyy'), to_date('09-08-2011', 'dd-mm-yyyy'), '异地收费', '东大九舍A区', '张文华', '13840331029', '110004', 0, '张', '沈阳', '123', '123');
commit;
prompt 88 records loaded
prompt Loading L_ALLOCATIONORDER...
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (867, 88, 857, to_date('05-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (869, 88, 863, to_date('05-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1117, 88, 962, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1771, 88, 1766, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1832, 88, 1367, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1837, 88, 1834, to_date('09-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (2074, 22, 2038, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1161, 88, 885, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (2077, 22, 2072, to_date('09-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (2099, 22, 1380, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (849, 88, 831, to_date('05-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (953, 88, 918, to_date('05-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1260, 22, 863, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1468, 88, 1364, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1470, 88, 1347, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1472, 88, 1127, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1474, 88, 1029, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1476, 88, 1015, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1478, 88, 1213, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1480, 88, 1035, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1482, 88, 956, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1484, 88, 1393, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1486, 88, 1359, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1488, 88, 1356, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1490, 88, 1351, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1492, 88, 1291, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1494, 88, 1033, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1496, 88, 979, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1498, 88, 1330, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1500, 88, 1325, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1503, 88, 1401, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1754, 88, 1155, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (2032, 22, 2030, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (2109, 22, 1387, to_date('09-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1119, 88, 894, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1121, 88, 996, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1276, 22, 984, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (974, 88, 940, to_date('05-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (916, 33, 913, to_date('05-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1163, 88, 994, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1165, 88, 1049, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1167, 88, 891, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1256, 22, 889, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1258, 22, 1254, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1274, 22, 1220, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1406, 88, 1007, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1408, 88, 1323, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1410, 88, 1005, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1412, 88, 1288, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1414, 88, 1285, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1416, 88, 1248, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1418, 88, 1245, to_date('08-08-2011', 'dd-mm-yyyy'), '已调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1420, 88, 1123, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1422, 88, 1129, to_date('08-08-2011', 'dd-mm-yyyy'), '未调拨');
insert into L_ALLOCATIONORDER (ALLOCATIONORDERID, OPERATOR, FROMORDER, ALLOCATIONDATE, ALLOCATIONSTATE)
values (1822, 88, 1769, to_date('09-08-2011', 'dd-mm-yyyy'), '未调拨');
commit;
prompt 55 records loaded
prompt Loading L_CANCELORDER...
prompt Table is empty
prompt Loading L_CATEGORY...
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (776, null, '电器');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (777, null, '动物');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (778, null, '图书');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (779, null, '食品');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (780, null, '服装');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (781, 776, '电脑');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (782, 776, '电视');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (783, 776, '电饭锅');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (784, 777, '猫');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (785, 777, '狗');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (786, 778, '计算机类');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (787, 778, '财经类');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (788, 779, '饼干');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (789, 779, '雪糕');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (790, 779, '米饭');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (791, 780, '衬衫');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (792, 780, 'T恤');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (793, 780, '羽绒服');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (1077, null, '软件1');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (1461, null, '神马');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (1240, null, '硬件');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (1241, 1240, '传感器');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (2069, null, '家');
insert into L_CATEGORY (CATEGORYID, PARENTCATEGORY, CATEGORYNAME)
values (2070, 2069, '沙发');
commit;
prompt 24 records loaded
prompt Loading L_SUPPLIER...
insert into L_SUPPLIER (SUPPLIERID, SUPPLIERNAME, SUPPLIERADD, CONTACTPERSON, SUPPLIERTEL, BANK, BANKACCOUNT, FAX, SUPPLIERZIPCODE, LEGALPERSON, SUPPLIERREMARK)
values (794, '李亚方', '三舍c区239', '李亚方的太太', '15142065321', '建设银行', '602200070044456', '15212354', '110819', '李亚方', '诚信商人，5颗星');
insert into L_SUPPLIER (SUPPLIERID, SUPPLIERNAME, SUPPLIERADD, CONTACTPERSON, SUPPLIERTEL, BANK, BANKACCOUNT, FAX, SUPPLIERZIPCODE, LEGALPERSON, SUPPLIERREMARK)
values (795, '宋延杰', '九舍A区231', '小猫', '7474741', '工商银行', '68974563214521', '123521', '110819', '小美', '奸商，半颗星');
insert into L_SUPPLIER (SUPPLIERID, SUPPLIERNAME, SUPPLIERADD, CONTACTPERSON, SUPPLIERTEL, BANK, BANKACCOUNT, FAX, SUPPLIERZIPCODE, LEGALPERSON, SUPPLIERREMARK)
values (796, '龚玉斌', '重庆奉节', 'Andy', '123652162', '建设银行', '46579646548976319476514864', '5146513', '454561', '工哥', '特别商人');
insert into L_SUPPLIER (SUPPLIERID, SUPPLIERNAME, SUPPLIERADD, CONTACTPERSON, SUPPLIERTEL, BANK, BANKACCOUNT, FAX, SUPPLIERZIPCODE, LEGALPERSON, SUPPLIERREMARK)
values (797, '困龙', '山顶东', '石龙', '54654165', '天朝银行', '6464646464646874561', '54165142', '545615', '周时龙', '备用每个  的飞');
insert into L_SUPPLIER (SUPPLIERID, SUPPLIERNAME, SUPPLIERADD, CONTACTPERSON, SUPPLIERTEL, BANK, BANKACCOUNT, FAX, SUPPLIERZIPCODE, LEGALPERSON, SUPPLIERREMARK)
values (1238, '宋延杰', '吉林', '宋延杰', '1235688774', '工商银行', '5156161353162341651', '16541651', '5462355', '小宋', '无');
insert into L_SUPPLIER (SUPPLIERID, SUPPLIERNAME, SUPPLIERADD, CONTACTPERSON, SUPPLIERTEL, BANK, BANKACCOUNT, FAX, SUPPLIERZIPCODE, LEGALPERSON, SUPPLIERREMARK)
values (1098, '亚方', '三希', '李亚方的太太', '1587456215', '天朝银行', '601231546131564151345', '313413121', '513121', '李亚方', '优惠很大');
commit;
prompt 6 records loaded
prompt Loading L_PRODUCT...
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (861, 797, 786, '数据结构', '本', 39, .8, 20, 'A4', '老罗出版社', to_date('23-08-2017', 'dd-mm-yyyy'), 1, 1, '大二比用');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (829, 796, 792, 'Armani', '件', 360, .69, 250, '160*80cm', 'China', to_date('31-08-2016', 'dd-mm-yyyy'), 1, 1, '没钱赚啊');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (999, 795, 785, '牧羊犬', '只', 8000, .88, 1000, 'CD31', '小美宠物厂', to_date('02-09-2016', 'dd-mm-yyyy'), 1, 0, '可爱');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (944, 797, 788, '好吃点', '包', 2.5, .8, 2, '10cm*25cm', '莎莎饼干厂', to_date('05-08-2011', 'dd-mm-yyyy'), 0, 1, '很好吃');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (948, 795, 783, '美的电饭锅', '个', 800, .75, 500, 'B', '小美电器厂', to_date('30-09-2016', 'dd-mm-yyyy'), 1, 1, '让生活更美的');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (1001, 794, 793, '拉拉羽绒服', '件', 500, .88, 450, 'T2', '拉拉防寒服厂', to_date('21-08-2013', 'dd-mm-yyyy'), 1, 0, '保暖');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (1110, 794, 792, '心心相应', '件', 200, .75, 120, '30*90cm', '拉拉服装厂', to_date('09-08-2011', 'dd-mm-yyyy'), 1, 1, '质量好，透气好');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (818, 795, 781, '方正电脑', '台', 5400, .8, 3600, '60*80cm', '老罗电脑厂', to_date('31-08-2011', 'dd-mm-yyyy'), 1, 1, '质量有待商榷');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (820, 796, 789, '中街冰糕', '根', 2, .9, .5, '10*4cm', '拉拉雪糕', to_date('19-08-2011', 'dd-mm-yyyy'), 0, 0, '好吃');
insert into L_PRODUCT (PRODUCTID, SUPPLIER, CATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, COSTPRICE, PRODUCTTYPE, MANUFACTURER, GUARANTEEPERIOD, RETURNABLE, CHANGEABLE, PRODUCTREMARK)
values (1242, 795, 1241, '光传感器', '根', 120.3, 1, 100, 'A', '拉拉生产', to_date('10-08-2011', 'dd-mm-yyyy'), 0, 0, '无');
commit;
prompt 10 records loaded
prompt Loading L_CHANGEPRODUCTORDER...
prompt Table is empty
prompt Loading L_OUTSTORAGEORDER...
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1307, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2148, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2166, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (851, 805, to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (854, 805, to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (896, 805, to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (904, 805, to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1100, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1746, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2080, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2115, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2122, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2184, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1773, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1789, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1799, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1807, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1816, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1824, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (2059, 805, to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (871, 805, to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1136, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1189, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1195, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1207, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1262, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1372, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1424, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1451, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1462, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1546, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_OUTSTORAGEORDER (OUTSTORAGEORDERID, WAREHOUSE, OUTSTORAGEDATE, OUTSTORAGEREMARK)
values (1176, 805, to_date('08-08-2011', 'dd-mm-yyyy'), null);
commit;
prompt 32 records loaded
prompt Loading L_DISPATCHORDER...
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1308, 806, null, 44, 1307, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1309, 807, null, 44, 1307, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1316, 804, null, 44, 1307, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2149, 806, null, 66, 2148, 99, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2150, 804, null, 66, 2148, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2151, 807, null, 66, 2148, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2167, 806, null, 22, 2166, 99, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2171, 804, null, 22, 2166, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2172, 807, null, 22, 2166, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (897, 806, null, 88, 896, 373, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (898, 807, null, 88, 896, 55, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (901, 804, null, 88, 896, 373, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (905, 806, null, 88, 904, 373, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (906, 807, null, 88, 904, 55, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (907, 804, null, 88, 904, 373, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1101, 806, null, 44, 1100, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1102, 807, null, 44, 1100, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1106, 804, null, 44, 1100, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1747, 806, null, 44, 1746, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1748, 804, null, 44, 1746, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1749, 807, null, 44, 1746, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2081, 806, null, 44, 2080, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2083, 807, null, 44, 2080, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2084, 804, null, 44, 2080, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2116, 806, null, 44, 2115, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2118, 807, null, 44, 2115, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2119, 804, null, 44, 2115, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2123, 807, null, 44, 2122, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2124, 804, null, 44, 2122, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2125, 806, null, 44, 2122, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2185, 804, null, 44, 2184, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2186, 807, null, 44, 2184, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2188, 806, null, 44, 2184, 99, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1774, 806, null, 66, 1773, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1775, 804, null, 66, 1773, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1776, 807, null, 66, 1773, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1790, 806, null, 66, 1789, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1791, 807, null, 66, 1789, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1795, 804, null, 66, 1789, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1800, 807, null, 66, 1799, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1803, 804, null, 66, 1799, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1804, 806, null, 66, 1799, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1808, 806, null, 66, 1807, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1809, 807, null, 66, 1807, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1810, 804, null, 66, 1807, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1817, 806, null, 66, 1816, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1819, 804, null, 66, 1816, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1820, 807, null, 66, 1816, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1825, 804, null, 66, 1824, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1826, 807, null, 66, 1824, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1827, 806, null, 66, 1824, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2060, 806, null, 66, 2059, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2064, 804, null, 66, 2059, 373, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (2065, 807, null, 66, 2059, 55, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (872, 806, null, 88, 871, 373, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (873, 807, null, 88, 871, 55, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (877, 804, null, 88, 871, 373, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1137, 806, null, 44, 1136, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1140, 804, null, 44, 1136, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1141, 807, null, 44, 1136, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1190, 807, null, 44, 1189, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1192, 804, null, 44, 1189, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1193, 806, null, 44, 1189, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1196, 806, null, 44, 1195, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1197, 807, null, 44, 1195, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1199, 804, null, 44, 1195, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1208, 806, null, 44, 1207, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1209, 804, null, 44, 1207, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1210, 807, null, 44, 1207, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1263, 806, null, 44, 1262, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1264, 804, null, 44, 1262, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1266, 807, null, 44, 1262, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1373, 804, null, 88, 1372, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1376, 806, null, 88, 1372, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1377, 807, null, 88, 1372, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1425, 804, null, 88, 1424, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1426, 807, null, 88, 1424, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1433, 806, null, 88, 1424, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1452, 806, null, 88, 1451, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1453, 807, null, 88, 1451, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1457, 804, null, 88, 1451, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1463, 804, null, 88, 1462, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1464, 806, null, 88, 1462, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1465, 807, null, 88, 1462, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1547, 806, null, 44, 1546, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1550, 807, null, 44, 1546, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1551, 804, null, 44, 1546, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1177, 804, null, 44, 1176, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1178, 807, null, 44, 1176, 55, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_DISPATCHORDER (DISPATCHORDERID, WAREHOUSE, SIGNEDMAN, OPERATOR, OUTSTORAGEORDER, DISPATCHMAN, DIPATCHORDERREMARK, DIPATCHDATE)
values (1179, 806, null, 44, 1176, 373, null, to_date('08-08-2011', 'dd-mm-yyyy'));
commit;
prompt 90 records loaded
prompt Loading L_DISPATCHORDERITEM...
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1310, 1309, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1311, 1309, 818, 10001);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1312, 1309, 1001, 9999);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1313, 1309, 1110, 99999);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1314, 1309, 861, 100019);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1315, 1309, 944, 9999);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2152, 2151, 944, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2153, 2151, 999, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2154, 2151, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2155, 2151, 861, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2168, 2167, 1110, 11111);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2169, 2167, 829, 111111);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2170, 2167, 861, 11111);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (899, 898, 829, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (900, 898, 820, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (908, 907, 818, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (909, 907, 818, 10);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (910, 907, 829, 10);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1103, 1102, 820, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1104, 1102, 818, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1105, 1102, 829, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1750, 1749, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2082, 2081, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2117, 2116, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2126, 2125, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2127, 2125, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2128, 2125, 1242, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2129, 2125, 861, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2187, 2186, 1242, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1777, 1776, 944, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1778, 1776, 818, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1779, 1776, 829, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1780, 1776, 861, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1781, 1776, 948, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1782, 1776, 820, 4);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1792, 1791, 1001, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1793, 1791, 820, 4);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1794, 1791, 818, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1801, 1800, 999, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1802, 1800, 948, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1811, 1810, 944, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1812, 1810, 1001, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1818, 1817, 829, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1828, 1827, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1829, 1827, 944, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2061, 2060, 829, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2062, 2060, 1242, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (2063, 2060, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (874, 873, 818, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (875, 873, 820, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (876, 873, 829, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (878, 877, 818, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (879, 877, 829, 10);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (880, 877, 818, 10);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1138, 1137, 829, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1139, 1137, 818, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1191, 1190, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1198, 1197, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1211, 1210, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1265, 1264, 861, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1267, 1266, 818, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1268, 1266, 820, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1269, 1266, 829, 30);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1374, 1373, 829, 5);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1375, 1373, 861, 6);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1427, 1426, 818, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1428, 1426, 820, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1429, 1426, 999, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1430, 1426, 1242, 22);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1431, 1426, 1001, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1432, 1426, 829, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1454, 1453, 861, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1455, 1453, 999, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1456, 1453, 829, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1466, 1465, 1242, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1548, 1547, 818, 2);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1549, 1547, 820, 3);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1180, 1179, 829, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1181, 1179, 820, 1);
insert into L_DISPATCHORDERITEM (DISPATCHORDERITEMID, DISPATCHORDER, PRODUCT, PRODUCTQUANTITY)
values (1182, 1179, 818, 1);
commit;
prompt 80 records loaded
prompt Loading L_FEEDBACKORDER...
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (1861, 1120, '完成', 4, 'ok');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (1862, 1407, '完成', 5, 'ok');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (1293, 1118, '完成', 3, 'fgd');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (1302, 1166, '完成', 5, 'ok');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (1304, 1261, '完成', 4, 'ok');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (1306, 850, '完成', 3, '1');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (2091, 1469, '完成', 4, 'ok');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (2111, 1259, '完成', 3, 'ok');
insert into L_FEEDBACKORDER (FEEDBACKORDERID, TASKORDER, TASKSTATE, SATISFACTION, FEEDBACKREMARK)
values (2113, 1409, '完成', 4, 'ok');
commit;
prompt 9 records loaded
prompt Loading L_TASKORDER...
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (868, 857, 82, 88, '已分配', '送货收款', to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (870, 863, 85, 88, '已领货', '送货收款', to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1118, 962, 86, 88, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1772, 1766, 85, 88, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1833, 1367, 83, 88, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1838, 1834, 888, 88, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (2075, 2038, 84, 22, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1162, 885, 83, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (2078, 2072, 87, 22, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (2100, 1380, 84, 22, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (850, 831, 85, 88, '已完成', '送货收款', to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (954, 918, 87, 88, '已调度', '送货收款', to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1261, 863, 84, 22, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1469, 1364, 82, 88, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1471, 1347, 89, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1473, 1127, 89, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1475, 1029, 89, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1477, 1015, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1479, 1213, 89, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1481, 1035, 86, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1483, 956, 82, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1485, 1393, 82, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1487, 1359, 82, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1489, 1356, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1491, 1351, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1493, 1291, 86, 88, '可分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1495, 1033, 86, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1497, 979, 89, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1499, 1330, 86, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1501, 1325, 86, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1504, 1401, 82, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1755, 1155, 85, 88, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (2033, 2030, 84, 22, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (2110, 1387, 888, 22, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1120, 894, 85, 88, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1122, 996, 87, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1277, 984, 888, 22, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (975, 940, 87, 88, '已调度', '送货收款', to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (917, 913, 85, 33, '已领货', '送货收款', to_date('05-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1164, 994, 84, 88, '已领货', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1166, 1049, 86, 88, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1168, 891, 83, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1257, 889, 89, 22, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1259, 1254, 81, 22, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1275, 1220, 86, 22, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1407, 1007, 85, 88, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1409, 1323, 85, 88, '已完成', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1411, 1005, 85, 88, '已领货', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1413, 1288, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1415, 1285, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1417, 1248, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1419, 1245, 85, 88, '已分配', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1421, 1123, 84, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1423, 1129, 84, 88, '已调度', '送货收款', to_date('08-08-2011', 'dd-mm-yyyy'), null);
insert into L_TASKORDER (TASKORDERID, FORORDER, DELIVERMAN, OPERATOR, TASKORDERSTATE, TASKORDERTYPE, OPERATEDATE, FEEDBACKORDER)
values (1823, 1769, 888, 88, '已调度', '送货收款', to_date('09-08-2011', 'dd-mm-yyyy'), null);
commit;
prompt 55 records loaded
prompt Loading L_FUNCTION...
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (111, 1, 101, '客户服务中心', '0', 'editicon', 1);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (11, 1, 111, '客户管理', '1', 'usericon', 1);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (12, 1, 111, '订单管理', '0', 'editicon', 1);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (222, 2, 101, '调度中心', '0', 'editicon', 2);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (21, 2, 222, '调度管理', '1', 'todaypriceicon', 2);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (24, 2, 222, '任务单查询', '1', 'todaypriceicon', 2);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (333, 3, 101, '分站管理', '0', 'editicon', 3);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (31, 3, 333, '任务单查询', '1', 'sysmanagemenu', 3);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (32, 3, 333, '任务分配', '1', 'sysmanagemenu', 3);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (33, 3, 333, '补打商品签收单', '1', 'sysmanagemenu', 3);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (34, 3, 333, '回执录入', '1', 'sysmanagemenu', 3);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (35, 3, 333, '缴纳查询', '1', 'sysmanagemenu', 3);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (444, 4, 101, '中心库房管理', '0', 'editicon', 4);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (41, 4, 444, '中心库房购货入库', '1', 'openroomicon', 4);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (42, 4, 444, '中心库房调拨出库', '1', 'openroomicon', 4);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (555, 5, 101, '分站库房管理', '0', 'editicon', 5);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (51, 5, 555, '分站库房调拨入库', '1', 'roomtypeicon', 5);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (52, 5, 555, '分站库房领货', '1', 'roomtypeicon', 5);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (666, 6, 101, '配送中心管理', '0', 'editicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (61, 6, 666, '商品管理', '0', 'editicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (611, 6, 61, '商品一级分类', '1', 'hotelmanageicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (612, 6, 61, '商品二级分类', '1', 'hotelmanageicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (613, 6, 61, '商品管理', '1', 'hotelmanageicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (62, 6, 666, '库房管理', '0', 'editicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (621, 6, 62, '库房设置', '1', 'openroomiconinfo', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (622, 6, 62, '库房储备设置', '1', 'openroomiconinfo', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (623, 6, 62, '库存量查询', '1', 'openroomiconinfo', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (624, 6, 62, '出入单查询', '1', 'openroomiconinfo', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (63, 6, 666, '供应商管理', '1', 'setuseridicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (64, 6, 666, '进货管理', '1', 'guesticon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (663, 6, 66, '客户满意度分析', '1', 'roolrecordicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (661, 6, 66, '订购排行榜分析', '1', 'roolrecordicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (125, 1, 12, '订单信息查询', '1', 'totalicon', 1);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (66, 6, 666, '业务统计查询', '0', 'editicon', 6);
insert into L_FUNCTION (FUNCTIONID, ROLEID, PARENT, FUNCTIONNAME, ISLEAF, ICONCLS, ROLE)
values (101, 0, 125, 'boss', '1', 'homemanage', 0);
commit;
prompt 35 records loaded
prompt Loading L_ORDERITEM...
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (922, 829, 921, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (923, 820, 921, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (924, 818, 921, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (925, 818, 921, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (927, 820, 926, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (928, 829, 926, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (929, 818, 926, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (947, 820, 946, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (966, 820, 965, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (967, 861, 965, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (972, 820, 971, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (973, 948, 971, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (995, 861, 994, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 20);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1050, 818, 1049, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1125, 999, 1123, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1126, 948, 1123, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1247, 1242, 1245, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1251, 999, 1248, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1252, 829, 1248, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1253, 861, 1248, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1286, 1242, 1285, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1290, 1242, 1288, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 10);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1326, 1242, 1325, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 10);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1331, 1242, 1330, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1768, 820, 1766, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1770, 820, 1769, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1847, 1242, 1844, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1848, 861, 1844, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1849, 820, 1844, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1958, 1001, 1867, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2140, 948, 2138, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2142, 820, 2141, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (864, 829, 863, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 30);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (865, 820, 863, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 30);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (866, 818, 863, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 30);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (886, 829, 885, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 5);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (887, 861, 885, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 6);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (892, 818, 891, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (893, 820, 891, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (980, 818, 979, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (981, 944, 979, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (985, 818, 984, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (986, 820, 984, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (991, 818, 990, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (992, 948, 990, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1006, 820, 1005, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1034, 820, 1033, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1088, 861, 1086, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1089, 820, 1086, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1090, 829, 1086, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1095, 944, 1091, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1096, 948, 1091, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1097, 999, 1091, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1114, 818, 1111, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1115, 1110, 1111, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1116, 948, 1111, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1255, 861, 1254, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1292, 1242, 1291, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1324, 1242, 1323, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 10);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1329, 1242, 1327, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 20);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1352, 999, 1351, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1353, 944, 1351, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1354, 818, 1351, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1355, 861, 1351, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1357, 948, 1356, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1358, 999, 1356, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1360, 948, 1359, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1361, 1242, 1359, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1362, 861, 1359, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1363, 1110, 1359, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1369, 820, 1367, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1370, 948, 1367, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1371, 1242, 1367, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1382, 1110, 1380, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1383, 948, 1380, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1384, 1242, 1380, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1385, 820, 1380, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1386, 999, 1380, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1394, 818, 1393, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1395, 944, 1393, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1398, 820, 1396, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1399, 818, 1396, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1400, 1110, 1396, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1612, 1242, 1554, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1759, 948, 1757, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1835, 820, 1834, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1860, 820, 1859, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1977, 1001, 1964, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (997, 818, 996, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (832, 829, 831, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (833, 820, 831, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 30);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (957, 820, 956, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (958, 829, 956, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (959, 944, 956, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 4);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (998, 820, 996, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (890, 861, 889, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (895, 818, 894, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (941, 820, 940, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (942, 818, 940, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
commit;
prompt 100 records committed...
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (943, 829, 940, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (963, 820, 962, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1037, 818, 1035, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1038, 820, 1035, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 4);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1039, 1001, 1035, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1217, 829, 1213, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 111111);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1218, 1110, 1213, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 11111);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1219, 861, 1213, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 11111);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1226, 1110, 1220, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 99999);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1227, 861, 1220, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 99999);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1228, 944, 1220, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 9999);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1229, 1001, 1220, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 9999);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1230, 818, 1220, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 9999);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1233, 1110, 1231, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 20);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1544, 1242, 1505, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1545, 1242, 1505, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1728, 1242, 1613, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1731, 1242, 1729, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1737, 861, 1733, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1738, 818, 1733, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1742, 861, 1740, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1745, 999, 1743, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1992, 1001, 1979, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2019, 1001, 2017, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2037, 1001, 2035, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2073, 820, 2072, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2097, 861, 2094, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2098, 1242, 2094, '硬件', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2144, 820, 2143, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (858, 829, 857, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 10);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (859, 818, 857, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 10);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (860, 818, 857, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 20);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (914, 818, 913, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (915, 820, 913, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (919, 829, 918, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (920, 818, 918, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1010, 818, 1007, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1011, 1001, 1007, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1012, 999, 1007, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1013, 829, 1007, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1014, 820, 1007, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1019, 820, 1015, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1020, 829, 1015, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1021, 818, 1015, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1022, 948, 1015, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1023, 820, 1015, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1024, 944, 1015, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1025, 861, 1015, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1031, 818, 1029, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1032, 944, 1029, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1128, 829, 1127, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1132, 944, 1129, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 3);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1133, 829, 1129, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1134, 999, 1129, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1157, 944, 1155, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1158, 829, 1155, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1348, 829, 1347, '服装', 'T恤', 'Armani', '件', 360, .69, '没钱赚啊', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1349, 1242, 1347, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1350, 818, 1347, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1365, 944, 1364, '食品', '饼干', '好吃点', '包', 2.5, .8, '很好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1366, 1001, 1364, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1389, 861, 1387, '图书', '计算机类', '数据结构', '本', 39, .8, '大二比用', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1390, 1242, 1387, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1391, 820, 1387, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1392, 818, 1387, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1402, 1110, 1401, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1403, 1242, 1401, '软件1', '传感器', '光传感器', '根', 120.3, 1, '无', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1404, 818, 1401, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (1405, 948, 1401, '电器', '电饭锅', '美的电饭锅', '个', 800, .75, '让生活更美的', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2016, 1001, 2014, '服装', '羽绒服', '拉拉羽绒服', '件', 500, .88, '保暖', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2028, 999, 2025, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2029, 818, 2025, '电器', '电脑', '方正电脑', '台', 5400, .8, '质量有待商榷', 1);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2031, 820, 2030, '食品', '雪糕', '中街冰糕', '根', 2, .9, '好吃', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2040, 999, 2038, '动物', '狗', '牧羊犬', '只', 8000, .88, '可爱', 2);
insert into L_ORDERITEM (ORDERITEMID, PRODUCT, TOORDER, FIRSTCATERGORY, SECONDCATEGORY, PRODUCTNAME, UNIT, ORIGINALPRICE, DISCOUNT, PRODUCTREMARK, ORDERITEMAMOUNT)
values (2043, 1110, 2041, '服装', 'T恤', '心心相应', '件', 200, .75, '质量好，透气好', 1);
commit;
prompt 174 records loaded
prompt Loading L_OUTSTORAGEORDERITEM...
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1317, 1001, 1307, 9999);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1318, 818, 1307, 10001);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1319, 861, 1307, 100019);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1320, 944, 1307, 9999);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1321, 820, 1307, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1322, 1110, 1307, 99999);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2156, 999, 2148, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2157, 818, 2148, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2158, 861, 2148, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2159, 944, 2148, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2173, 1110, 2166, 11111);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2174, 829, 2166, 111111);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2175, 861, 2166, 11111);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (852, 820, 851, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (853, 829, 851, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (855, 820, 854, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (856, 829, 854, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (902, 829, 896, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (903, 820, 896, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (911, 829, 904, 10);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (912, 818, 904, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1107, 820, 1100, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1108, 818, 1100, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1109, 829, 1100, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1751, 820, 1746, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2085, 820, 2080, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2120, 820, 2115, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2130, 861, 2122, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2131, 820, 2122, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2132, 1242, 2122, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2133, 818, 2122, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2189, 1242, 2184, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1783, 818, 1773, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1784, 820, 1773, 4);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1785, 944, 1773, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1786, 829, 1773, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1787, 948, 1773, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1788, 861, 1773, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1796, 1001, 1789, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1797, 820, 1789, 4);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1798, 818, 1789, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1805, 999, 1799, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1806, 948, 1799, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1813, 1001, 1807, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1814, 944, 1807, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1821, 829, 1816, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1830, 944, 1824, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1831, 818, 1824, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2066, 818, 2059, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2067, 829, 2059, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (2068, 1242, 2059, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (881, 818, 871, 60);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (882, 820, 871, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (883, 829, 871, 40);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1142, 829, 1136, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1143, 818, 1136, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1194, 820, 1189, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1200, 818, 1195, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1212, 818, 1207, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1270, 829, 1262, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1271, 820, 1262, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1272, 818, 1262, 30);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1273, 861, 1262, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1378, 829, 1372, 5);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1379, 861, 1372, 6);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1434, 1242, 1424, 22);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1435, 829, 1424, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1436, 999, 1424, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1437, 1001, 1424, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1438, 818, 1424, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1439, 820, 1424, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1458, 999, 1451, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1459, 829, 1451, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1460, 861, 1451, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1467, 1242, 1462, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1552, 818, 1546, 2);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1553, 820, 1546, 3);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1183, 818, 1176, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1184, 829, 1176, 1);
insert into L_OUTSTORAGEORDERITEM (OUTSTORAGEORDERITEMID, PRODUCT, OUTSTORAGEORDER, PRODUCTQUANTITY)
values (1185, 820, 1176, 1);
commit;
prompt 80 records loaded
prompt Loading L_PURCHASEINSTORAGEORDER...
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1052, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '很好', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1055, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '很好', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1297, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '和那好', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2052, '未到货', to_date('09-08-2011', 'dd-mm-yyyy'), null, null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2055, '未到货', to_date('09-08-2011', 'dd-mm-yyyy'), null, null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1235, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '和那好哦', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1761, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), 'henhao', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1764, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), 'henahoa', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1856, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), '成功', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2046, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), '成功', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2049, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), '成功', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2102, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), '成功', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2107, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), '很好', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1070, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '和那好哦', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (1074, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '很好', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (931, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '和那好哦', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (934, '完全到货', to_date('08-08-2011', 'dd-mm-yyyy'), '很好', null);
insert into L_PURCHASEINSTORAGEORDER (PURCHASEINSTORAGEORDERID, PRODUCTPURCHASESTATE, PURCHASEDATE, PUCHASEREMARK, WAREHOUSE)
values (2146, '完全到货', to_date('09-08-2011', 'dd-mm-yyyy'), '成功', null);
commit;
prompt 18 records loaded
prompt Loading L_PURCHASEPRODUCTORDER...
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1051, 1001, 3, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1054, 999, 1, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1294, 999, 5, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1295, 829, 131022, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1296, 1242, 5, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2051, 818, 9996, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2054, 818, 9974, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1234, 944, 10006, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1760, 820, 20004, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1763, 820, 1, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1854, 818, 29961, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1855, 944, 10001, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2045, 999, 5, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2048, 861, 130825, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2101, 1242, 20543, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2106, 1242, 19999, null, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1069, 944, 10, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1072, 861, 142, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (1073, 948, 3, null, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (930, 861, 7, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (933, 818, 1, null, to_date('05-08-2011', 'dd-mm-yyyy'));
insert into L_PURCHASEPRODUCTORDER (PURCHASEPRODUCTORDERID, PRODUCT, PRODUCTQUANTITY, PURCHASEREMARK, PURCHASEDATE)
values (2145, 820, 4, null, to_date('09-08-2011', 'dd-mm-yyyy'));
commit;
prompt 22 records loaded
prompt Loading L_PURCHASEPINSTORAGEORDERITEM...
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1053, 1001, 1051, 1052, 3);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1056, 999, 1054, 1055, 1);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1298, 829, 1295, 1297, 131022);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1299, 1242, 1296, 1297, 5);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1300, 999, 1294, 1297, 5);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2053, 818, 2051, 2052, 9996);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2056, 818, 2054, 2055, 9974);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1236, 944, 1234, 1235, 10006);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1762, 820, 1760, 1761, 20004);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1765, 820, 1763, 1764, 1);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1857, 944, 1855, 1856, 10001);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1858, 818, 1854, 1856, 29961);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2047, 999, 2045, 2046, 5);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2050, 861, 2048, 2049, 130825);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2103, 1242, 2101, 2102, 20543);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2108, 1242, 2106, 2107, 19999);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1071, 944, 1069, 1070, 10);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1075, 861, 1072, 1074, 142);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (1076, 948, 1073, 1074, 3);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (932, 861, 930, 931, 7);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (935, 818, 933, 934, 1);
insert into L_PURCHASEPINSTORAGEORDERITEM (PURCHASEINSTORAGEORDERITEMID, PRODUCT, PURCHASEPRODUCTORDER, PURCHASEINSTORAGEORDER, REALPURCHASEQUANTITY)
values (2147, 820, 2145, 2146, 4);
commit;
prompt 22 records loaded
prompt Loading L_RETURNPRODUCTORDER...
prompt Table is empty
prompt Loading L_SHORTAGEORDER...
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (964, 861, 965, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (970, 948, 971, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (993, 861, 994, 20, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1124, 999, 1123, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1246, 1242, 1245, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1249, 999, 1248, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1250, 829, 1248, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1289, 1242, 1288, 4, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1767, 820, 1766, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1845, 861, 1844, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1846, 1242, 1844, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1868, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1869, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1870, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1871, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1872, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1873, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1874, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1875, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1876, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1877, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1878, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1879, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1880, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1881, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1882, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1883, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1884, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1885, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1886, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1887, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1888, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1889, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1890, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1891, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1892, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1893, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1894, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1895, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1896, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1897, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1898, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1899, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1900, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1901, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1902, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1903, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1904, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1905, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1906, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1907, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1908, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1909, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1910, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1911, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1912, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1913, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1914, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1915, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1916, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1917, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1918, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1919, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1920, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1921, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1922, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1923, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1924, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1925, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1926, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1927, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1928, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1929, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1930, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1931, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1932, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1933, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1934, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1935, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1936, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1937, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1938, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1939, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1940, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1941, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1942, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1943, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1944, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1945, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1946, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1947, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1948, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1949, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1950, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1951, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1952, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1953, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1954, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1955, 1001, 1867, 2, '缺货');
commit;
prompt 100 records committed...
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1956, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1957, 1001, 1867, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2139, 948, 2138, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (884, 861, 885, 6, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (978, 944, 979, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (989, 948, 990, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1087, 861, 1086, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1092, 948, 1091, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1093, 944, 1091, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1094, 999, 1091, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1112, 948, 1111, 3, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1113, 1110, 1111, 2, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1328, 1242, 1327, 9, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1368, 820, 1367, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1381, 820, 1380, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1397, 820, 1396, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1555, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1556, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1557, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1558, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1559, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1560, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1561, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1562, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1563, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1564, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1565, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1566, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1567, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1568, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1569, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1570, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1571, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1572, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1573, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1574, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1575, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1576, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1577, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1578, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1579, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1580, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1581, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1582, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1583, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1584, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1585, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1586, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1587, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1588, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1589, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1590, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1591, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1592, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1593, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1594, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1595, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1596, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1597, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1598, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1599, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1600, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1601, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1602, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1603, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1604, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1605, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1606, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1607, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1608, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1609, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1610, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1611, 1242, 1554, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1758, 948, 1757, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1965, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1966, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1967, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1968, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1969, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1970, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1971, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1972, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1973, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1974, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1975, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1976, 1001, 1964, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (955, 944, 956, 4, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (888, 861, 889, 100, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1036, 1001, 1035, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1214, 861, 1213, 10969, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1215, 1110, 1213, 11111, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1216, 829, 1213, 111021, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1221, 818, 1220, 9950, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1222, 1001, 1220, 9996, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1223, 861, 1220, 99857, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1224, 944, 1220, 9999, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1225, 1110, 1220, 99999, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1232, 1110, 1231, 20, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1506, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1507, 1242, 1505, 2, '已解决');
commit;
prompt 200 records committed...
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1508, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1509, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1510, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1511, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1512, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1513, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1514, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1515, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1516, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1517, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1518, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1519, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1520, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1521, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1522, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1523, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1524, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1525, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1526, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1527, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1528, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1529, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1530, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1531, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1532, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1533, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1534, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1535, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1536, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1537, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1538, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1539, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1540, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1541, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1542, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1543, 1242, 1505, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1614, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1615, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1616, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1617, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1618, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1619, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1620, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1621, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1622, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1623, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1624, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1625, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1626, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1627, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1628, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1629, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1630, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1631, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1632, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1633, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1634, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1635, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1636, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1637, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1638, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1639, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1640, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1641, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1642, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1643, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1644, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1645, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1646, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1647, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1648, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1649, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1650, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1651, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1652, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1653, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1654, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1655, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1656, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1657, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1658, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1659, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1660, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1661, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1662, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1663, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1664, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1665, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1666, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1667, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1668, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1669, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1670, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1671, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1672, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1673, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1674, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1675, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1676, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1677, 1242, 1613, 3, '已解决');
commit;
prompt 300 records committed...
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1678, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1679, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1680, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1681, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1682, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1683, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1684, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1685, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1686, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1687, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1688, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1689, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1690, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1691, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1692, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1693, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1694, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1695, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1696, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1697, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1698, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1699, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1700, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1701, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1702, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1703, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1704, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1705, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1706, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1707, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1708, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1709, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1710, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1711, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1712, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1713, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1714, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1715, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1716, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1717, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1718, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1719, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1720, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1721, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1722, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1723, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1724, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1725, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1726, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1727, 1242, 1613, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1730, 1242, 1729, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1734, 818, 1733, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1735, 818, 1733, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1736, 861, 1733, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1741, 861, 1740, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1744, 999, 1743, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1980, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1981, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1982, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1983, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1984, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1985, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1986, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1987, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1988, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1989, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1990, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1991, 1001, 1979, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2018, 1001, 2017, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2036, 1001, 2035, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2095, 1242, 2094, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2096, 861, 2094, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1008, 999, 1007, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1009, 1001, 1007, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1016, 861, 1015, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1017, 944, 1015, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1018, 948, 1015, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1030, 944, 1029, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1130, 999, 1129, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1131, 944, 1129, 3, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1156, 944, 1155, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (1388, 820, 1387, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2015, 1001, 2014, 1, '缺货');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2026, 818, 2025, 1, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2027, 999, 2025, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2039, 999, 2038, 2, '已解决');
insert into L_SHORTAGEORDER (SHORTAGEORDERID, PRODUCT, FROMORDER, SHORTAGEQUANTITY, SHORTAGESTATE)
values (2042, 1110, 2041, 1, '缺货');
commit;
prompt 386 records loaded
prompt Loading L_SIGNEDORDER...
prompt Table is empty
prompt Loading L_STORAGEINFO...
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (862, 861, 805, 20, 600, 2);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1171, 829, 805, 20000, 40000, 3);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1173, 818, 805, 20000, 40000, 0);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1175, 820, 805, 20000, 40000, 4);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1443, 1001, 807, 20000, 40000, 10001);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1445, 1110, 807, 20000, 40000, 99999);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1447, 861, 807, 20000, 40000, 100021);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1449, 944, 807, 20000, 40000, 10000);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (830, 829, 805, 1, 2300, 5);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1000, 999, 805, 1, 1000, 3);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (2020, 1001, 804, 20000, 40000, 1);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (2023, 944, 804, 20000, 40000, 2);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (2162, 999, 807, 20000, 40000, 9);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (2176, 948, 807, 20000, 40000, 6);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (945, 944, 805, 1, 20, 4);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (949, 948, 805, 1, 1000, 1);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1002, 1001, 805, 0, 1000, 0);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1111, 1110, 805, 0, 20000, 2);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1959, 1242, 807, 20000, 40000, 3);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1279, 818, 807, 20000, 40000, 10007);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1222, 1242, 805, 0, 5000, 8);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1278, 829, 807, 20000, 40000, 4);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1280, 820, 807, 20000, 40000, 101);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1338, 861, 804, 20000, 40000, 22);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1341, 818, 804, 20000, 40000, 30);
insert into L_STORAGEINFO (STORAGEINFOID, PRODUCT, WAREHOUSE, WARNINGQUANTITY, MAXQUANTITY, REMAINQUANTITY)
values (1343, 829, 804, 20000, 40000, 15);
commit;
prompt 26 records loaded
prompt Loading L_SUBSATIONINSTORAGEORDER...
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1201, 1190, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1169, 873, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1186, 898, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1203, 1102, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1344, 907, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1440, 1309, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2009, 1373, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2021, 1810, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2086, 1749, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2160, 2151, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2177, 1800, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2180, 1453, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (2190, 2186, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1332, 1197, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1863, 1791, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1960, 1465, to_date('09-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1334, 1210, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1281, 1266, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1336, 1264, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
insert into L_SUBSATIONINSTORAGEORDER (SUBSATIONINSTORAGEORDERID, DISPATCHORDER, INSTORAGEDATE, INSTORAGEREMARK)
values (1339, 877, to_date('08-08-2011', 'dd-mm-yyyy'), '已入库');
commit;
prompt 20 records loaded
prompt Loading L_SUBSATIONINSTORAGEORDERITEM...
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1174, 820, 1169, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1187, 820, 1186, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1188, 829, 1186, 2);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1170, 829, 1169, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1172, 818, 1169, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1202, 820, 1201, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1204, 820, 1203, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1205, 818, 1203, 34);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1206, 829, 1203, 35);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1345, 818, 1344, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1346, 829, 1344, 10);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1441, 820, 1440, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1442, 818, 1440, 10001);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1444, 1001, 1440, 9999);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1446, 1110, 1440, 99999);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1448, 861, 1440, 100019);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1450, 944, 1440, 9999);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2010, 861, 2009, 6);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2011, 829, 2009, 5);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2022, 1001, 2021, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2024, 944, 2021, 2);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2087, 820, 2086, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2161, 818, 2160, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2163, 999, 2160, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2164, 944, 2160, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2165, 861, 2160, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2178, 948, 2177, 6);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2179, 999, 2177, 6);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2181, 829, 2180, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2182, 861, 2180, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2183, 999, 2180, 2);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (2191, 1242, 2190, 2);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1333, 818, 1332, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1864, 818, 1863, 3);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1865, 820, 1863, 4);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1866, 1001, 1863, 2);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1961, 1242, 1960, 1);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1335, 818, 1334, 34);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1282, 820, 1281, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1283, 818, 1281, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1284, 829, 1281, 30);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1337, 861, 1336, 50);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1340, 818, 1339, 10);
insert into L_SUBSATIONINSTORAGEORDERITEM (SUBSATIONINSTORAGEORDERITEMID, PRODUCT, SUBSATIONINSTORAGEORDER, PRODUCTQUANTITY)
values (1342, 829, 1339, 10);
commit;
prompt 44 records loaded
prompt Loading L_SUBSTATIONEMPLOYEE...
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1001, 31);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1002, 32);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1000, 33);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1001, 55);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1000, 81);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1000, 82);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1000, 83);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1001, 84);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1001, 85);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1001, 86);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1002, 87);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1002, 89);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1002, 99);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1000, 373);
insert into L_SUBSTATIONEMPLOYEE (SUBSTATION, DELIVERMAN)
values (1002, 888);
commit;
prompt 15 records loaded
prompt Loading L_TAKEPRODUCTORDER...
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1301, '配送员H', 1166, to_date('30-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1303, '配送员H', 1261, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1305, '配送员H', 850, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1753, '配送员F', 1164, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1756, '配送员F', 917, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1978, '配送员E', 1411, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (2089, '配送员E', 1469, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1144, '周诗龙', 850, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1502, '配送员B', 1120, to_date('08-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1752, '配送员F', 1259, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1815, '配送员F', 870, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1842, '配送员E', 1409, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1853, '配送员E', 1407, to_date('09-08-2011', 'dd-mm-yyyy'));
insert into L_TAKEPRODUCTORDER (TAKEPRODUCTORDERID, TAKER, TASKORDER, TAKEDATE)
values (1287, '配送员H', 1118, to_date('08-08-2011', 'dd-mm-yyyy'));
commit;
prompt 14 records loaded
prompt Enabling foreign key constraints for L_USER...
alter table L_USER enable constraint FK8712EBDE1C9BC35C;
prompt Enabling foreign key constraints for L_WAREHOUSE...
alter table L_WAREHOUSE enable constraint FKA2D5670CF1171C5;
prompt Enabling foreign key constraints for L_SUBSTATION...
alter table L_SUBSTATION enable constraint FK79E914C7DEF5B916;
prompt Enabling foreign key constraints for L_ORDER...
alter table L_ORDER enable constraint FK5AF5897B806D0A2C;
alter table L_ORDER enable constraint FK5AF5897BD15B433D;
alter table L_ORDER enable constraint FK5AF5897BD2C0921E;
alter table L_ORDER enable constraint FK5AF5897BFE91D6DF;
prompt Enabling foreign key constraints for L_ALLOCATIONORDER...
alter table L_ALLOCATIONORDER enable constraint FKD5A59C5B75E8BCC2;
alter table L_ALLOCATIONORDER enable constraint FKD5A59C5BFE91D6DF;
prompt Enabling foreign key constraints for L_CANCELORDER...
alter table L_CANCELORDER enable constraint FKCD59358175E8BCC2;
prompt Enabling foreign key constraints for L_CATEGORY...
alter table L_CATEGORY enable constraint FKBCDB7391C0C44316;
prompt Enabling foreign key constraints for L_PRODUCT...
alter table L_PRODUCT enable constraint FKA939F3DC3E2F846C;
alter table L_PRODUCT enable constraint FKA939F3DC71E1FE08;
prompt Enabling foreign key constraints for L_CHANGEPRODUCTORDER...
alter table L_CHANGEPRODUCTORDER enable constraint FK946A4A42694E816E;
alter table L_CHANGEPRODUCTORDER enable constraint FK946A4A4275E8BCC2;
prompt Enabling foreign key constraints for L_OUTSTORAGEORDER...
alter table L_OUTSTORAGEORDER enable constraint FK64649DEEDEF5B916;
prompt Enabling foreign key constraints for L_DISPATCHORDER...
alter table L_DISPATCHORDER enable constraint FKBAE174415BF104DB;
alter table L_DISPATCHORDER enable constraint FKBAE174415C963EF9;
alter table L_DISPATCHORDER enable constraint FKBAE174415F5E4392;
alter table L_DISPATCHORDER enable constraint FKBAE17441DEF5B916;
alter table L_DISPATCHORDER enable constraint FKBAE17441FE91D6DF;
prompt Enabling foreign key constraints for L_DISPATCHORDERITEM...
alter table L_DISPATCHORDERITEM enable constraint FKC8BDDED4254C0998;
alter table L_DISPATCHORDERITEM enable constraint FKC8BDDED4694E816E;
prompt Enabling foreign key constraints for L_FEEDBACKORDER...
alter table L_FEEDBACKORDER enable constraint FKC4DA7C16E2A64D42;
prompt Enabling foreign key constraints for L_TASKORDER...
alter table L_TASKORDER enable constraint FK8CE718965CA57C50;
alter table L_TASKORDER enable constraint FK8CE718968C9EA303;
alter table L_TASKORDER enable constraint FK8CE71896B0B03922;
alter table L_TASKORDER enable constraint FK8CE71896FE91D6DF;
prompt Enabling foreign key constraints for L_FUNCTION...
alter table L_FUNCTION enable constraint FKC282A6B1C9BC35C;
alter table L_FUNCTION enable constraint FK_PARENT;
alter table L_FUNCTION enable constraint FK_ROLEID;
prompt Enabling foreign key constraints for L_ORDERITEM...
alter table L_ORDERITEM enable constraint FK69F0C70E2C476091;
alter table L_ORDERITEM enable constraint FK69F0C70E694E816E;
prompt Enabling foreign key constraints for L_OUTSTORAGEORDERITEM...
alter table L_OUTSTORAGEORDERITEM enable constraint FK440A6A015F5E4392;
alter table L_OUTSTORAGEORDERITEM enable constraint FK440A6A01694E816E;
prompt Enabling foreign key constraints for L_PURCHASEINSTORAGEORDER...
alter table L_PURCHASEINSTORAGEORDER enable constraint FK8A1FE3ECDEF5B916;
prompt Enabling foreign key constraints for L_PURCHASEPRODUCTORDER...
alter table L_PURCHASEPRODUCTORDER enable constraint FKE9395D53694E816E;
prompt Enabling foreign key constraints for L_PURCHASEPINSTORAGEORDERITEM...
alter table L_PURCHASEPINSTORAGEORDERITEM enable constraint FK4231E2A7694E816E;
alter table L_PURCHASEPINSTORAGEORDERITEM enable constraint FK4231E2A7E3924CF0;
alter table L_PURCHASEPINSTORAGEORDERITEM enable constraint FK4231E2A7F6C86FA2;
prompt Enabling foreign key constraints for L_RETURNPRODUCTORDER...
alter table L_RETURNPRODUCTORDER enable constraint FK70EF33C23B0AFC61;
alter table L_RETURNPRODUCTORDER enable constraint FK70EF33C2694E816E;
alter table L_RETURNPRODUCTORDER enable constraint FK70EF33C2E46602D6;
prompt Enabling foreign key constraints for L_SHORTAGEORDER...
alter table L_SHORTAGEORDER enable constraint FK5BB59358694E816E;
alter table L_SHORTAGEORDER enable constraint FK5BB5935875E8BCC2;
prompt Enabling foreign key constraints for L_SIGNEDORDER...
alter table L_SIGNEDORDER enable constraint FK19170A1F5CA57C50;
alter table L_SIGNEDORDER enable constraint FK19170A1FC7C98206;
alter table L_SIGNEDORDER enable constraint FK19170A1FE2A64D42;
prompt Enabling foreign key constraints for L_STORAGEINFO...
alter table L_STORAGEINFO enable constraint FKADBD216694E816E;
alter table L_STORAGEINFO enable constraint FKADBD216DEF5B916;
prompt Enabling foreign key constraints for L_SUBSATIONINSTORAGEORDER...
alter table L_SUBSATIONINSTORAGEORDER enable constraint FK5E657967254C0998;
prompt Enabling foreign key constraints for L_SUBSATIONINSTORAGEORDERITEM...
alter table L_SUBSATIONINSTORAGEORDERITEM enable constraint FK52CEE0FA694E816E;
alter table L_SUBSATIONINSTORAGEORDERITEM enable constraint FK52CEE0FAF4B7DE56;
prompt Enabling foreign key constraints for L_SUBSTATIONEMPLOYEE...
alter table L_SUBSTATIONEMPLOYEE enable constraint FK909034755CA57C50;
alter table L_SUBSTATIONEMPLOYEE enable constraint FK909034757C98A458;
prompt Enabling foreign key constraints for L_TAKEPRODUCTORDER...
alter table L_TAKEPRODUCTORDER enable constraint FK5BAE7D59E2A64D42;
prompt Enabling triggers for L_ROLE...
alter table L_ROLE enable all triggers;
prompt Enabling triggers for L_USER...
alter table L_USER enable all triggers;
prompt Enabling triggers for L_WAREHOUSE...
alter table L_WAREHOUSE enable all triggers;
prompt Enabling triggers for L_SUBSTATION...
alter table L_SUBSTATION enable all triggers;
prompt Enabling triggers for L_CUSTOMER...
alter table L_CUSTOMER enable all triggers;
prompt Enabling triggers for L_ORDER...
alter table L_ORDER enable all triggers;
prompt Enabling triggers for L_ALLOCATIONORDER...
alter table L_ALLOCATIONORDER enable all triggers;
prompt Enabling triggers for L_CANCELORDER...
alter table L_CANCELORDER enable all triggers;
prompt Enabling triggers for L_CATEGORY...
alter table L_CATEGORY enable all triggers;
prompt Enabling triggers for L_SUPPLIER...
alter table L_SUPPLIER enable all triggers;
prompt Enabling triggers for L_PRODUCT...
alter table L_PRODUCT enable all triggers;
prompt Enabling triggers for L_CHANGEPRODUCTORDER...
alter table L_CHANGEPRODUCTORDER enable all triggers;
prompt Enabling triggers for L_OUTSTORAGEORDER...
alter table L_OUTSTORAGEORDER enable all triggers;
prompt Enabling triggers for L_DISPATCHORDER...
alter table L_DISPATCHORDER enable all triggers;
prompt Enabling triggers for L_DISPATCHORDERITEM...
alter table L_DISPATCHORDERITEM enable all triggers;
prompt Enabling triggers for L_FEEDBACKORDER...
alter table L_FEEDBACKORDER enable all triggers;
prompt Enabling triggers for L_TASKORDER...
alter table L_TASKORDER enable all triggers;
prompt Enabling triggers for L_FUNCTION...
alter table L_FUNCTION enable all triggers;
prompt Enabling triggers for L_ORDERITEM...
alter table L_ORDERITEM enable all triggers;
prompt Enabling triggers for L_OUTSTORAGEORDERITEM...
alter table L_OUTSTORAGEORDERITEM enable all triggers;
prompt Enabling triggers for L_PURCHASEINSTORAGEORDER...
alter table L_PURCHASEINSTORAGEORDER enable all triggers;
prompt Enabling triggers for L_PURCHASEPRODUCTORDER...
alter table L_PURCHASEPRODUCTORDER enable all triggers;
prompt Enabling triggers for L_PURCHASEPINSTORAGEORDERITEM...
alter table L_PURCHASEPINSTORAGEORDERITEM enable all triggers;
prompt Enabling triggers for L_RETURNPRODUCTORDER...
alter table L_RETURNPRODUCTORDER enable all triggers;
prompt Enabling triggers for L_SHORTAGEORDER...
alter table L_SHORTAGEORDER enable all triggers;
prompt Enabling triggers for L_SIGNEDORDER...
alter table L_SIGNEDORDER enable all triggers;
prompt Enabling triggers for L_STORAGEINFO...
alter table L_STORAGEINFO enable all triggers;
prompt Enabling triggers for L_SUBSATIONINSTORAGEORDER...
alter table L_SUBSATIONINSTORAGEORDER enable all triggers;
prompt Enabling triggers for L_SUBSATIONINSTORAGEORDERITEM...
alter table L_SUBSATIONINSTORAGEORDERITEM enable all triggers;
prompt Enabling triggers for L_SUBSTATIONEMPLOYEE...
alter table L_SUBSTATIONEMPLOYEE enable all triggers;
prompt Enabling triggers for L_TAKEPRODUCTORDER...
alter table L_TAKEPRODUCTORDER enable all triggers;
set feedback on
set define on
prompt Done.
