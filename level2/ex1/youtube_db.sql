-- Adrià Lorente - YouTube DB

CREATE DATABASE youtube;
USE youtube; 

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL,
    username VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    sex ENUM('m', 'f', 'n/a') NOT NULL,
    country VARCHAR(30) NOT NULL,
    postal_code VARCHAR(10) NOT NULL
);

CREATE TABLE videos (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    size INT,
    file_name VARCHAR(100),
    duration INT,
    thumbnail_path VARCHAR(255),
    num_views INT DEFAULT 0,
    num_likes INT DEFAULT 0,
    num_dislikes INT DEFAULT 0,
    status ENUM('public', 'hidden', 'private') NOT NULL DEFAULT 'public',
    publication_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE video_views (
  user_id INT,
  video_id INT,
  view_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, video_id, view_datetime),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

CREATE TABLE channels (
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(500),
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE subscriptions (
    subscriber_id INT NOT NULL,
    channel_id INT NOT NULL,
    subscription_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (subscriber_id, channel_id),
    FOREIGN KEY (subscriber_id) REFERENCES users(user_id),
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE video_tags (
    video_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (video_id, tag_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);

CREATE TABLE playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('public', 'private') NOT NULL DEFAULT 'private',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE playlist_videos (
    playlist_id INT NOT NULL,
    video_id INT NOT NULL,
    PRIMARY KEY (playlist_id, video_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    video_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    comment_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    num_likes INT DEFAULT 0,
    num_dislikes INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);


CREATE TABLE comment_reactions (
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    reaction ENUM('like', 'dislike') NOT NULL,
    reaction_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, comment_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (comment_id) REFERENCES comments(comment_id)
);

CREATE TABLE video_reactions (
    user_id INT NOT NULL,
    video_id INT NOT NULL,
    reaction ENUM('like', 'dislike') NOT NULL,
    reaction_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, video_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

DELIMITER $$

CREATE TRIGGER after_video_view_insert
AFTER INSERT ON video_views
FOR EACH ROW
BEGIN
  UPDATE videos SET num_views = num_views + 1 WHERE video_id = NEW.video_id;
END;
$$

CREATE TRIGGER after_video_reaction_insert
AFTER INSERT ON video_reactions
FOR EACH ROW
BEGIN
  IF NEW.reaction = 'like' THEN
    UPDATE videos SET num_likes = num_likes + 1 WHERE video_id = NEW.video_id;
  ELSE
    UPDATE videos SET num_dislikes = num_dislikes + 1 WHERE video_id = NEW.video_id;
  END IF;
END;
$$

CREATE TRIGGER after_video_reaction_delete
AFTER DELETE ON video_reactions
FOR EACH ROW
BEGIN
  IF OLD.reaction = 'like' THEN
    UPDATE videos SET num_likes = num_likes - 1 WHERE video_id = OLD.video_id;
  ELSE
    UPDATE videos SET num_dislikes = num_dislikes - 1 WHERE video_id = OLD.video_id;
  END IF;
END;
$$

CREATE TRIGGER after_comment_reaction_insert
AFTER INSERT ON comment_reactions
FOR EACH ROW
BEGIN
  IF NEW.reaction = 'like' THEN
    UPDATE comments SET num_likes = num_likes + 1
    WHERE comment_id = NEW.comment_id;
  ELSE
    UPDATE comments SET num_dislikes = num_dislikes + 1
    WHERE comment_id = NEW.comment_id;
  END IF;
END;
$$

CREATE TRIGGER after_comment_reaction_delete
AFTER DELETE ON comment_reactions
FOR EACH ROW
BEGIN
  IF OLD.reaction = 'like' THEN
    UPDATE comments SET num_likes = num_likes - 1
    WHERE comment_id = OLD.comment_id;
  ELSE
    UPDATE comments SET num_dislikes = num_dislikes - 1
    WHERE comment_id = OLD.comment_id;
  END IF;
END;
$$

DELIMITER ;
