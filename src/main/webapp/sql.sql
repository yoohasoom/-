create table menu_tbl_008(
menu_cd varchar2(5) not null primary key,
menu_nm varchar2(30),
price number(8),
menu_fg char(1)
);

create table size_tbl_008(
size_cd varchar2(2) not null primary key,
size_nm varchar2(20),
plus_price varchar2(4)
);

create table store_tbl_008(
store_cd varchar2(4) not null primary key,
store_nm varchar2(20),
store_loc varchar(2),
open_date date
);

create table sale_tbl_004(
sale_ymd varchar2(8) not null,
sale_no varchar2(4) not null,
store_cd varchar2(4),
menu_cd varchar2(5),
size_cd varchar2(2),
sale_cnt number(3),
pay_type varchar2(2),
primary key(sale_ymd, sale_no),
foreign key(store_cd) references store_tbl_008(store_cd),
foreign key(menu_cd) references menu_tbl_008(menu_cd),
foreign key(size_cd) references size_tbl_008(size_cd)
);

insert into menu_tbl_008 values('10001', '아메리카노', 3600, '0');
insert into menu_tbl_008 values('10002', '카페 라떼', 4100, '0');
insert into menu_tbl_008 values('10003', '카페 모카', 4600, '0');
insert into menu_tbl_008 values('10004', '카라멜 마끼아또', 5100, '0');
insert into menu_tbl_008 values('10005', '호지 티 라떼', 5400, '1');
insert into menu_tbl_008 values('10006', '그린 티 라떼', 5400, '1');
insert into menu_tbl_008 values('10007', '차이 티 라떼', 4600, '1');

insert into size_tbl_008 values('S1', 'short', '0');
insert into size_tbl_008 values('T1', 'tall', '500');
insert into size_tbl_008 values('G1', 'grande', '1000');
insert into size_tbl_008 values('V1', 'venti', '1500');

insert into store_tbl_008 values('A001', '동부이촌동점', '0', '20181001');
insert into store_tbl_008 values('A002', '이태원점', '0', '20181101');
insert into store_tbl_008 values('A003', '서울타워점', '0', '20181201');
insert into store_tbl_008 values('B004', '소공동점', '1', '20180101');
insert into store_tbl_008 values('B005', '명동길점', '1', '20180201');
insert into store_tbl_008 values('B006', '충무로역점', '1', '20180301');

insert into sale_tbl_004 values('20190429', '0001', 'A001', '10001', 'T1', 4, '02');
insert into sale_tbl_004 values('20190429', '0002', 'B004', '10002', 'S1', 1, '02');
insert into sale_tbl_004 values('20190429', '0003', 'B004', '10006', 'S1', 1, '02');
insert into sale_tbl_004 values('20190429', '0004', 'A002', '10006', 'T1', 1, '01');
insert into sale_tbl_004 values('20190429', '0005', 'B005', '10001', 'G1', 1, '01');
insert into sale_tbl_004 values('20190429', '0006', 'B005', '10003', 'S1', 2, '02');
insert into sale_tbl_004 values('20190429', '0007', 'A003', '10002', 'T1', 3, '02');
insert into sale_tbl_004 values('20190429', '0008', 'B006', '10001', 'S1', 4, '02');

<--List-->
select menu_cd, menu_nm, price, menu_fg from menu_tbl_008;

<--Edit-->
update menu_tbl_008 set menu_nm = ?, price = ?, menu_fg = ? where menu_cd = ?;

<--MeRegi-->
insert into menu_tbl_008 values(?, ?, ?, ?);

<--Regi1-->
select store_cd, store_nm from store_tbl_008 group by store_cd, store_nm;

<--Regi2-->
select menu_cd, menu_nm from menu_tbl_008 group by menu_cd, menu_nm;

<--Regi2-->
select size_cd, size_nm from size_tbl_008 group by size_cd, size_nm;

<--Regi2-->
select max(sale_no)+1 from sale_tbl_004;

<--RegiConfirm-->
insert into sale_tbl_004 values(?, ?, ?, ?, ?, ?, ?);

<--Result-->
select sa.sale_ymd, sa.sale_no, st.store_nm, me.menu_nm, si.size_nm, sa.sale_cnt, sum((me.price + si.plus_price) * sa.sale_cnt) as total, sa.pay_type
from menu_tbl_008 me, size_tbl_008 si, store_tbl_008 st, sale_tbl_004 sa
where me.menu_cd = sa.menu_cd and si.size_cd = sa.size_cd and st.store_cd = sa.store_cd
group by sa.sale_ymd, sa.sale_no, st.store_nm, me.menu_nm, si.size_nm, sa.sale_cnt, sa.pay_type
order by sa.sale_no;