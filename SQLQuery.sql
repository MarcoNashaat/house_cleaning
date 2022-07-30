--Query the whole dataset
SELECT * 
FROM Houseing_data

--Converting 'SaleDate' column to only dates
ALTER TABLE Houseing_data
ALTER COLUMN SaleDate DATE

SELECT SaleDate
FROM Houseing_data

--Populating 'PropertyAddress' column
SELECT *
FROM Houseing_data
WHERE PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Houseing_data AS a
JOIN Houseing_data AS b
ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

--Breaking out 'PropertyAddress' column to address & city
SELECT PropertyAddress
FROM Houseing_data

SELECT LEFT(PropertyAddress, CHARINDEX(',', PropertyAddress)-1) AS address,
RIGHT(PropertyAddress, LEN(PropertyAddress) - CHARINDEX(',', PropertyAddress)) AS city
from Houseing_data

ALTER TABLE houseing_data
ADD property_address_split nvarchar(255)

UPDATE Houseing_data
SET property_address_split = LEFT(PropertyAddress, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE houseing_data
ADD property_city_split nvarchar(255)

UPDATE Houseing_data
SET property_city_split = RIGHT(PropertyAddress, LEN(PropertyAddress) - CHARINDEX(',', PropertyAddress))

SELECT *
FROM Houseing_data

--Breaking out 'OwnerAddress' column to address & city & state
SELECT owneraddress
FROM Houseing_data

SELECT PARSENAME(REPLACE(owneraddress, ',', '.'),3) AS address,
PARSENAME(REPLACE(owneraddress, ',', '.'),2) AS city,
PARSENAME(REPLACE(owneraddress, ',', '.'),1) AS state
FROM Houseing_data

ALTER TABLE houseing_data
ADD owner_address_split nvarchar(255)

UPDATE Houseing_data
SET owner_address_split = PARSENAME(REPLACE(owneraddress, ',', '.'),3)

ALTER TABLE houseing_data
ADD owner_city_split nvarchar(255)

UPDATE Houseing_data
SET owner_city_split = PARSENAME(REPLACE(owneraddress, ',', '.'),2)

ALTER TABLE houseing_data
ADD owner_state_split nvarchar(255)

UPDATE Houseing_data
SET owner_state_split = PARSENAME(REPLACE(owneraddress, ',', '.'),1)

SELECT *
FROM Houseing_data

--Modifying 'SoldAsVacant' column
SELECT DISTINCT(soldasvacant)
FROM Houseing_data

SELECT soldasvacant,
CASE WHEN soldasvacant = 'N' THEN 'NO'
	 WHEN soldasvacant = 'Y' THEN 'Yes'
	 ELSE soldasvacant
	 END AS soldasvacant_modified
FROM Houseing_data

UPDATE Houseing_data
SET soldasvacant = CASE WHEN soldasvacant = 'N' THEN 'NO'
	 WHEN soldasvacant = 'Y' THEN 'Yes'
	 ELSE soldasvacant
	 END 


