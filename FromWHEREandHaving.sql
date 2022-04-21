
-- WHERE and HAVING
-- Extract a list of all names that are encountered less than 200 times. 
-- Let the data refer to people hired after the 1st of January 1999

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees