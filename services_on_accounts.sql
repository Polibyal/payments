-- Задача 1
-- Отоюражить сумму неоплаченных начислений за декабрь и ноябрь
  
SELECT 
    accounts.account, 
    MIN(balance) AS sum_dec, 
    MIN(balance) + SUM(b_add_sum.add_sum) AS sum_nov 
FROM accounts
INNER JOIN service
ON accounts.account = service.account
INNER JOIN b_add_sum
ON service.absid = b_add_sum.absid AND b_add_sum.add_date = '01.12.2022'
WHERE balance < 0 
GROUP BY accounts.account
  
-- Задача 2
-- Вывести ЛС на которых есть две услуги в статусе Активна

SELECT account, absid, serv_status 
FROM service
WHERE account IN (
    SELECT account 
    FROM service
    WHERE serv_status = 'Active'
    GROUP BY account
    HAVING COUNT(account) = 2
)
ORDER BY account

-- Задача 3
-- Вывести только те ЛС, где на адресе не больше одного лицевого счета.

SELECT MAX(account), address_id 
FROM accounts
GROUP BY address_id
HAVING COUNT(address_id) <= 1