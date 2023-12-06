SELECT * FROM cuenta WHERE balance < 0;

SELECT customer_name, customer_surname, edad FROM clientes_view WHERE customer_surname LIKE '%z%';

SELECT c.customer_name, c.customer_surname, c.edad, s.branch_name FROM clientes_view c, sucursal s WHERE c.customer_name == 'Brendan' and c.branch_id = s.branch_id ORDER BY s.branch_id DESC;

SELECT * FROM prestamo where loan_type == "PRENDARIO"
INTERSECT
SELECT * FROM prestamo where loan_total > 8000000

SELECT * FROM prestamo WHERE loan_total > (SELECT AVG(loan_total) FROM prestamo);

SELECT count(*) AS clientesMenores50 FROM clientes_view WHERE edad < 50;

SELECT * FROM cuenta WHERE balance > 800000 LIMIT 5;

SELECT * FROM prestamo WHERE strftime('%m', loan_date) == '04' OR strftime('%m', loan_date) == '05' OR strftime('%m', loan_date) == '06' ORDER BY loan_total;

SELECT loan_type, SUM(loan_total) AS loan_total_accu FROM prestamo GROUP BY loan_type;