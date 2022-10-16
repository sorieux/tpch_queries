CREATE OR REPLACE VIEW revenue AS
  SELECT
	l.suppkey AS supplier_no,
	sum(l.extendedprice * (1 - l.discount)) AS total_revenue
FROM
	lineitem l
WHERE
	l.shipdate >= DATE '1996-01-01'
	AND l.shipdate < DATE '1996-01-01' + INTERVAL '3' MONTH
GROUP BY
	l.suppkey;

SELECT
	s.suppkey,
	s.name,
	s.address,
	s.phone,
	total_revenue
FROM
	supplier s,
	revenue
WHERE
	s.suppkey = supplier_no
	AND total_revenue = (
	SELECT
		max(total_revenue)
	FROM
		revenue
  )
ORDER BY
	s.suppkey;
	
-- Without view	
WITH revenue AS (
	SELECT
			l.suppkey AS supplier_no,
			sum(l.extendedprice * (1 - l.discount)) AS total_revenue
	FROM
			lineitem l
	WHERE
			l.shipdate >= DATE '1996-01-01'
		AND l.shipdate < DATE '1996-01-01' + INTERVAL '3' MONTH
	GROUP BY
			l.suppkey
)
SELECT
	s.suppkey,
	s.name,
	s.address,
	s.phone,
	total_revenue
FROM
	supplier s,
	revenue
WHERE
	s.suppkey = supplier_no
	AND total_revenue = (
	SELECT
		max(total_revenue)
	FROM
		revenue
  )
ORDER BY
	s.suppkey
