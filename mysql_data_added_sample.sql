-- Sample Data for Tailoring Management Database
-- This file contains INSERT statements for all tables

USE tailor;

-- Insert Customers
INSERT INTO customer VALUES 
(1,'NIKSHITA',836965071,'LOWER PAREL'),
(2,'GANGA',916733660,'PAREL'),
(3,'AHALYA',865259276,'WORLI'),
(4,'PADMAVATI',987654321,'TIRCHANOOR'),
(5,'MEENAKSHI',123456789,'DADAR'),
(6,'PRASHANTHI',717171717,'MATUNGA'),
(7,'RAMA',989898989,'BANDRA'),
(8,'SEETA',909090909,'ANDHERI'),
(9,'GEETA',121212121,'ANDHERI'),
(10,'RITA',343434343,'SION'),
(11,'SELVI',656565656,'MATUNGA'),
(12,'ARUNDHA',777777777,'KARIMNAGAR'),
(13,'SHOBHA',977777777,'PRABHADEVI'),
(14,'PUSHPA',877777777,'MAHIM'),
(15,'REVA',677777777,'MAROL');

-- Insert Tailors
INSERT INTO my_tailor VALUES 
(1001,919191919,'Ahalya'),
(1002,123456789,'Kesha'),
(1003,987654321,'Nikshita'),
(1004,78125487,'Ganga'),
(1005,123459876,'Anamika');

-- Insert Garment Types
INSERT INTO garment_type VALUES 
(1,'Blouse','Cotton, Lace'),
(2,'Kurti','Silk'),
(3,'Saree Fall','Georgette'),
(4,'Salwar Suit','Cotton'),
(5,'Petticoat','Linen'),
(6,'Blazer','Wool'),
(7,'Skirt','Denim'),
(8,'Gown','Satin'),
(9,'Anarkali','Chiffon'),
(10,'Lehenga','Net'),
(11,'Sherwani','Silk'),
(12,'Choli','Velvet'),
(13,'Trouser','Cotton'),
(14,'Jacket','Leather'),
(15,'Shirt','Linen');

-- Insert Measurements
INSERT INTO measurements VALUES 
('1','26','36','11','14','14',1),
('2','30','40','12','15','13.5',2),
('3','31','42','13','14','14.5',3),
('4','27','37','15','13','13.7',4),
('5','27','36','15','14','14.6',5),
('6','28.6','36.9','15.7','14.7','14.6',6),
('7','27.6','39.9','17.7','14.7','14.6',7),
('8','29.6','38.9','16.7','14.7','13.6',8),
('9','30','46','10','15','16',9),
('10','26','39','10','5','16',10),
('11','28','40','5','15','14',11),
('12','30','42','14','12','14',12),
('13','32','44','16','15','15',13),
('14','30','42','16','14.8','15',14),
('15','35','50','15','18','15',15);

-- Insert Orders
INSERT INTO order_list VALUES 
(1,'12-4-24','250',1,'COMPLETED',1001),
(2,'15-5-24','2500',2,'COMPLETED',1002),
(3,'25-5-24','500',3,'COMPLETED',1003),
(4,'13-4-24','1000',4,'PENDING',1004),
(5,'13-7-24','100',5,'PENDING',1005),
(6,'23-6-24','1500',6,'COMPLETED',1001),
(7,'20-6-24','700',7,'PENDING',1002),
(8,'23-5-24','1700',8,'PENDING',1003),
(9,'14-4-24','400',9,'COMPLETED',1004),
(10,'14-4-24','400',10,'COMPLETED',1005),
(11,'13-08-24','4800',11,'COMPLETED',1001),
(12,'20-08-24','800',12,'COMPLETED',1002),
(13,'29-08-24','7000',13,'PENDING',1003),
(14,'09-09-24','970',14,'PENDING',1004),
(15,'12-09-24','7800',15,'COMPLETED',1005);

-- Insert Payment Records
INSERT INTO payment VALUES 
(1,'Gpay','250'),
(2,'COD','2500'),
(3,'NetBanking','500'),
(4,'NetBanking','1000'),
(5,'Gpay','100'),
(6,'Gpay','1500'),
(7,'Card','700'),
(8,'Card','1700'),
(9,'COD','400'),
(10,'Gpay','400'),
(11,'Gpay','4800'),
(12,'NetBanking','800'),
(13,'COD','7000'),
(14,'Card','970'),
(15,'NetBanking','7800');

-- Insert Order Status Log
INSERT INTO order_status_log VALUES 
(1,1,'PENDING','2025-07-12 16:55:32',1001),
(2,2,'COMPLETED','2025-07-12 16:55:32',1002),
(3,3,'COMPLETED','2025-07-12 16:55:32',1003),
(4,4,'PENDING','2025-07-12 16:55:32',1004),
(5,5,'PENDING','2025-07-12 16:55:32',1005),
(6,6,'COMPLETED','2025-07-12 16:55:32',1001),
(7,7,'PENDING','2025-07-12 16:55:32',1002),
(8,8,'PENDING','2025-07-12 16:55:32',1003),
(9,9,'COMPLETED','2025-07-12 16:55:32',1004),
(10,10,'COMPLETED','2025-07-12 16:55:32',1005),
(11,11,'COMPLETED','2025-07-12 16:55:32',1001),
(12,12,'COMPLETED','2025-07-12 16:55:32',1002),
(13,13,'PENDING','2025-07-12 16:55:32',1003),
(14,14,'PENDING','2025-07-12 16:55:32',1004),
(15,15,'COMPLETED','2025-07-12 16:55:32',1005),
(16,1,'COMPLETED','2025-07-12 16:55:42',1001);

-- Insert Customer Order Details
INSERT INTO customer_order_details VALUES 
(1,1,1,1,1001),(2,2,2,2,1001),(3,3,3,3,1001),
(4,4,4,4,1001),(5,5,5,5,1001),(6,6,6,6,1001),
(7,7,7,7,1001),(8,8,8,8,1001),(9,9,9,9,1001),
(10,10,10,10,1001),(11,11,11,11,1001),(12,12,12,12,1001),
(13,13,13,13,1001),(14,14,14,14,1001),(15,15,15,15,1001);

-- Insert Customer Order Payment
INSERT INTO customer_order_payment VALUES 
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),
(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),
(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15);
