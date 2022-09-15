-- Advanced Data Cleaning

--------------------
-- inserting data into table
insert into `chrome-courage-361619.customer_data.customer_address`
(customer_id, address, city, state, zipcode, country)
values
(2645, '333 SQL Road', 'Jackson', 'MI', 49202, 'US')

--------------------
-- updating a data point
update `chrome-courage-361619.customer_data.customer_address` 
set address = '123 New Address'
where customer_id = 2645

--------------------
-- leaving out duplicates
SELECT 
  distinct (customer_id)
FROM `chrome-courage-361619.customer_data.customer_address`

--------------------
-- countries in the country column are abbreviations, extracting long abbreviated countries
-- ex: Unites States of America = USA which is 
SELECT 
  country
  --length(country) as letters_in_country
FROM `chrome-courage-361619.customer_data.customer_address` 
where length(country) > 2

--------------------
--extracting a substring from a string (start at position 1, extract 2 characters)
-- US (substring) of USA (string)
SELECT 
  DISTINCT(customer_id)
FROM `chrome-courage-361619.customer_data.customer_address` 
where 
  substr(country, 1, 2) = 'US'

--------------------

--correct sub str syntax!!!
SELECT
  distinct invoice_id,
  SUBSTR(billing_city,1,4) AS new_city
FROM
	invoice
ORDER BY
  new_city 

--------------------
-- detecting potential spaces
SELECT 
  state
FROM `chrome-courage-361619.customer_data.customer_address` 
where 
  length(state) > 2 -- interesting "OH" was the output, must have a space somewhere

--------------------
-- trimming the space before or after 'OH'
SELECT 
  DISTINCT customer_id
FROM `chrome-courage-361619.customer_data.customer_address` 
where 
  TRIM(state) = 'OH'


--CAST()
--------------------------------------------- cast float
SELECT cast(purchase_price as float64)
FROM `chrome-courage-361619.customer_data.customer_purchase` 
order by cast(purchase_price as float64) desc
--the schema says the purchase_price current or origianl dt is a string
--i need to convert the string to a float: number with decimals
--typecasting: converting data from one type to another

--------------------------------------------- cast date
select
  cast(date as date) as date_only --convert datetime (default) to date
  ,purchase_price
from`chrome-courage-361619.customer_data.customer_purchase`
where 
  date between '2020-12-01' and '2020-12-31'


--CONCAT()
--------------------------------------------- concat color with product code
select 
  concat(product_code,product_color) as new_product_code
from `chrome-courage-361619.customer_data.customer_purchase`
where 
  product = 'couch'
-- concat colors of couches with couch codes to see what colored couches are most popular

--COALESCE()
--------------------------------------------- coalesce products without product names
select 
  coalesce(product, product_code) as product_info -- if there is a product name then print name if not then give us the product code
from `chrome-courage-361619.customer_data.customer_purchase`

-- coalese: used to return non null values in a list
--------------------

--cleaning up spellings
SELECT
  customer_id
  CASE
    WHEN first_name = 'Tnoy' THEN 'Tony'
    WHEN first_name = 'Tmo' THEN 'Tom'
    WHEN first_name = 'Rachle' THEN 'Rachel'
    ELSE first_name
    END AS cleaned_name
FROM customer_data.customer_name

