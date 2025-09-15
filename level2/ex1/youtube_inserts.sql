-- YouTube inserts

-- ==== USERS ====
INSERT INTO users (user_id, email, password_hash, username, dob, sex, country, postal_code) VALUES
  (1, 'alice@example.com', '$2b$10$alice', 'alice', '1992-04-12', 'f',  'Spain', '08001'),
  (2, 'bob@example.com',   '$2b$10$bob__', 'bobby', '1988-11-23', 'm',  'Spain', '08002'),
  (3, 'carol@example.com', '$2b$10$carol', 'carol', '1995-06-30', 'f',  'Spain', '28001'),
  (4, 'dan@example.com',   '$2b$10$dan__', 'dan',   '1990-02-14', 'm',  'Spain', '28002'),
  (5, 'eve@example.com',   '$2b$10$eve__', 'eve',   '1998-09-05', 'n/a','Spain', '08003');

-- ==== CHANNELS (un canal por usuario) ====
INSERT INTO channels (channel_id, user_id, name, description) VALUES
  (1, 1, 'AliceTrips',   'Viajes y vlogs'),
  (2, 2, 'BobCooks',     'Cocina fácil y rápida'),
  (3, 3, 'CarolMusic',   'Covers y composiciones'),
  (4, 4, 'DanGaming',    'Highlights y guías'),
  (5, 5, 'EveShorts',    'Clips cortos y curiosidades');

-- ==== VIDEOS (public/hidden/private) ====
INSERT INTO videos (video_id, user_id, title, description, size, file_name, duration, thumbnail_url, status, publication_datetime) VALUES
  (1, 1, 'Barcelona Travel Vlog', 'Ruta por el Born y la Barceloneta', 104857600, 'vid001.mp4',  720, 'https://img/vid001.jpg', 'public', '2025-09-01 12:00:00'),
  (2, 2, 'How to Cook Pasta',     'Paso a paso para pasta perfecta',     73400320, 'vid002.mp4',  540, 'https://img/vid002.jpg', 'public', '2025-09-02 18:30:00'),
  (3, 3, 'Guitar Cover: Imagine', 'Cover acústico',                       52428800, 'vid003.mp4',  210, 'https://img/vid003.jpg', 'public', '2025-09-03 09:15:00'),
  (4, 1, 'Draft: Future Video',   'Borrador privado',                     20971520, 'vid004.mp4',  120, 'https://img/vid004.jpg', 'private','2025-09-04 10:00:00'),
  (5, 4, 'Top 10 Gaming Plays',   'Jugadas épicas',                       157286400,'vid005.mp4',  900, 'https://img/vid005.jpg', 'hidden', '2025-09-04 20:45:00');

-- ==== TAGS ====
INSERT INTO tags (tag_id, name) VALUES
  (1, 'travel'),
  (2, 'vlog'),
  (3, 'cooking'),
  (4, 'tutorial'),
  (5, 'music'),
  (6, 'gaming');

-- ==== VIDEO_TAGS (N–N) ====
INSERT INTO video_tags (video_id, tag_id) VALUES
  (1, 1), (1, 2),          -- Barcelona Travel Vlog → travel, vlog
  (2, 3), (2, 4),          -- How to Cook Pasta → cooking, tutorial
  (3, 5),                  -- Guitar Cover → music
  (5, 6);                  -- Gaming Plays → gaming

-- ==== PLAYLISTS ====
INSERT INTO playlists (playlist_id, user_id, name, status) VALUES
  (1, 1, 'My Favorites',   'public'),
  (2, 2, 'Watch Later',    'private'),
  (3, 3, 'Acoustic Vibes', 'public');

-- ==== PLAYLIST_VIDEOS ====
INSERT INTO playlist_videos (playlist_id, video_id) VALUES
  (1, 2), (1, 3),     -- Alice guarda la receta y la cover
  (2, 1), (2, 5),     -- Bob para ver luego
  (3, 3);             -- Carol lista acústica

-- ==== SUBSCRIPTIONS (user → channel) ====
INSERT INTO subscriptions (subscriber_id, channel_id, subscription_datetime) VALUES
  (1, 2, '2025-09-02 19:00:00'),   -- Alice → BobCooks
  (1, 3, '2025-09-03 10:00:00'),   -- Alice → CarolMusic
  (2, 1, '2025-09-03 08:00:00'),   -- Bob → AliceTrips
  (3, 1, '2025-09-03 08:10:00'),   -- Carol → AliceTrips
  (4, 3, '2025-09-04 12:00:00');   -- Dan → CarolMusic

-- ==== COMMENTS ====
INSERT INTO comments (comment_id, user_id, video_id, comment_text, comment_datetime) VALUES
  (1, 2, 1, '¡Qué buen vlog! Me encantó la edición.', '2025-09-01 13:00:00'),
  (2, 3, 2, 'Probé la receta y quedó increíble.',     '2025-09-02 19:05:00'),
  (3, 5, 1, '¿Puedes compartir el mapa de la ruta?',  '2025-09-01 14:20:00'),
  (4, 1, 3, 'Piel de gallina con esta cover.',        '2025-09-03 10:30:00');

-- ==== COMMENT_REACTIONS (1 por usuario/comentario) ====
INSERT INTO comment_reactions (user_id, comment_id, reaction, reaction_datetime) VALUES
  (1, 1, 'like',    '2025-09-01 13:05:00'),  -- Alice like al comentario de Bob
  (3, 1, 'dislike', '2025-09-01 13:06:00'),
  (2, 2, 'like',    '2025-09-02 19:06:00'),  -- Bob like al de Carol
  (4, 4, 'like',    '2025-09-03 10:35:00');  -- Dan like al de Alice

-- ==== VIDEO_REACTIONS (1 por usuario/vídeo) ====
INSERT INTO video_reactions (user_id, video_id, reaction, reaction_datetime) VALUES
  (2, 1, 'like',    '2025-09-01 13:10:00'),  -- Bob like al vídeo de Alice
  (3, 1, 'like',    '2025-09-01 14:25:00'),  -- Carol like al vídeo de Alice
  (1, 2, 'like',    '2025-09-02 19:10:00'),  -- Alice like al de Bob
  (5, 5, 'dislike', '2025-09-04 21:00:00');  -- Eve dislike al de Dan

-- ==== VIDEO_VIEWS (PK = user_id, video_id, view_datetime) ====
INSERT INTO video_views (user_id, video_id, view_datetime) VALUES
  (1, 1, '2025-09-01 12:10:00'),  -- Alice ve su propio vídeo
  (2, 1, '2025-09-01 12:50:00'),
  (3, 1, '2025-09-01 14:22:00'),
  (1, 2, '2025-09-02 19:08:00'),
  (4, 5, '2025-09-04 20:50:00'),
  (5, 5, '2025-09-04 20:55:00');
