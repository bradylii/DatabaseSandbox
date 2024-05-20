DROP DATABASE IF EXISTS HuskyGram;
CREATE DATABASE IF NOT EXISTS HuskyGram;

USE HuskyGram;

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at DATETIME NOT NULL
);

DROP TABLE IF EXISTS follows;
CREATE TABLE IF NOT EXISTS follows (
    created_at DATETIME NOT NULL,
    follower_id INT,
    followee_id INT,
    PRIMARY KEY(follower_id, followee_id),
    FOREIGN KEY(follower_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(followee_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS photos;
CREATE TABLE IF NOT EXISTS photos (
    id INT PRIMARY KEY,
    image_url VARCHAR(255),
    user_id INT,
    created_at DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS tags;
CREATE TABLE IF NOT EXISTS tags (
    id INT PRIMARY KEY,
    tag_name VARCHAR(255),
    created_at DATETIME NOT NULL
);

DROP TABLE IF EXISTS photo_tags;
CREATE TABLE IF NOT EXISTS photo_tags (
    photo_id INT,
    tag_id INT,
    PRIMARY KEY(photo_id, tag_id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(tag_id) REFERENCES tags(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS likes;
CREATE TABLE IF NOT EXISTS likes (
    created_at DATETIME,
    user_id INT,
    photo_id INT,
    PRIMARY KEY(user_id, photo_id),
    FOREIGN KEY(user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(photo_id) REFERENCES photos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS comments;
CREATE TABLE IF NOT EXISTS comments (
    id INT PRIMARY KEY,
    comment_text VARCHAR(255),
    user_id INT,
    photo_id INT,
    created_at DATETIME,
    FOREIGN KEY(user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(photo_id) REFERENCES photos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO users (id, username, created_at)
VALUES (123, 'Brady_Li', NOW()),
(321, 'Timmy123', NOW());

INSERT INTO follows(created_at, follower_id, followee_id)
VALUES (NOW(), 123, 321),
(NOW(), 321, 123);

INSERT INTO photos(id, image_url, user_id, created_at)
VALUES (987, 'happyDOG.com', 123, NOW()),
        (789, 'happyCAT.com', 321, NOW());

INSERT INTO tags(id, tag_name, created_at)
VALUES (001, 'BU', NOW()),
(002, 'NEU', NOW()),
(003, 'SAD', NOW());


INSERT INTO photo_tags(photo_id, tag_id)
VALUES (987, 001),
(987, 002),
(789, 002),
(789, 001);


INSERT INTO likes(created_at, user_id, photo_id)
VALUES (NOW(), 123, 987),
       (NOW(), 123, 789);

INSERT INTO comments(id, comment_text, user_id, photo_id, created_at)
VALUES (010, 'cooool', 123, 987, NOW()),
       (020, 'LOL', 321, 987, NOW());
