##  SQL BASICS

# Ans 1
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100) NOT NULL,        
    age INTEGER CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,             
    salary DECIMAL DEFAULT 30000,
    gender CHAR(1),                         
    phone_number VARCHAR(15));

 /* Ans 2   
Constraints ensure data integrity by enforcing rules that restrict data entry, update, or deletion. 
They help maintain data accuracy, consistency, and reliability.

Common types of constraints:

1. Primary Key (PK): Unique identifier for each row.
2. Foreign Key (FK): Links to PK of another table.
3. NOT NULL: Ensures a column has a value.
4. UNIQUE: Ensures all values in a column are unique.
5. CHECK: Restricts values based on a condition.
6. DEFAULT: Provides a default value if none is specified.
 */
 
  /* Ans 3 
1. Ensure that a value is always provided for that column.
2. Prevent NULL values, which can cause errors or inconsistencies in data analysis and queries.

A primary key (PK) cannot contain NULL values. Here's why:

1. Uniqueness: A PK must uniquely identify each row. NULL values would violate this principle, as multiple rows could have NULL values.
2. Identification: A PK serves as a unique identifier for each row. NULL values would make it impossible to identify rows reliably.
3. Referential Integrity: Foreign keys (FK) reference PK values. If a PK allows NULL values, it would compromise the integrity of FK relationships.
*/

/* Ans 4

Adding a Constraint:
1. ALTER TABLE: Use the ALTER TABLE command to modify the existing table.
2. ADD CONSTRAINT: Specify the ADD CONSTRAINT clause to add a new constraint.
3. Constraint Name: Provide a name for the constraint.
4. Constraint Type: Specify the type of constraint (e.g., NOT NULL, UNIQUE, CHECK, etc.).

Example:
ALTER TABLE employees
ADD CONSTRAINT chk_age CHECK (age >= 18);

Removing a Constraint:
1. ALTER TABLE: Use the ALTER TABLE command to modify the existing table.
2. DROP CONSTRAINT: Specify the DROP CONSTRAINT clause to remove an existing constraint.
3. Constraint Name: Provide the name of the constraint to be dropped.

Example:
ALTER TABLE employees
DROP CONSTRAINT chk_age;
*/

/* ans 5
When attempting to insert, update, or delete data in a way that violates constraints
the database management system (DBMS) will prevent the operation and raise an error. The consequences of violating constraints include:

1. Error messages: The DBMS will generate an error message indicating the constraint violation.
2. Transaction rollback: The entire transaction may be rolled back to maintain data consistency.
3. Data integrity: The data remains consistent and accurate, as the constraint ensures that invalid data is not inserted or updated.

Example:
Suppose we have a table employees with a UNIQUE constraint on the email column:

CREATE TABLE employees (
  emp_id INTEGER PRIMARY KEY,
  email TEXT UNIQUE NOT NULL);
  
If we attempt to insert a duplicate email address:
INSERT INTO employees (email) VALUES ('saniyapacha@gmail.com');
INSERT INTO employees (email) VALUES ('saniyapacha@gmail.com');

The DBMS will raise an error:
ERROR:  duplicate key value violates unique constraint "employees_email_key"
DETAIL:  Key (email)=(saniyapacha@gmail.com) already exists.
*/

/* ans 6
--> Add primary key constraint to product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

--> Add default value constraint to price
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
*/

-- ANS 7 

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class_id INT
);

INSERT INTO Students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50)
);

INSERT INTO Classes (class_id, class_name) VALUES (101, 'Math');
INSERT INTO Classes (class_id, class_name) VALUES (102, 'Science');
INSERT INTO Classes (class_id, class_name) VALUES (103, 'History');

-- SOLUTION
SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c ON s.class_id = c.class_id;

-- ANS 8
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Products (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);

-- SOLUTION
SELECT o.order_id, c.customer_name, p.product_name
FROM products p
LEFT JOIN orders o ON p.order_id = o.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;

-- ANS 9

CREATE TABLE Sale (
    sale_id INT,
    product_id INT,
    amount DECIMAL(10, 2)
);

INSERT INTO Sale (sale_id, product_id, amount) VALUES
(1, 101, 500),
(2, 102, 300),
(3, 101, 700);

