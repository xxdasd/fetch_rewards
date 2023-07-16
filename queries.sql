-- What are the top 5 brands by receipts scanned for most recent month?

select b.brandCode, count(ri.Id) as scanCount
from Brand b, ReceipItem ri, Receipt r
where b.barcode = ri.barcode
and ri.ReceiptId = r.Id
and r.createDate BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()
group by b.barcode, b.brandCode
order by scanCount desc
limit 5;

-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

-- recent month
select b.brandCode, count(ri.Id) as scanCount
from Brand b, ReceipItem ri, Receipt r
where b.barcode = ri.barcode
and ri.ReceiptId = r.Id
and r.createDate BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()
group by b.barcode, b.brandCode
order by scanCount desc
limit 5;

-- previous month
select b.brandCode, count(ri.Id) as scanCount
from Brand b, ReceipItem ri, Receipt r
where b.barcode = ri.barcode
and ri.ReceiptId = r.Id
and r.createDate BETWEEN CURDATE() - INTERVAL 60 DAY AND CURDATE() - INTERVAL 30 DAY
group by b.barcode, b.brandCode
order by scanCount desc
limit 5;

-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
select avg(COALESCE(totalSpent, 0)) as AverageSpend, rewardsReceiptStatus
from Receipt
group by rewardsReceiptStatus;

-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
select sum(COALESCE(purchasedItemCount, 0)) as TotalItems, rewardsReceiptStatus
from Receipt
group by rewardsReceiptStatus;

-- Which brand has the most spend among users who were created within the past 6 months?
select sum(COALESCE(totalSpent, 0)) as SpendAmount, b.barcode, r.brandCode
from Receipt r, User u, Brand b
where r.userId = u.Id and r.barcode = b.barcode
and u.createdDate BETWEEN CURDATE() - INTERVAL 6 MONTH AND CURDATE()
group by r.barcode, r.brandCode;


-- Which brand has the most transactions among users who were created within the past 6 months?
select count(COALESCE(totalSpent, 0)) as NumberOfTransactions, b.barcode, r.brandCode
from Receipt r, User u, Brand b
where r.userId = u.Id and r.barcode = b.barcode
and u.createdDate BETWEEN CURDATE() - INTERVAL 6 MONTH AND CURDATE()
group by r.barcode, r.brandCode;