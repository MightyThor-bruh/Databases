USE example;
GO

SELECT OFFICE, ORDER_NUM From OFFICES left outer join SALESREPS On OFFICES.OFFICE = SALESREPS.REP_OFFICE
                           left outer join ORDERS On ORDERS.REP = SALESREPS.EMPL_NUM 
						   where ORDERS.ORDER_NUM is null