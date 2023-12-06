SELECT count(c.customer_id), s.branch_name FROM cliente c , sucursal s 
WHERE c.branch_id = s.branch_id 
GROUP BY s.branch_name
ORDER BY count(c.customer_id) DESC;


SELECT s.branch_id, s.branch_name, round(CAST(count(DISTINCT e.employee_id)as REAL)/count(DISTINCT c.customer_id),2) AS empleados_por_cliente 
FROM sucursal s  
INNER JOIN empleado e ON s.branch_id = e.branch_id
INNER JOIN cliente c ON s.branch_id = c.branch_id
GROUP by s.branch_id


SELECT s.branch_name, count(t.card_id), m.card_brand_description FROM cliente c
INNER JOIN tarjeta t ON c.customer_id = t.customer_id
INNER JOIN sucursal s ON c.branch_id = s.branch_id
INNER JOIN marca_tarjeta m ON t.card_brand_id = m.card_brand_id
WHERE t.card_type = 'credito'
GROUP BY  t.card_brand_id, s.branch_name
ORDER BY s.branch_name;

CREATE VIEW prestamosCLientes_view
AS 
SELECT
	c.customer_id,
    c.branch_id,
    c.customer_name,
    c.customer_surname,
    c.customer_DNI,
    sum(p.loan_total) as prestamos_total
FROM
	cliente c
INNER JOIN prestamo p ON c.customer_id = p.customer_id
GROUP BY c.customer_id

SELECT avg(p.prestamos_total) AS promedioCredito, s.branch_name  FROM prestamosCLientes_view p, sucursal s 
WHERE p.branch_id = s.branch_id 
GROUP BY s.branch_name;


CREATE TABLE auditoria_cuenta (
    old_id INTEGER,
    new_id INTEGER,
    old_balance REAL,
    new_balance REAL,
    old_iban VARCHAR(50),
    new_iban VARCHAR(50),
    old_type TEXT,
    new_type TEXT,
    user_action VARCHAR(50),
    create_at TIMESTAMP
);

CREATE TRIGGER actualizar_auditoria_cuenta212
    AFTER UPDATE ON cuenta
BEGIN
	INSERT INTO auditoria_cuenta (
		old_id,
		new_id,
		old_balance,
		new_balance,
		old_iban,
		new_iban,
        old_type,
        new_type,
		user_action,
		create_at
	)
VALUES
	(
		old.account_id,
		new.account_id,
		old.balance,
		new.balance,
		old.iban,
		new.iban,
        old.account_type_id,
        new.account_type_id,
		'UPDATE',
		DATETIME('NOW')
	);

UPDATE cuenta SET balance = balance - 100 WHERE account_id = 10 and account_id IN (10,11,12,13,14);
END;

UPDATE cuenta SET balance = balance + 100 WHERE iban = 'FI5598296752114394';

CREATE INDEX dni_cliente ON cliente (customer_DNI);

CREATE TABLE movimientos (
    movimiento_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER,
    amount REAL,
    type TEXT,
    create_at TIMESTAMP
);



BEGIN TRANSACTION;
    INSERT INTO movimientos (account_id, amount, type, create_at) VALUES (200, 1000, 'deposito', DATETIME('NOW'));
    UPDATE cuenta SET balance = balance + 1000 WHERE account_id = 200;
    INSERT INTO movimientos (account_id, amount, type, create_at) VALUES (400, -1000, 'retiro', DATETIME('NOW'));
    UPDATE cuenta SET balance = balance - 1000 WHERE account_id = 400;
ROLLBACK;