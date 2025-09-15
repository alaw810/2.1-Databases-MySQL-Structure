DELIMITER $$

CREATE TRIGGER after_video_view_insert
AFTER INSERT ON video_views
FOR EACH ROW
BEGIN
  UPDATE videos
  SET num_views = num_views + 1
  WHERE video_id = NEW.video_id;
END;
$$


CREATE TRIGGER after_video_reaction_insert
AFTER INSERT ON video_reactions
FOR EACH ROW
BEGIN
  IF NEW.reaction = 'like' THEN
    UPDATE videos
    SET num_likes = num_likes + 1
    WHERE video_id = NEW.video_id;
  ELSE
    UPDATE videos
    SET num_dislikes = num_dislikes + 1
    WHERE video_id = NEW.video_id;
  END IF;
END;
$$

CREATE TRIGGER after_video_reaction_delete
AFTER DELETE ON video_reactions
FOR EACH ROW
BEGIN
  IF OLD.reaction = 'like' THEN
    UPDATE videos
    SET num_likes = num_likes - 1
    WHERE video_id = OLD.video_id;
  ELSE
    UPDATE videos
    SET num_dislikes = num_dislikes - 1
    WHERE video_id = OLD.video_id;
  END IF;
END;
$$

CREATE TRIGGER after_video_reaction_update
AFTER UPDATE ON video_reactions
FOR EACH ROW
BEGIN
  IF OLD.reaction <> NEW.reaction THEN
    IF OLD.reaction = 'like' THEN
      UPDATE videos
      SET num_likes = num_likes - 1,
          num_dislikes = num_dislikes + 1
      WHERE video_id = NEW.video_id;
    ELSE
      UPDATE videos
      SET num_dislikes = num_dislikes - 1,
          num_likes = num_likes + 1
      WHERE video_id = NEW.video_id;
    END IF;
  END IF;
END;
$$

CREATE TRIGGER after_comment_reaction_insert
AFTER INSERT ON comment_reactions
FOR EACH ROW
BEGIN
  IF NEW.reaction = 'like' THEN
    UPDATE comments
    SET num_likes = num_likes + 1
    WHERE comment_id = NEW.comment_id;
  ELSE
    UPDATE comments
    SET num_dislikes = num_dislikes + 1
    WHERE comment_id = NEW.comment_id;
  END IF;
END;
$$

CREATE TRIGGER after_comment_reaction_delete
AFTER DELETE ON comment_reactions
FOR EACH ROW
BEGIN
  IF OLD.reaction = 'like' THEN
    UPDATE comments
    SET num_likes = num_likes - 1
    WHERE comment_id = OLD.comment_id;
  ELSE
    UPDATE comments
    SET num_dislikes = num_dislikes - 1
    WHERE comment_id = OLD.comment_id;
  END IF;
END;
$$

CREATE TRIGGER after_comment_reaction_update
AFTER UPDATE ON comment_reactions
FOR EACH ROW
BEGIN
  IF OLD.reaction <> NEW.reaction THEN
    IF OLD.reaction = 'like' THEN
      UPDATE comments
      SET num_likes = num_likes - 1,
          num_dislikes = num_dislikes + 1
      WHERE comment_id = NEW.comment_id;
    ELSE
      UPDATE comments
      SET num_dislikes = num_dislikes - 1,
          num_likes = num_likes + 1
      WHERE comment_id = NEW.comment_id;
    END IF;
  END IF;
END;
$$

DELIMITER ;
