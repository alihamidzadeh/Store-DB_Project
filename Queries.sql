-- 1
select *
from item;

-- 2
select *
from customer;

-- 3
select distinct category
from item;

-- 4
select *
from StoreProject.`Order`;

-- 5                        -- hafte va mah okay nakardim
select customerID, fName, lName, phoneNumber, ssn, userName, score
from customer
order by score desc
limit 10;

-- 6						  -- hafte va mah okay nakardim
select *
from item
order by score desc
limit 5;

-- 7
select itemID, name, currentPrice, category, offer
from item
where offer >= 15;

-- 8						
select *
from item, supplier, supplier_supplies_item
where item.itemID = '1' -- given value
and supplier_supplies_item.Item_itemID = item.itemID
and supplier.supplierID = supplier_supplies_item.Supplier_supplierID;

-- 9
select *
from item, supplier, supplier_supplies_item
where item.itemID = '1' -- given value
and supplier_supplies_item.Item_itemID = item.itemID
and supplier.supplierID = supplier_supplies_item.Supplier_supplierID
order by item.currentPrice desc
limit 1;

-- 10
select distinct category
from item;

-- 11    
SELECT * 
from StoreProject.`Order`
where customerID = '1' -- [given value]
ORDER BY orderDate DESC
limit 10;

-- 12
SELECT comments.commentID, comments.title, comments.date, comments.text, comments.itemID, comments.customerID
FROM item 
INNER JOIN comments ON comments.itemID = item.itemID
WHERE comments.itemID = '2';		 -- [given itemID]

-- 13 								BUG (Insert 'score' to comments table)
-- SELECT comments.commentID, comments.title, comments.date, comments.text, comments.itemID, comments.customerID
-- FROM item 
-- INNER JOIN comments ON comments.itemID = item.itemID
-- WHERE comments.itemID = '2'		 -- [given itemID]
-- order by comments.score desc
-- limit 3;

-- 14 								BUG (Insert 'score' to comments table)
-- SELECT comments.commentID, comments.title, comments.date, comments.text, comments.itemID, comments.customerID
-- FROM item 
-- INNER JOIN comments ON comments.itemID = item.itemID
-- WHERE comments.itemID = '2'		 -- [given itemID]
-- order by comments.score asc
-- limit 3;

-- 15								BUG (Change schema)
-- select sum(quantity)
-- from StoreProject.`Order_has_Item` rls
-- where rls.Item_itemID = 1
-- and exists ( select *
-- 	from StoreProject.`Order` o
-- 	where o.orderID = rls.Order_orderID
--     and o.status = "Done"
--     and month(o.orderDate) = 6 );
    
-- 16
select avg(totalPrice)
from StoreProject.`Order` o
where o.`status` = "Done";

-- 17
select * from StoreProject.Customer c
where exists ( select * from StoreProject.Addresses a
	where a.customerID = c.customerID
	and a.city = "Tehran");
    
-- 18
select *
from StoreProject.Supplier s
where s.address like "%Mashad%";