CREATE TABLE Product (
    product_id INT,
    product_name VARCHAR(50)
);
INSERT INTO Product (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Phone');

-- SOLUTION
SELECT p.product_name, SUM(s.amount) AS total_sales
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- ANS 10

CREATE TABLE Customerss (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

INSERT INTO Customerss (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-02', 1),
(2, '2024-01-05', 2);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Order_Details (order_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);

-- SOLUTION
SELECT o.order_id, c.customer_name, od.quantity
FROM orders o
INNER JOIN customerSs c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id;


-----------------------------------------------------------------------------------------------------------------------------------------
# SQL COMMANDS

/*
ANS 1. 
- Primary Keys:
    - actor_id (actors table)
    - customer_id (customers table)
    - film_id (films table)
    - rental_id (rentals table)
- Foreign Keys:
    - film_id (rentals table) references film_id (films table)
    - customer_id (rentals table) references customer_id (customers table)
    - actor_id (film_actor table) references actor_id (actors table)
    - film_id (film_actor table) references film_id (films table)
*/

-- ANS 2. 
SELECT * FROM actor;
 
-- ANS 3
SELECT * FROM customer;

-- ANS 4
SELECT DISTINCT country FROM country;

-- ANS 5. 
SELECT * FROM customer WHERE active = 1;

-- ANS 6. 
SELECT rental_id FROM rental WHERE customer_id = 1;

-- ANS 7. 
SELECT * FROM film WHERE rental_duration > 5;

-- ANS 8. 
SELECT COUNT(*) FROM film WHERE replacement_cost BETWEEN 15 AND 20;

-- ANS 9. 
SELECT COUNT(DISTINCT first_name) FROM actors;

-- ANS 10
 SELECT * FROM customer LIMIT 10;

-- ANS 11. 
SELECT * FROM customer WHERE first_name LIKE 'b%' LIMIT 3;

-- ANS 12. 
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

-- ANS 13. 
SELECT * FROM customer WHERE first_name LIKE 'a%';

-- ANS 14. 
SELECT * FROM customer WHERE first_name LIKE '%a';

-- ANS 15. 
SELECT city FROM city WHERE city LIKE 'a%a' LIMIT 4;

-- ANS 16. 
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- ANS 17. 
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- ANS 18. 
SELECT * FROM customer WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

-- ANS 19. 
SELECT * FROM customer WHERE first_name LIKE 'a%o';

-- ANS 20. 
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

-- ANS 21. 
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

-- ANS 22. 
SELECT * FROM actor LIMIT 50;

-- ANS 23. 
SELECT DISTINCT film_id FROM inventory;

--------------------------------------------------------------------------------------------------------------------------------------
## FUNCTIONS 
## Basic Aggregate Functions:

-- ANS 1. 
SELECT COUNT(*) AS total_rentals FROM rental;

-- ANS 2. 
SELECT AVG(rental_duration) AS average_rental_duration FROM film;

-- ANS 3. 
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM customer;

-- ANS 4. 
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

-- ANS 5. 
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- ANS 6. 
SELECT i.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;

-- ANS 7. 
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;


-- ANS 8. 
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;


-- ANS 9. 
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;


-- ANS 10. 
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';


-- ANS 11. 
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


-- ANS 12. 
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London';


-- ANS 13. 
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;


-- ANS 14. 
SELECT customer_id
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


-------------------------------------------------------------------------------------------------------------------------------------
### WINDOWS FUNCTIONS:-

-- ANS 1: 
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM
    customer c
    JOIN payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name;
    
    

-- ANS 2:
SELECT
    f.film_id,
    f.title,
    p.payment_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id;



-- ANS 3:
SELECT
    f.film_id,
    f.title,
    f.length,
    AVG(f.rental_duration) OVER (PARTITION BY FLOOR(f.length / 10)) AS avg_rental_duration
FROM
    film f;



-- ANS 4:
WITH FilmCategoryRank AS (
    SELECT
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank
    FROM
        category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN film f ON fc.film_id = f.film_id
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name, f.title, c.category_id
)
SELECT
    category_name,
    title,
    rental_count
FROM
    FilmCategoryRank
WHERE
    rank <= 3;
    
    

-- ANS 5:
WITH CustomerRentalCounts AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS total_rentals
    FROM
        customer c
        JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
),
AverageRentals AS (
    SELECT
        AVG(total_rentals) AS avg_rentals
    FROM
        CustomerRentalCounts
)
SELECT
    crc.customer_id,
    crc.first_name,
    crc.last_name,
    crc.total_rentals,
    ar.avg_rentals,
    crc.total_rentals - ar.avg_rentals AS rental_difference
FROM
    CustomerRentalCounts crc
    CROSS JOIN AverageRentals ar;



-- ANS 6
SELECT
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS monthly_revenue
FROM
    payment p
GROUP BY
    DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY
    month;



-- ANS 7
WITH CustomerSpending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent
    FROM
        customer c
        JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
),
SpendingThreshold AS (
    SELECT
        PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_spent) AS top_20_percent_threshold
    FROM
        CustomerSpending
)
SELECT
    cs.customer_id,
    cs.first_name,
    cs.last_name,
    cs.total_spent
FROM
    CustomerSpending cs
    JOIN SpendingThreshold st ON cs.total_spent >= st.top_20_percent_threshold
