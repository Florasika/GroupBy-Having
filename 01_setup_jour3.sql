-- ============================================================
--  JOUR 3 / 10 DAYS OF SQL — Setup : Agrégations
--  Table : sales (ventes avec plusieurs dimensions)
-- ============================================================

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id              INTEGER PRIMARY KEY,
    date_vente      DATE NOT NULL,
    vendeur         TEXT NOT NULL,
    region          TEXT NOT NULL,
    categorie       TEXT NOT NULL,
    produit         TEXT NOT NULL,
    quantite        INTEGER NOT NULL,
    prix_unitaire   INTEGER NOT NULL,
    montant         INTEGER NOT NULL
);

INSERT INTO sales (id, date_vente, vendeur, region, categorie, produit, quantite, prix_unitaire, montant) VALUES
(1,  '2024-01-05', 'Alice',  'Île-de-France',  'Informatique', 'Laptop Pro',    3, 1200, 3600),
(2,  '2024-01-07', 'Karim',  'PACA',           'Mobile',       'Smartphone X',  5,  650, 3250),
(3,  '2024-01-10', 'Lucie',  'Grand Est',      'Informatique', 'Tablette Air',  2,  450,  900),
(4,  '2024-01-12', 'Thomas', 'Île-de-France',  'Audio',        'Écouteurs BT', 10,  120, 1200),
(5,  '2024-01-15', 'Nadia',  'Auvergne',       'Informatique', 'Laptop Pro',    2, 1200, 2400),
(6,  '2024-01-18', 'Alice',  'Île-de-France',  'Wearable',     'Montre Smart',  4,  280, 1120),
(7,  '2024-01-20', 'Karim',  'PACA',           'Mobile',       'Smartphone X',  8,  650, 5200),
(8,  '2024-02-02', 'Alice',  'Île-de-France',  'Mobile',       'Smartphone X',  6,  650, 3900),
(9,  '2024-02-05', 'Karim',  'PACA',           'Wearable',     'Montre Smart',  7,  280, 1960),
(10, '2024-02-08', 'Lucie',  'Grand Est',      'Informatique', 'Laptop Pro',    5, 1200, 6000),
(11, '2024-02-10', 'Thomas', 'Île-de-France',  'Informatique', 'Tablette Air',  4,  450, 1800),
(12, '2024-02-13', 'Nadia',  'Auvergne',       'Audio',        'Écouteurs BT', 12,  120, 1440),
(13, '2024-02-15', 'Alice',  'Île-de-France',  'Mobile',       'Smartphone X',  9,  650, 5850),
(14, '2024-02-20', 'Lucie',  'Grand Est',      'Informatique', 'Laptop Pro',    2, 1200, 2400),
(15, '2024-03-01', 'Alice',  'Île-de-France',  'Informatique', 'Laptop Pro',    3, 1200, 3600),
(16, '2024-03-04', 'Karim',  'PACA',           'Mobile',       'Smartphone X', 11,  650, 7150),
(17, '2024-03-07', 'Lucie',  'Grand Est',      'Wearable',     'Montre Smart',  5,  280, 1400),
(18, '2024-03-12', 'Nadia',  'Auvergne',       'Audio',        'Écouteurs BT', 18,  120, 2160),
(19, '2024-03-15', 'Alice',  'Île-de-France',  'Informatique', 'Laptop Pro',    6, 1200, 7200),
(20, '2024-03-18', 'Karim',  'PACA',           'Mobile',       'Smartphone X',  4,  650, 2600),
(21, '2024-04-02', 'Karim',  'PACA',           'Informatique', 'Laptop Pro',    7, 1200, 8400),
(22, '2024-04-05', 'Lucie',  'Grand Est',      'Wearable',     'Montre Smart',  6,  280, 1680),
(23, '2024-04-10', 'Nadia',  'Auvergne',       'Informatique', 'Tablette Air',  4,  450, 1800),
(24, '2024-04-15', 'Karim',  'PACA',           'Mobile',       'Smartphone X', 10,  650, 6500),
(25, '2024-04-18', 'Lucie',  'Grand Est',      'Informatique', 'Laptop Pro',    5, 1200, 6000),
(26, '2024-05-01', 'Alice',  'Île-de-France',  'Audio',        'Écouteurs BT', 22,  120, 2640),
(27, '2024-05-04', 'Karim',  'PACA',           'Informatique', 'Laptop Pro',    7, 1200, 8400),
(28, '2024-05-07', 'Lucie',  'Grand Est',      'Mobile',       'Smartphone X',  5,  650, 3250),
(29, '2024-05-12', 'Nadia',  'Auvergne',       'Wearable',     'Montre Smart',  9,  280, 2520),
(30, '2024-05-15', 'Alice',  'Île-de-France',  'Informatique', 'Laptop Pro',    8, 1200, 9600);
