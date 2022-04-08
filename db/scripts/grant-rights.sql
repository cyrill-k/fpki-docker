GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'zaphod';
FLUSH PRIVILEGES;

SET GLOBAL max_connections = 1000;
