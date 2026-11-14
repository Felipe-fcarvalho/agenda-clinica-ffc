BEGIN;

TRUNCATE clinics RESTART IDENTITY CASCADE;

INSERT INTO clinics (name, slug) VALUES ('Clínica Exemplo', 'clinica-exemplo');

INSERT INTO professionals (clinic_id, name, specialty)
SELECT id, 'Dra. Ana Souza', 'Clínica geral' FROM clinics WHERE slug = 'clinica-exemplo';

INSERT INTO professionals (clinic_id, name, specialty)
SELECT id, 'Dr. Bruno Lima', 'Dermatologia' FROM clinics WHERE slug = 'clinica-exemplo';

INSERT INTO services (clinic_id, name, duration_minutes)
SELECT id, 'Consulta', 30 FROM clinics WHERE slug = 'clinica-exemplo';

INSERT INTO services (clinic_id, name, duration_minutes)
SELECT id, 'Retorno', 20 FROM clinics WHERE slug = 'clinica-exemplo';

-- Segunda a sexta, 09:00-12:00 e 14:00-18:00, para todos os profissionais
INSERT INTO working_hours (professional_id, weekday, start_minute, end_minute)
SELECT p.id, d.weekday, h.start_minute, h.end_minute
FROM professionals p
CROSS JOIN (VALUES (1), (2), (3), (4), (5)) AS d(weekday)
CROSS JOIN (VALUES (540, 720), (840, 1080)) AS h(start_minute, end_minute);

COMMIT;