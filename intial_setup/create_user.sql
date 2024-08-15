DROP USER IF EXISTS 'acore'@'localhost';
CREATE USER 'acore'@'%' IDENTIFIED BY 'SQLPASSWORD';
GRANT ALL PRIVILEGES ON * . * TO 'acore'@'%';
exit