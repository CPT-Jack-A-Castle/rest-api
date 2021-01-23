SET @admin_user_id = 1;

INSERT INTO user (id, full_name, username, password, email, role)
VALUES (2,
        'Writer Uno',
        'writer1',
        '$2y$10$J/DF8J/Az8DiSEpXel18NOcN0qbYt5VSvKCc8oJFarXDtj7HkmCmK',
        'writer1@localhost',
        'writer'),
       (3,
        'Writer Dos',
        'writer2',
        '$2y$10$J/DF8J/Az8DiSEpXel18NOcN0qbYt5VSvKCc8oJFarXDtj7HkmCmK',
        'writer2@localhost',
        'writer'),
       (4,
        'Writer Tres',
        'writer3',
        '$2y$10$J/DF8J/Az8DiSEpXel18NOcN0qbYt5VSvKCc8oJFarXDtj7HkmCmK',
        'writer3admin@localhost',
        'writer'),
       (5,
        'Reader',
        'reader',
        '$2y$10$J/DF8J/Az8DiSEpXel18NOcN0qbYt5VSvKCc8oJFarXDtj7HkmCmK',
        'admin@localhost',
        'reader');

TRUNCATE TABLE audit_log;

INSERT INTO audit_log (user_id, client_ip, action)
VALUES (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (1, INET_ATON('127.0.0.1'), 'Logged in'),
       (0, INET_ATON('127.0.0.1'), 'Initialised system');

INSERT INTO client (id, creator_uid, name, url, contact_name, contact_email, contact_phone)
VALUES (1,
        @admin_user_id,
        'Insecure Co.',
        'http://in.se.cure',
        'John Doe',
        'John.Doe@in.se.cure',
        '+99 123 245 389'),
       (2,
        @admin_user_id,
        'The OWASP Foundation',
        'https://owasp.org',
        'N/A',
        'N/A',
        '+1 951-692-7703');

INSERT INTO project (id, creator_uid, client_id, name, description, is_template)
VALUES (1,
        @admin_user_id,
        NULL,
        'Linux host template',
        'Project template to show general linux host reconnaissance tasks',
        TRUE),
       (2,
        @admin_user_id,
        1,
        'Web server pentest project',
        'Test project to show pentest tasks and reports',
        FALSE),
       (3,
        @admin_user_id,
        2,
        'Juice Shop (test project)',
        'OWASP Juice Shop is probably the most modern and sophisticated insecure web application! It can be used in security trainings,
awareness demos,
CTFs and as a guinea pig for security tools! Juice Shop encompasses vulnerabilities from the entire OWASP Top Ten along with many other security flaws found in real -world applications!',
        FALSE),
       (4,
        @admin_user_id,
        2,
        ' WebGoat (test project)',
        ' WebGoat is a deliberately insecure application that allows interested developers just like you to test vulnerabilities commonly found in Java-based applications that use common and popular open source components.',
        FALSE);

INSERT INTO report (project_id,
                    insert_ts,
                    generated_by_uid,
                    version_name,
                    version_description)
VALUES (2,
        CURRENT_TIMESTAMP,
        1,
        '1.0',
        ' Initial version '),
       (2,
        DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 3 DAY),
        1,
        '1.1',
        ' Initial version after corrections '),
       (2,
        DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 10 DAY),
        1,
        '1.2 reviewed ',
        ' Report reviewed and sent to the client ');

INSERT INTO project_user (project_id, user_id)
VALUES (2, 1),
       (2, 2);

INSERT INTO target (project_id, name, kind)
VALUES (1, ' https://test.com ', 'url'),
       (2, '127.0.0.1', 'hostname ');

