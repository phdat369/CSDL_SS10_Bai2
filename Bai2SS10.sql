use ss10;
CREATE TABLE Patients2 (
Patient_ID INT PRIMARY KEY auto_increment,
Full_Name VARCHAR(100),
Phone VARCHAR(15),
Age INT,
Address varchar(255)
);
drop table patients2;
DELIMITER / /
CREATE PROCEDURE SeedPatients()
BEGIN
DECLARE i INT DEFAULT 1;
WHILE i < 500000 DO
INSERT INTO Patients2 (Full_Name, Phone, Age, Address)
VALUES (CONCAT('Patient ', i), CONCAT('090', i), FLOOR(RAND()*100), 'Ho Chi Minh City');
SET i = i + 1;
END WHILE;
END / /
DELIMITER ;
-- Gọi procedure đề nạp dữ liệu
CALL SeedPatients();

explain analyze select patient_id,full_name,phone,age,address
from patients2
where phone = '0900000001';

create index idx_patient_id
on patients2 (patient_id);

explain analyze select  patient_id,full_name,phone,age,address
from patients2
where phone = '0900000001';

-- Khi truy vấn dữ liệu có index thì sẽ nhanh hơn khi không có index
-- Còn khi insert dữ liệu mà có index thì dữ liệu nó sẽ chậm hơn do với có index