--Bai1
EXPLAIN ANALYZE
SELECT * 
FROM customers 
WHERE phone = '0901111111';
--PostgreSQL đã sử dụng phương pháp Index Scan-Execution time: 0.06s 
--Seq không hiệu quả vì phương pháp này phải đọc từng dòng
--cho nên nếu phải xử lý lượng dữ liệu lớn sẽ tốn rất nhiều thời gian
--Bai2
CREATE INDEX idx_customers_phone 
ON customers(phone);
EXPLAIN ANALYZE
SELECT * 
FROM customers 
WHERE phone = '0910099999';
--Execution time: 0.022s
--Index scan sẽ tìm scan trực tiếp thông qua index và nhảy thẳng đến vị trí dữ liệu
--Bai3
EXPLAIN ANALYZE
INSERT INTO customers (full_name, phone, address)
VALUES ('Test Index User', '0999999999', '123 Test Index');
--Execution time: 2.013s
--Lý do khiến INSERT chậm hơn là vì thêm công đoạn cập nhật Index
--Đáng nếu như sử dụng SELECT nhiều
--Bai4
CREATE INDEX idx_customers_address 
ON customers(address);
EXPLAIN
SELECT * 
FROM customers
WHERE address = 'Address 500' 
   OR phone LIKE '091001%';	

