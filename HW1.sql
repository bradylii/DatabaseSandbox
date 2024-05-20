USE HuskyGram;

-- 1
SELECT *
FROM users JOIN photos;

-- 2
SELECT *
FROM users NATURAL JOIN comments;

-- 3
SELECT *
FROM photos p JOIN photo_tags pt ON p.id = pt.photo_id;

-- 4
SELECT p.id, image_url, COUNT(comment_text) as comment_count
	FROM photos p LEFT OUTER JOIN comments c ON p.id = c.photo_id
	GROUP BY p.id, p.created_at, p.image_url
	ORDER BY p.created_at DESC;

-- 5
SELECT DISTINCT username
FROM users u JOIN photos p ON u.id = p.user_id
JOIN comments c ON p.id = c.photo_id
LEFT OUTER JOIN likes l ON p.id = l.photo_id
WHERE l.created_at IS NULL
ORDER BY username;

-- 6
SELECT COUNT(*) AS num_photos
FROM(
SELECT pt1.photo_id as id1
FROM photo_tags pt1
JOIN tags t1 ON t1.id = pt1.tag_id
WHERE tag_name = 'NEU'
    INTERSECT
SELECT pt2.photo_id as id2
FROM photo_tags pt2
JOIN tags t2 ON t2.id = pt2.tag_id
WHERE tag_name = 'BU') AS t;


-- 7
SELECT username, comment_text
FROM comments c JOIN users u ON u.id = c.user_id
WHERE LOWER(comment_text) LIKE 'college%'
ORDER BY c.created_at;

-- 8
SELECT username AS Username, u.created_at AS date_joined
	FROM users u LEFT OUTER JOIN photos p ON u.id = p.user_id
	WHERE p.created_at IS NULL
	ORDER BY username;
