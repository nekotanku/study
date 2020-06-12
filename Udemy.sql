-- 定義部分
CREATE TABLE members
    (
        id     INTEGER NOT NULL,
        name   CHAR(32),
        height REAL,
        weight REAL,
        age INTEGER,
        job_id INTEGER,
        PRIMARY KEY (id)
    )
;

CREATE TABLE jobs
    (
        id     INTEGER NOT NULL,
        name   CHAR(32),
        salary INTEGER,
        PRIMARY KEY (id)
    )
 ;

-- 入力部分
INSERT
    INTO members(id, name, height, weight, age, job_id)
    VALUES
        (1, '佐藤', 170.2, 65.2, 60, 4),
        (2, '鈴木', 151.5, 50.3, 53, 2),
        (3, '高橋', 182.1, 85.1, 31, 8),
        (4, '田中', 163.5, 70.6, 36, 3),
        (5, '渡辺', 157.8, 55.8, 62, 7),
        (6, '伊藤', 173.0, 65.3, 75, 1),
        (7, '山本', 166.4, 49.1, 25, 5),
        (8, '中村', 144.1, 56.9, 45, 7),
        (9, '小林', 168.7, 90.1, 38, 3),
        (10, '加藤', 178.6, 78.5, 26, 6)
;
        
INSERT
    INTO jobs(id, name, salary)
    VALUES
        (1, '医師', 1232),
        (2, '弁護士', 1028),
        (3, 'SE', 515),
        (4, '会計士', 1024),
        (5, '薬剤師', 542),
        (6, '保育士', 341),
        (7, '大学教授', 1050),
        (8, '塾講師', 361)
;

SELECT height,weight FROM members;
-- 式や定数を指定できる
SELECT height/100, '2018-04-01', '吉田' FROM members;
-- jobsカラムからnameカラムとsalarylアラムを取得
SELECT name, salary FROM jobs;
-- 条件式 WHERE
SELECT name FROM members WHERE height >= 180;
-- 条件式を複数設定
SELECT name FROM members WHERE height >= 170 OR weight <= 70;
-- 書き順　SELECT -> FROM  -> WHERE
-- レコードの数を数えるCOUNT
SELECT COUNT(*) FROM members WHERE age >= 50;
-- カラム名に別名をつける
SELECT COUNT(*) AS "50歳以上の人数" FROM members WHERE age >= 50;
SELECT height / 100 AS height_m,
	'2018-04-01' AS "測定日",
    '吉田' AS "測定者"
FROM members;
-- membersテーブルから30歳以上かつ身長170cm以上の人数を取得
SELECT COUNT(*) FROM members WHERE age >= 30 AND height >= 170;
-- ORDER BY 並び替え
SELECT name, age FROM members ORDER BY age;
-- order by で並び替えを行っていない場合レコードに順番の概念がない
-- idの順に並べるには ORDER BY idを指定する必要がある
-- SELECT -> FROM -> WHERE-> ORDER BY
-- members テーブルから身長が170cm以上の人の名前(name)と年齢(age)を年齢が高い順に並べ変えて取得
SELECT name, age, height FROM members WHERE height >= 170 ORDER BY age DESC;
-- テーブルをいくつかのグループに分けて扱うGROUP BY
SELECT job_id, COUNT(*) FROM members GROUP BY job_id;
-- SELECT -> FROM -> WHERE-> ORDER BY -> ORDER BY
-- 職業ごとの平均身長
SELECT job_id, AVG(height) AS "平均身長" FROM members GROUP BY job_id;
-- グループ化したテーブルに対して条件を指定するにはHAVING句が必要
SELECT job_id, COUNT(*) FROM members GROUP BY job_id HAVING COUNT(*) = 2;
-- 職種ごとの平均身長が170cmよりも高い職種と、その職種ごとの平均身長を取得
SELECT job_id ,AVG(height) AS "平均身長" FROM members GROUP BY job_id HAVING AVG(height)>=170;