ORDER BY
    cs.total_spent DESC;



-- ANS 8

WITH CategoryRentalCounts AS (
    SELECT
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN film f ON fc.film_id = f.film_id
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
)
SELECT
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM
    CategoryRentalCounts
ORDER BY
    rental_count DESC;



-- ANS 9 
WITH FilmRentalCounts AS (
    SELECT
        f.film_id,
        f.title,
        c.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        film f
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category c ON fc.category_id = c.category_id
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, c.category_id, c.name
),
CategoryAverages AS (
    SELECT
        category_id,
        AVG(rental_count) AS avg_rentals
    FROM
        FilmRentalCounts
    GROUP BY
        category_id
)
SELECT
    f.title,
    f.category_name,
    f.rental_count,
    ca.avg_rentals
FROM
    FilmRentalCounts f
    JOIN CategoryAverages ca ON f.category_id = ca.category_id
WHERE
    f.rental_count < ca.avg_rentals
ORDER BY
    f.category_name, f.rental_count;


 
-- ANS 10
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM
    payment
GROUP BY
    DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY
    total_revenue DESC
LIMIT 5;

-----------------------------------------------------------------------------------------------------------------------------------------
## Normalisation & CTE

/*ANS 1
Table: Hypothetical violation in staff table if it had a column like phone_numbers with multiple values (e.g., '123456, 987654').

Normalization to 1NF:
Create a new table staff_phone(staff_id, phone_number) with one phone number per row.*/

/*ANS 2
Table: film_actor (composite key: film_id, actor_id)

Check: All non-key attributes must depend on the full composite key.
It is in 2NF because last_update depends on both film_id and actor_id.
If it had an attribute like film_title, it would violate 2NF (partial dependency).

Fix: Move film_title to a separate film table linked by film_id.*/

/*ANS 3
Table: address (columns: address_id, address, city_id, postal_code, city_name)
Violation: city_name is transitively dependent on city_id through another table (city).

Normalization to 3NF:

Remove city_name from address.
Keep only city_id in address.
Join with city table to get city_name when needed.*/

/*ANS 4
Table (Unnormalized):
rental_summary
Columns: customer_id, customer_name, rental_id, rental_date, films_rented (e.g., 'Film1, Film2')

1NF (Eliminate multivalued attributes):
Split films_rented into individual rows.

New Table:
rental_detail
Columns: customer_id, customer_name, rental_id, rental_date, film_title

2NF (Remove partial dependencies):
Move customer details to a separate table.

Tables after 2NF:

customer(customer_id, customer_name)
rental(rental_id, customer_id, rental_date)
rental_detail(rental_id, film_title)*/


-- ANS 5
WITH actor_film_count AS (
  SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(fa.film_id) AS film_count
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM actor_film_count;


-- ANS 6 
WITH film_language_cte AS (
  SELECT 
    f.title AS film_title,
    l.name AS language_name,
    f.rental_rate
  FROM film f
  JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_language_cte;


-- ANS 7
WITH customer_revenue_cte AS (
  SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_revenue
  FROM customer c
  JOIN payment p ON c.customer_id = p.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM customer_revenue_cte;


-- ANS 8
WITH ranked_films AS (
  SELECT 
    title,
    rental_duration,
    RANK() OVER (ORDER BY rental_duration DESC) AS rank_by_duration
  FROM film
)
SELECT * FROM ranked_films;


-- ANS 9
WITH rental_count_cte AS (
  SELECT 
    customer_id,
    COUNT(rental_id) AS total_rentals
  FROM rental
  GROUP BY customer_id
  HAVING COUNT(rental_id) > 2
)
SELECT 
  c.customer_id,
  c.first_name,
  c.last_name,
  rc.total_rentals
FROM rental_count_cte rc
JOIN customer c ON rc.customer_id = c.customer_id;


-- ANS 10
WITH monthly_rentals AS (
  SELECT 
    DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
    COUNT(*) AS total_rentals
  FROM rental
  GROUP BY rental_month
)
SELECT * FROM monthly_rentals;


-- ANS 11
WITH actor_pairs AS (
  SELECT 
    fa1.film_id,
    fa1.actor_id AS actor1_id,
    fa2.actor_id AS actor2_id
  FROM film_actor fa1
  JOIN film_actor fa2 
    ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT 
  ap.film_id,
  a1.first_name || ' ' || a1.last_name AS actor1_name,
  a2.first_name || ' ' || a2.last_name AS actor2_name
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id;


-- ANS 12
WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: Start with the given manager
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = 1  -- Replace with the desired manager's ID

    UNION ALL

    -- Recursive member: Find staff who report to the above
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    INNER JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM employee_hierarchy;



