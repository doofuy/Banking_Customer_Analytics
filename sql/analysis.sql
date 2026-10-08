-- ==========================================
-- BANKING CUSTOMER ANALYTICS
-- DAY 1 SQL ANALYSIS
-- ==========================================


-- Q1: Total number of customers
-- Business question:
-- How many customers does the bank have?

SELECT
    COUNT(*) AS total_customers
FROM customers;


-- Q2: Customers by city
-- Business question:
-- How are customers distributed across cities?

SELECT
    City,
    COUNT(*) AS customer_count
FROM customers
GROUP BY City
ORDER BY customer_count DESC;


-- Q3: Customers in Delhi
-- Business question:
-- How many customers are based in Delhi?

SELECT
    COUNT(*) AS delhi_customers
FROM customers
WHERE City = 'Delhi';


-- Q4: Cities with more than 5,000 customers
-- Business question:
-- Which cities have a large customer base?

SELECT
    City,
    COUNT(*) AS customer_count
FROM customers
GROUP BY City
HAVING COUNT(*) > 5000
ORDER BY customer_count DESC;


-- Q5: Overall transaction statistics
-- Business question:
-- What is the overall transaction activity?

SELECT
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_transaction_value,
    AVG(Amount) AS average_transaction,
    MIN(Amount) AS smallest_transaction,
    MAX(Amount) AS largest_transaction
FROM transactions;


-- Q6: Transaction analysis by type
-- Business question:
-- How do Credit and Debit transactions compare?

SELECT
    TransactionType,
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_amount,
    AVG(Amount) AS average_amount
FROM transactions
GROUP BY TransactionType
ORDER BY total_amount DESC;


-- Q7: Transaction analysis by channel
-- Business question:
-- Which transaction channels handle the most activity?

SELECT
    Channel,
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_amount
FROM transactions
GROUP BY Channel
ORDER BY total_amount DESC;


-- Q8: Number of accounts per customer
-- Business question:
-- How many accounts does each customer have?

SELECT
    c.CustomerID,
    c.FullName,
    COUNT(a.AccountID) AS account_count
FROM customers c
LEFT JOIN accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName
ORDER BY account_count DESC
LIMIT 10;


-- Q9: Highest-value customers
-- Business question:
-- Which customers have the highest total transaction value?

SELECT
    c.CustomerID,
    c.FullName,
    SUM(t.Amount) AS total_transaction_value
FROM customers c
JOIN accounts a
    ON c.CustomerID = a.CustomerID
JOIN transactions t
    ON a.AccountID = t.AccountID
GROUP BY
    c.CustomerID,
    c.FullName
ORDER BY total_transaction_value DESC
LIMIT 10;


-- Q10: Transaction size classification
-- Business question:
-- How can transactions be categorized by size?

SELECT
    TransactionID,
    Amount,
    CASE
        WHEN Amount < 1000 THEN 'Small'
        WHEN Amount < 10000 THEN 'Medium'
        ELSE 'Large'
    END AS transaction_size
FROM transactions
LIMIT 20;


-- Q11: Transaction size distribution
-- Business question:
-- How many transactions fall into each size category?

SELECT
    CASE
        WHEN Amount < 1000 THEN 'Small'
        WHEN Amount < 10000 THEN 'Medium'
        ELSE 'Large'
    END AS transaction_size,
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_amount
FROM transactions
GROUP BY transaction_size
ORDER BY total_amount DESC;


-- Q12: Monthly transaction activity
-- Business question:
-- How does transaction activity change over time?

SELECT
    strftime('%Y-%m', TransactionDate) AS month,
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_amount
FROM transactions
GROUP BY month
ORDER BY month;


-- Q13: Debit vs Credit analysis
-- Business question:
-- What is the transaction volume and value for each transaction type?

SELECT
    TransactionType,
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_amount,
    AVG(Amount) AS average_amount
FROM transactions
GROUP BY TransactionType
ORDER BY total_amount DESC;


-- Q14: Customers with multiple accounts
-- Business question:
-- Which customers hold more than one account?

SELECT
    CustomerID,
    COUNT(*) AS account_count
FROM accounts
GROUP BY CustomerID
HAVING COUNT(*) > 1
ORDER BY account_count DESC;


-- Q15: Account balance by account type
-- Business question:
-- How do account types compare in terms of balances?

SELECT
    AccountType,
    COUNT(*) AS account_count,
    AVG(Balance) AS average_balance,
    SUM(Balance) AS total_balance
FROM accounts
GROUP BY AccountType
ORDER BY total_balance DESC;