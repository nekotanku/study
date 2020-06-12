-- 定義部分
CREATE TABLE Products
    (
        id     INTEGER NOT NULL,
        name   CHAR(32),
        category CHAR(32),
        selling_price INTEGER,
        cost_price INTEGER,
        registration_date DATE,
        PRIMARY KEY (id)
    )
;

-- 入力部分
INSERT
    INTO Products(id, name, category, selling_price, cost_price, registration_date)
    VALUES
        (1, 'Tシャツ', '衣類', 1500, 500, '2018-04-05'),
        (2, 'ボールペン', '事務用品', 100, 30, '2018-06-03'),
        (3, '包丁', 'キッチン用品', 1200, 400, '2018-03-30'),
        (4, 'Yシャツ', '衣類', 2300, 300, '2018-07-23'),
        (5, 'コピー用紙', '事務用品', 500, 200, '2018-02-19'),
        (6, '圧力鍋', 'キッチン用品', 5900, 2000, '2018-11-26'),
        (7, 'カッター', '事務用品', 130, 50, '2018-05-11'),
        (8, 'プリンター', '事務用品', 9800, 2800, '2019-01-12')
;

SELECT name, selling_price FROM Products WHERE name LIKE '%シャツ';
-- 「○○用品」というカテゴリの商品の名前と販売価格を、販売価格が高い順に取得してみよう！
SELECT name, selling_price, category FROM Products WHERE category LIKE '%用品' ORDER BY selling_price DESC;
SELECT name, selling_price FROM Products WHERE selling_price > 500 AND selling_price < 2000;
-- Productsテーブルから、原価が450円より低く、100円より高い商品の名前と原価を取得してみよう！
SELECT name, cost_price FROM Products WHERE cost_price > 100 AND cost_price < 450 ; 
SELECT name, selling_price FROM Products WHERE selling_price IN (100, 2300, 9800);
SELECT name, selling_price FROM Products WHERE selling_price NOT IN (100, 2300, 9800);
-- Productsテーブルから、販売価格が100円、500円、1500円以外の商品の、名前と原価率を取得してみよう！
SELECT name, cost_price / selling_price * 100 AS cost_rate FROM Products WHERE selling_price NOT IN (100, 500, 1500);
-- ビュー（よく使うselect文を保存して使い回セル）
CREATE VIEW  ProductSum (category, count_product)
AS
SELECT category, COUNT(*) FROM Products GROUP BY category;

SELECT category, count_product FROM ProductSum;

-- 以下の条件を満たすビューをProductsテーブルから定義し、定義したビューのすべてのカラムを取得してみよう！
-- ①販売価格が1000円以上
-- ②登録日が2018年7月1日以降
-- ③カラムはname、selling_price、registration_date
CREATE VIEW Product (name, selling_price, registration_date)
AS 
SELECT name, selling_price, registration_date FROM Products 
WHERE selling_price >= 1000 AND registration_date >= '2018-07-01';

SELECT name, selling_price, registration_date FROM Product;

-- サブクエリ
SELECT category, count_product
FROM (SELECT category, COUNT(*) AS count_product
FROM products GROUP BY category)
AS ProductSum;

SELECT AVG(count_product)
FROM (SELECT category, COUNT(*) AS count_product FROM Products GROUP BY category)
AS ProductSum;

-- スカラサブクエリ
SELECT name, selling_price FROM Products
WHERE selling_price > (SELECT AVG(selling_price) FROM Products);

-- 原価率（原価÷販売価格）の平均値より原価率が低い商品の名前と販売価格と原価率を取得しよう！
SELECT name, selling_price, cost_price/selling_price AS cost_rate FROM Products
WHERE cost_price/selling_price < (SELECT AVG(cost_price/selling_price) FROM Products);

-- case
SELECT name, 
	CASE WHEN selling_price >= 5000 THEN selling_price * 0.8
         WHEN selling_price >= 1000 THEN selling_price * 0.9
		 ELSE selling_price
END AS "Sale"
FROM Products;

SELECT 
SUM(CASE WHEN category = 'キッチン用品' THEN selling_price ELSE 0 END) AS "キッチン用品",
SUM(CASE WHEN category = '事務用品' THEN selling_price ELSE 0 END) AS "事務用品",
SUM(CASE WHEN category = '衣類' THEN selling_price ELSE 0 END) AS "衣類"
FROM Products;

-- 販売単価が1000円未満の低額商品、1000円以上5000円未満の中額商品、5000円以上の高額商品の個数をそれぞれ取得しよう！
SELECT 
SUM(CASE WHEN selling_price < 1000 THEN 1 ELSE 0 END) AS "低額商品",
SUM(CASE WHEN selling_price < 5000 AND selling_price >= 1000 THEN 1 ELSE 0 END) AS "中額商品",
SUM(CASE WHEN selling_price >= 5000 THEN 1 ELSE 0 END) AS "高額商品"
FROM Products;

-- 演習問題
SELECT season AS "シーズン", count(*) AS "登録商品数"
FROM ( 
SELECT CASE WHEN registration_date BETWEEN '2018-01-01' AND '2018-06-30' THEN "2018年前半"
	        WHEN registration_date BETWEEN '2018-07-01' AND '2018-12-31' THEN "2018年後半"
			WHEN registration_date BETWEEN '2019-01-01' AND '2019-06-30' THEN "2019年前半"
            ELSE 0 END AS season 
FROM Products) AS Seasons
GROUP BY season ORDER BY COUNT(*);












