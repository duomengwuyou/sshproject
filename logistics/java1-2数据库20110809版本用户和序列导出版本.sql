------------------------------------------
-- Export file for user SCOTT           --
-- Created by ttc on 2011-8-9, 13:34:22 --
------------------------------------------

spool java1-2数据库20110809版本用户和序列导出版本.log

prompt
prompt Creating table L_ROLE
prompt =====================
prompt
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

prompt
prompt Creating table L_USER
prompt =====================
prompt
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

prompt
prompt Creating table L_WAREHOUSE
prompt ==========================
prompt
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

prompt
prompt Creating table L_SUBSTATION
prompt ===========================
prompt
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

prompt
prompt Creating table L_CUSTOMER
prompt =========================
prompt
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

prompt
prompt Creating table L_ORDER
prompt ======================
prompt
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

prompt
prompt Creating table L_ALLOCATIONORDER
prompt ================================
prompt
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

prompt
prompt Creating table L_CANCELORDER
prompt ============================
prompt
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

prompt
prompt Creating table L_CATEGORY
prompt =========================
prompt
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

prompt
prompt Creating table L_SUPPLIER
prompt =========================
prompt
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

prompt
prompt Creating table L_PRODUCT
prompt ========================
prompt
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

prompt
prompt Creating table L_CHANGEPRODUCTORDER
prompt ===================================
prompt
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

prompt
prompt Creating table L_OUTSTORAGEORDER
prompt ================================
prompt
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

prompt
prompt Creating table L_DISPATCHORDER
prompt ==============================
prompt
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

prompt
prompt Creating table L_DISPATCHORDERITEM
prompt ==================================
prompt
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

prompt
prompt Creating table L_FEEDBACKORDER
prompt ==============================
prompt
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

prompt
prompt Creating table L_TASKORDER
prompt ==========================
prompt
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

prompt
prompt Creating table L_FUNCTION
prompt =========================
prompt
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

prompt
prompt Creating table L_ORDERITEM
prompt ==========================
prompt
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

prompt
prompt Creating table L_OUTSTORAGEORDERITEM
prompt ====================================
prompt
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

prompt
prompt Creating table L_PURCHASEINSTORAGEORDER
prompt =======================================
prompt
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

prompt
prompt Creating table L_PURCHASEPRODUCTORDER
prompt =====================================
prompt
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

prompt
prompt Creating table L_PURCHASEPINSTORAGEORDERITEM
prompt ============================================
prompt
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

prompt
prompt Creating table L_RETURNPRODUCTORDER
prompt ===================================
prompt
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

prompt
prompt Creating table L_SHORTAGEORDER
prompt ==============================
prompt
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

prompt
prompt Creating table L_SIGNEDORDER
prompt ============================
prompt
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

prompt
prompt Creating table L_STORAGEINFO
prompt ============================
prompt
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

prompt
prompt Creating table L_SUBSATIONINSTORAGEORDER
prompt ========================================
prompt
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

prompt
prompt Creating table L_SUBSATIONINSTORAGEORDERITEM
prompt ============================================
prompt
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

prompt
prompt Creating table L_SUBSTATIONEMPLOYEE
prompt ===================================
prompt
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

prompt
prompt Creating table L_TAKEPRODUCTORDER
prompt =================================
prompt
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

prompt
prompt Creating sequence ALLOCATIONORDER_SEQ
prompt =====================================
prompt
create sequence ALLOCATIONORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence CANCELORDER_SEQ
prompt =================================
prompt
create sequence CANCELORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence CUSTOMER_SEQ
prompt ==============================
prompt
create sequence CUSTOMER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence HIBERNATE_SEQUENCE
prompt ====================================
prompt
create sequence HIBERNATE_SEQUENCE
minvalue 1
maxvalue 999999999999999999999999999
start with 2209
increment by 1
cache 20;

prompt
prompt Creating sequence ORDERITEM_ID
prompt ==============================
prompt
create sequence ORDERITEM_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence ORDER_SEQ
prompt ===========================
prompt
create sequence ORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 4
increment by 1
cache 20;

prompt
prompt Creating sequence PRODUCT_SEQ
prompt =============================
prompt
create sequence PRODUCT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 4
increment by 1
cache 20;

prompt
prompt Creating sequence PURCHASEINSTORAGEORDER_SEQ
prompt ============================================
prompt
create sequence PURCHASEINSTORAGEORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence PURCHASEPRODUCTORDER_SEQ
prompt ==========================================
prompt
create sequence PURCHASEPRODUCTORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SHORTAGEORDER_SEQ
prompt ===================================
prompt
create sequence SHORTAGEORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence STORAGEINFO_SEQ
prompt =================================
prompt
create sequence STORAGEINFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SUBSTATION_SEQ
prompt ================================
prompt
create sequence SUBSTATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SUPPLIER_SEQ
prompt ==============================
prompt
create sequence SUPPLIER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence TASKORDER_SEQ
prompt ===============================
prompt
create sequence TASKORDER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;


spool off
