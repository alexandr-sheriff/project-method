INSERT INTO user (user_id, activation_code, active, email, firstname, fullname, lastname, password,
                                 username)
VALUES (1, '', true, 'alexandr.shafarenko@gmail.com
', 'admin', 'admin admin', 'admin', '$2a$04$4Xeg4SfSxP1OTQ8A8Q3zl.C1hR.xEOv8tzdnj.cDQKEes/L7YBUTq', 'admin');
INSERT INTO user_roles (user_id, roles)
VALUES (1, '_1_ADMIN');

INSERT INTO user (user_id, activation_code, active, email, firstname, fullname, lastname, password,
                                 username)
VALUES (2, '', true, 'alexandr.shafarenko@gmail.com
', 'teacher', 'teacher teacher', 'teacher', '$2a$04$az3n7u4Cii5N9l4bga3fSOx5vAZkzJFb/Jlg/F6/thewNLRwBZr.S', 'teacher');
INSERT INTO user_roles (user_id, roles)
VALUES (2, '_2_TEACHER');

INSERT INTO user (user_id, activation_code, active, email, firstname, fullname, lastname, password,
                                 username)
VALUES (3, '', true, 'alexandr.shafarenko@gmail.com
', 'student', 'student student', 'student', '$2a$04$Inm9jPkCMp8ttcR6rsS33OBkwRlgdsBvgNewvOyFYlQTalJPk5QQa', 'student');
INSERT INTO user_roles (user_id, roles)
VALUES (3, '_3_STUDENT');