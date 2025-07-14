DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    credit_score INT,
    Country VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    years_with_bank INT,
    Balance FLOAT,
    num_products INT,
    has_credit_card BOOLEAN,
    is_active_member BOOLEAN,
    estimated_salary FLOAT,
    has_exited BOOLEAN,
    has_complaint BOOLEAN,
    satisfaction_score INT,
    card_type VARCHAR(20),
    points_earned INT,
    churn_status VARCHAR(10),
    age_group VARCHAR(20)
);

--Check for null/missing data
SELECT
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
  SUM(CASE WHEN credit_score IS NULL THEN 1 ELSE 0 END) AS null_credit_score,
  SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS null_country,
  SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
  SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
  SUM(CASE WHEN years_with_bank IS NULL THEN 1 ELSE 0 END) AS null_years_with_bank,
  SUM(CASE WHEN Balance IS NULL THEN 1 ELSE 0 END) AS null_balance,
  SUM(CASE WHEN num_products IS NULL THEN 1 ELSE 0 END) AS null_num_products,
  SUM(CASE WHEN has_credit_card IS NULL THEN 1 ELSE 0 END) AS null_has_credit_card,
  SUM(CASE WHEN is_active_member IS NULL THEN 1 ELSE 0 END) AS null_is_active_member,
  SUM(CASE WHEN estimated_salary IS NULL THEN 1 ELSE 0 END) AS null_estimated_salary,
  SUM(CASE WHEN has_exited IS NULL THEN 1 ELSE 0 END) AS null_has_exited,
  SUM(CASE WHEN has_complaint IS NULL THEN 1 ELSE 0 END) AS null_has_complaint,
  SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END) AS null_satisfaction_score,
  SUM(CASE WHEN card_type IS NULL THEN 1 ELSE 0 END) AS null_card_type,
  SUM(CASE WHEN points_earned IS NULL THEN 1 ELSE 0 END) AS null_points_earned,
  SUM(CASE WHEN churn_status IS NULL THEN 1 ELSE 0 END) AS null_churn_status,
  SUM(CASE WHEN age_group IS NULL THEN 1 ELSE 0 END) AS null_age_group
FROM customers;

--Find overall churn rate
SELECT SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END) AS churned_customers,
	    COUNT(*) AS total_customers,
	    ROUND(100.0*(SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END))/COUNT(*), 2) AS churn_rate
  FROM customers;

--Find churn rate by card type
SELECT card_type,
	    ROUND(100.0*(SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END))/COUNT(*), 2) AS churn_rate
  FROM customers
  GROUP BY card_type
  ORDER BY churn_rate DESC;

 --Churn rate by number of products the customer has
 SELECT 
  num_products,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
	FROM customers
	GROUP BY num_products
	ORDER BY num_products;


 --How does filing a complaint affect churn rate?
 SELECT has_complaint, 
 		ROUND(100.0*(SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END))/COUNT(*), 2) AS churn_rate
 		FROM customers 
		GROUP BY has_complaint;

--Find churn rate by age group and compare to overall average
WITH churn_stats AS (
  SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN has_exited IS TRUE THEN 1 ELSE 0 END) AS total_churned
  FROM customers
),
age_group_stats AS (
  SELECT 
    age_group,
    COUNT(*) AS group_total,
    SUM(CASE WHEN has_exited IS TRUE THEN 1 ELSE 0 END) AS group_churned
  FROM customers
  GROUP BY age_group
)
SELECT 
  a.age_group,
  ROUND(100.0 * group_churned / group_total, 2) AS age_group_churn_rate,
  ROUND(100.0 * total_churned / total_customers, 2) AS overall_churn_rate,
  ROUND(100.0 * group_churned / group_total, 2) - ROUND(100.0 * total_churned / total_customers, 2) AS churn_rate_compared_to_ovr_avg
	FROM age_group_stats a, churn_stats
	ORDER BY churn_rate_compared_to_ovr_avg;

--Find the retention rate by country
SELECT 
  country,
  COUNT(*) FILTER (WHERE churn_status = 'churned') AS churned,
  COUNT(*) FILTER (WHERE churn_status = 'retained') AS retained,
  ROUND((100.0 * COUNT(*) FILTER (WHERE churn_status = 'retained') - COUNT(*) FILTER (WHERE churn_status = 'churned'))/COUNT(*), 2) AS retention_prcnt
	FROM customers
	GROUP BY country
	ORDER BY retention_prcnt DESC;

--Find high risk customers(haven't left yet) - low satisfaction score, inactive, and has filed a complaint
SELECT 
  customer_id, balance, satisfaction_score, is_active_member, has_complaint, estimated_salary
	FROM customers
		WHERE has_exited = FALSE
  		AND satisfaction_score <= 5
 	 	AND balance > 0
  		AND has_complaint = TRUE
  		AND is_active_member = FALSE
		  ORDER BY customer_id ASC;
		  
--Find churn rate by credit card ownership status
SELECT 
  has_credit_card, COUNT(*) AS total,
  SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN has_exited = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS churn_rate
	FROM customers
	GROUP BY has_credit_card;

--Top 5 customers who have left w/ the highest balance
SELECT 
  customer_id, balance, estimated_salary, age, satisfaction_score
	FROM customers
	WHERE has_exited = TRUE
	ORDER BY balance DESC
	LIMIT 5;

--Find customers who have a balance above the average churned customer's balance
SELECT 
  customer_id, age, country, balance, churn_status
	FROM customers
	WHERE balance > (
  		SELECT AVG(balance)
  		FROM customers
  		WHERE has_exited = TRUE
	)	
			ORDER BY balance DESC;


--Average tenure by churn status
SELECT 
  churn_status,
  ROUND(AVG(years_with_bank), 2) AS avg_years
	FROM customers
	GROUP BY churn_status;

--Average salary by churn status
SELECT 
  churn_status,
  ROUND(AVG(estimated_salary)::NUMERIC, 2) AS avg_salary
	FROM customers
	GROUP BY churn_status;