INSERT INTO vulnerability (project_id, target_id, creator_uid, category_id, summary, risk, cvss_score)
VALUES (2,
        1,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        ' Domain about to expire ',
        'medium',
        6.4),
       (2,
        2,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        ' Open port (tcp/22)',
        'medium',
        6.6),
       (2,
        2,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        ' Test vulnerability #0',
        'medium',
        6.8),
       (2,
        2,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #1',
        'medium',
        4.7),
       (2,
        2,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #2',
        'medium',
        6.6),
       (2,
        2,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #3',
        'low',
        2.5),
       (2,
        2,
        @admin_user_id,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #4',
        'none',
        0.0),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #5',
        'low',
        2.0),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #6',
        'low',
        1.4),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #7',
        'low',
        2.7),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #8',
        'low',
        0.2),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #9',
        'critical',
        9.3),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #10',
        'critical',
        9.6),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #11',
        'medium',
        5.2),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #12',
        'low',
        2.8),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #13',
        'high',
        7.7),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #14',
        'low',
        0.1),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #15',
        'high',
        7.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #16',
        'low',
        2.5),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #17',
        'low',
        2.0),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #18',
        'high',
        7.4),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #19',
        'medium',
        5.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #20',
        'medium',
        4.8),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #21',
        'low',
        2.1),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #22',
        'low',
        1.5),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #23',
        'medium',
        4.2),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #24',
        'medium',
        6.8),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #25',
        'medium',
        5.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #26',
        'low',
        0.8),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #27',
        'high',
        7.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #28',
        'medium',
        4.8),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #29',
        'critical',
        9.2),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #30',
        'low',
        3.7),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #31',
        'medium',
        5.6),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #32',
        'high',
        8.6),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #33',
        'low',
        3.6),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #34',
        'medium',
        4.7),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #35',
        'low',
        2.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #36',
        'low',
        1.3),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #37',
        'low',
        3.2),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #38',
        'low',
        1.0),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #39',
        'critical',
        9.6),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #40',
        'medium',
        5.4),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #41',
        'critical',
        9.4),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #42',
        'low',
        0.5),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #43',
        'high',
        8.7),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #44',
        'medium',
        5.7),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #45',
        'low',
        0.1),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #46',
        'critical',
        9.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #47',
        'low',
        1.1),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #48',
        'high',
        8.9),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #49',
        'medium',
        6.6),
       (2,
        2,
        1,
        RAND() * (12 - 1) + 1,
        'Test vulnerability #50',
        'medium',
        4.8);

UPDATE vulnerability
SET cvss_vector = 'CVSS:3.0/AV:P/AC:H/PR:H/UI:R/S:C/C:H/I:H/A:H';

INSERT INTO command (creator_uid, short_name, description, docker_image, container_args)
VALUES (1, 'goohost',
        'Extracts hosts/subdomains, IP or emails for a specific domain with Google search.',
        'reconmap/pentest-container-tools-goohost',
        '-t {{{Domain|||nmap.org}}}'),
       (2, 'nmap', 'Scans all reserved TCP ports on the machine', 'instrumentisto/nmap',
        '-v {{{Host|||scanme.nmap.org}}} -oX nmap-output.xml'),
       (3, 'whois', 'Retrieves information about domain', 'zeitgeist/docker-whois', '{{{Domain|||nmap.org}}}'),
       (4, 'sqlmap', 'Runs SQL map scan', 'paoloo/sqlmap',
        '-u {{{Host|||localhost}}} --method POST --data "{{{Data|||username=foo&password=bar}}}" -p username --level 5 --dbms=mysql -v 1 --tables');

INSERT INTO task (creator_uid, project_id, name, description, command_id)
VALUES (@admin_user_id, 1,
        'Run port scanner',
        'Use nmap to detect all open ports',
        2),
       (@admin_user_id, 1,
        'Run SQL injection scanner',
        'Use sqlmap to test the application for SQL injection vulnerabilities', 4),
       (@admin_user_id, 1,
        'Check domain expiration date',
        'Use whois or other tools to check when the domain expiration is.', 3),
       (@admin_user_id, 2,
        'Run port scanner',
        'Use nmap to detect all open ports', 2),
       (@admin_user_id, 2,
        'Run SQL injection scanner',
        'Use sqlmap to test the application for SQL injection vulnerabilities', 4),
       (@admin_user_id, 2,
        'Check domain expiration date',
        'Use whois or other tools to check when the domain expiration is.', 3);

INSERT INTO command_output (command_id,
                            submitted_by_uid,
                            file_name,
                            file_content,
                            file_size)
VALUES (1,
        1,
        'nmap-output.xml',
        'tcp/22: open, tcp/80: open',
        5421),
       (1,
        2,
        'domain-scan.txt',
        'Domain expires in 22 days',
        204);

INSERT INTO note (user_id,
                  parent_type,
                  parent_id,
                  visibility,
                  content)
VALUES (1,
        'project',
        3,
        'private',
        'Credentials are stored in the secret server'),
       (1,
        'project',
        3,
        'private',
        'The client asked not to touch the servers during office hours.');
