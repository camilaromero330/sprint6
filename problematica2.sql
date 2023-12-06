CREATE VIEW clientes_view
AS 
SELECT
	c.customer_id,
    c.branch_id,
    c.customer_name,
    c.customer_surname,
    c.customer_DNI,
    cast(strftime('%Y.%m%d', 'now') - strftime('%Y.%m%d', c.dob ) as integer) as edad
FROM
	cliente c


SELECT * FROM clientes_view WHERE edad > 40 ORDER BY customer_DNI DESC

SELECT * FROM clientes_view WHERE customer_name == "Anne" or customer_name == "Tyler" ORDER BY edad ASC


SELECT [key],value
FROM OPENJSON('["en-GB", "en-UK","de-AT","es-AR","sr-Cyrl"]')