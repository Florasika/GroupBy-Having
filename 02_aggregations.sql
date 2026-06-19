-- ============================================================
--  JOUR 3 / 10 DAYS OF SQL — Agrégations
--  Concepts : GROUP BY · HAVING · COUNT · SUM · AVG · MIN/MAX
-- ============================================================

-- ── 1. COUNT : compter les lignes ───────────────────────────
SELECT COUNT(*) AS nb_ventes
FROM sales;


-- ── 2. SUM : additionner une colonne ────────────────────────
SELECT SUM(montant) AS chiffre_affaires_total
FROM sales;


-- ── 3. AVG : calculer une moyenne ───────────────────────────
SELECT AVG(montant) AS panier_moyen
FROM sales;


-- ── 4. MIN / MAX : valeurs extrêmes ──────────────────────────
SELECT
    MIN(montant) AS plus_petite_vente,
    MAX(montant) AS plus_grosse_vente
FROM sales;


-- ── 5. Combiner plusieurs agrégats en une requête ───────────
SELECT
    COUNT(*)        AS nb_ventes,
    SUM(montant)    AS ca_total,
    AVG(montant)    AS panier_moyen,
    MIN(montant)    AS vente_min,
    MAX(montant)    AS vente_max
FROM sales;


-- ── 6. GROUP BY : agréger par groupe ─────────────────────────
-- Chiffre d'affaires par vendeur
SELECT
    vendeur,
    SUM(montant) AS ca_total
FROM sales
GROUP BY vendeur
ORDER BY ca_total DESC;


-- ── 7. GROUP BY avec plusieurs agrégats ─────────────────────
SELECT
    vendeur,
    COUNT(*)     AS nb_ventes,
    SUM(montant) AS ca_total,
    AVG(montant) AS panier_moyen
FROM sales
GROUP BY vendeur
ORDER BY ca_total DESC;


-- ── 8. GROUP BY sur plusieurs colonnes ───────────────────────
-- CA par région ET par catégorie
SELECT
    region,
    categorie,
    SUM(montant) AS ca_total,
    COUNT(*)     AS nb_ventes
FROM sales
GROUP BY region, categorie
ORDER BY region, ca_total DESC;


-- ── 9. HAVING : filtrer APRÈS l'agrégation ──────────────────
-- Vendeurs ayant généré plus de 15 000€ de CA
SELECT
    vendeur,
    SUM(montant) AS ca_total
FROM sales
GROUP BY vendeur
HAVING SUM(montant) > 15000
ORDER BY ca_total DESC;

-- Différence avec WHERE :
-- WHERE filtre les LIGNES avant l'agrégation
-- HAVING filtre les GROUPES après l'agrégation


-- ── 10. WHERE + GROUP BY + HAVING ensemble ──────────────────
-- Parmi les ventes de 2024, catégories ayant + de 5 ventes
SELECT
    categorie,
    COUNT(*)     AS nb_ventes,
    SUM(montant) AS ca_total
FROM sales
WHERE date_vente >= '2024-01-01'
GROUP BY categorie
HAVING COUNT(*) > 5
ORDER BY ca_total DESC;


-- ── 11. Agrégation avec calcul dérivé ───────────────────────
-- Marge moyenne en % par catégorie (simulé sur prix_unitaire)
SELECT
    categorie,
    AVG(prix_unitaire)         AS prix_moyen,
    SUM(quantite)               AS unites_vendues,
    SUM(montant)                AS ca_total,
    ROUND(AVG(montant), 2)      AS panier_moyen_categorie
FROM sales
GROUP BY categorie
ORDER BY ca_total DESC;


-- ── 12. COUNT(DISTINCT ...) : compter sans doublons ─────────
-- Nombre de produits différents vendus par catégorie
SELECT
    categorie,
    COUNT(DISTINCT produit) AS nb_produits_differents,
    COUNT(*)                AS nb_ventes_total
FROM sales
GROUP BY categorie;


-- ── 13. GROUP BY avec date (extraction du mois) ─────────────
-- CA mensuel
SELECT
    strftime('%Y-%m', date_vente) AS mois,
    SUM(montant)                  AS ca_mensuel,
    COUNT(*)                      AS nb_ventes
FROM sales
GROUP BY mois
ORDER BY mois;


-- ── 14. TOP N avec GROUP BY + ORDER BY + LIMIT ──────────────
-- Top 3 des région/catégorie générant le plus de CA
SELECT
    region,
    categorie,
    SUM(montant) AS ca_total
FROM sales
GROUP BY region, categorie
ORDER BY ca_total DESC
LIMIT 3;


-- ── 15. REQUÊTE COMPLÈTE — Rapport vendeur détaillé ─────────
-- Performance complète par vendeur : volume, CA, panier moyen,
-- uniquement les vendeurs avec au moins 6 ventes
SELECT
    vendeur,
    COUNT(*)                    AS nb_ventes,
    SUM(quantite)                AS unites_vendues,
    SUM(montant)                 AS ca_total,
    ROUND(AVG(montant), 2)       AS panier_moyen,
    MIN(montant)                 AS plus_petite_vente,
    MAX(montant)                 AS plus_grosse_vente
FROM sales
GROUP BY vendeur
HAVING COUNT(*) >= 6
ORDER BY ca_total DESC;
