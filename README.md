# 📊 Jour 3 / 10 — SQL : Agrégations (GROUP BY & HAVING)

> **Série : 10 Days of SQL** · Jour 3/10  
> Concepts : COUNT · SUM · AVG · MIN/MAX · GROUP BY · HAVING

---

## 📁 Structure du projet

```
day-03-aggregations/
│
├── 01_setup.sql           ← CREATE TABLE sales + 30 lignes de données
├── 02_aggregations.sql    ← 15 requêtes commentées
├── ventes.db               ← Base SQLite prête à l'emploi
└── README.md
```

---

## 🚀 Installation & Lancement

```bash
# Cloner le repo
git clone https://github.com/ton-pseudo/10-days-sql.git
cd 10-days-sql/day-03-aggregations

# Ouvrir la base directement (déjà créée)
sqlite3 ventes.db

# OU recréer la base depuis zéro
sqlite3 ventes.db < 01_setup.sql

# Exécuter toutes les requêtes
sqlite3 ventes.db < 02_aggregations.sql
```

---

## 📊 Le schéma — table `sales`

| Colonne | Type | Description |
|---------|------|--------------|
| `id` | INTEGER | Clé primaire |
| `date_vente` | DATE | Format YYYY-MM-DD |
| `vendeur` | TEXT | 5 vendeurs : Alice, Karim, Lucie, Nadia, Thomas |
| `region` | TEXT | 4 régions françaises |
| `categorie` | TEXT | Informatique, Mobile, Audio, Wearable |
| `produit` | TEXT | Nom du produit vendu |
| `quantite` | INTEGER | Unités vendues |
| `prix_unitaire` | INTEGER | Prix en euros |
| `montant` | INTEGER | quantité × prix_unitaire |

30 ventes répartis sur 5 mois (janvier à mai 2024) — assez de variété pour grouper par vendeur, région, catégorie ou mois.

---

## 🔑 Les 5 fonctions d'agrégation

```sql
COUNT(*)        -- compte le nombre de lignes
SUM(colonne)    -- additionne les valeurs
AVG(colonne)    -- calcule la moyenne
MIN(colonne)    -- trouve la valeur la plus petite
MAX(colonne)    -- trouve la valeur la plus grande
```

### Sans GROUP BY — un seul résultat global
```sql
SELECT
    COUNT(*)     AS nb_ventes,
    SUM(montant) AS ca_total,
    AVG(montant) AS panier_moyen
FROM sales;
```
Toute la table est traitée comme **un seul groupe**.

---

## 🔑 GROUP BY — une ligne par groupe

```sql
-- Chiffre d'affaires par vendeur
SELECT vendeur, SUM(montant) AS ca_total
FROM sales
GROUP BY vendeur
ORDER BY ca_total DESC;
```

### GROUP BY sur plusieurs colonnes
```sql
-- CA par région ET par catégorie
SELECT region, categorie, SUM(montant) AS ca_total
FROM sales
GROUP BY region, categorie
ORDER BY ca_total DESC;
```
Chaque **combinaison unique** de `region` + `categorie` devient un groupe.

---

## 🔑 HAVING — filtrer les groupes

```sql
-- Vendeurs ayant généré plus de 15 000€ de CA
SELECT vendeur, SUM(montant) AS ca_total
FROM sales
GROUP BY vendeur
HAVING SUM(montant) > 15000
ORDER BY ca_total DESC;
```

### La différence cruciale WHERE vs HAVING

| | Quand ça s'exécute | Sur quoi ça filtre |
|---|---|---|
| `WHERE` | **Avant** l'agrégation | Les lignes individuelles |
| `HAVING` | **Après** l'agrégation | Les groupes (résultats de SUM, COUNT...) |

```sql
-- ❌ IMPOSSIBLE : l'agrégat n'existe pas encore au moment de WHERE
WHERE SUM(montant) > 15000

-- ✅ CORRECT : HAVING s'exécute après le calcul de l'agrégat
HAVING SUM(montant) > 15000
```

### Combiner WHERE et HAVING
```sql
SELECT categorie, COUNT(*) AS nb_ventes, SUM(montant) AS ca_total
FROM sales
WHERE date_vente >= '2024-01-01'   -- filtre les LIGNES d'abord
GROUP BY categorie
HAVING COUNT(*) > 5                -- filtre les GROUPES ensuite
ORDER BY ca_total DESC;
```

---

## 🔑 COUNT(DISTINCT ...) — compter sans doublons

```sql
SELECT
    categorie,
    COUNT(DISTINCT produit) AS nb_produits_differents,
    COUNT(*)                AS nb_ventes_total
FROM sales
GROUP BY categorie;
```
`COUNT(*)` compte toutes les lignes. `COUNT(DISTINCT produit)` ne compte que les valeurs uniques de `produit`.

---

## 🔑 Agrégation par date

```sql
-- Chiffre d'affaires mensuel
SELECT
    strftime('%Y-%m', date_vente) AS mois,
    SUM(montant) AS ca_mensuel
FROM sales
GROUP BY mois
ORDER BY mois;
```
`strftime('%Y-%m', date)` extrait l'année et le mois — pratique pour grouper par période sans créer de colonne supplémentaire.

---

## 🧠 Ordre logique d'exécution SQL

```
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```

C'est pour ça que :
- `WHERE` ne peut pas utiliser un résultat de `SUM()` ou `COUNT()` (l'agrégat n'existe pas encore)
- `HAVING` peut utiliser ces agrégats (il s'exécute après `GROUP BY`)

---

## 💡 Pour aller plus loin

- [ ] Ajouter un `ROUND(AVG(...), 2)` pour limiter les décimales
- [ ] Combiner `HAVING` avec plusieurs conditions (`AND`)
- [ ] Grouper par jour de la semaine avec `strftime('%w', date_vente)`
- [ ] Calculer le pourcentage de chaque catégorie sur le CA total



---

⭐ **Si ce projet t'aide, mets une étoile !**
