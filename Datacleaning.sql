select *
from datacleaning.dbo.Nashvillhousing

#2

select SaleDate,CONVERT(date,saledate)
from datacleaning..NashvillHousing

update nashvillhousing	
set saledate = CONVERT(date,saledate)

--3-populate property adress

select *
from datacleaning..NashvillHousing
where propertyaddress is null
order by parcelid

select a.ParcelID ,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from datacleaning..NashvillHousing a
join datacleaning..NashvillHousing b
    on a.parcelid=b.parcelid
    and a.[UniqueID]<>b.[UniqueID]
where a.PropertyAddress is null


update a
set a.PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
from datacleaning..NashvillHousing a
join datacleaning..NashvillHousing b
    on a.parcelid=b.parcelid
    and a.[UniqueID]<>b.[UniqueID]
where a.PropertyAddress is null


--4-Breaking out Adress
select PropertyAddress
from datacleaning..NashvillHousing

select 
SUBSTRING(propertyaddress,1,charindex(',',propertyaddress) -1) as Adress
,SUBSTRING(propertyaddress,charindex(',',propertyaddress) +1,LEN(PropertyAddress)) as Adreess2
from datacleaning..NashvillHousing

ALter table nashvillhousing
add propertySplitAddress Nvarchar(255);

update NashvillHousing
set propertySplitAddress =SUBSTRING(propertyaddress,1,charindex(',',propertyaddress) -1)


ALter table nashvillhousing
add propertySplitCity Nvarchar(255);

update NashvillHousing
set propertySplitCity =SUBSTRING(propertyaddress,charindex(',',propertyaddress) +1,LEN(PropertyAddress))


select *
from datacleaning..NashvillHousing



select OwnerAddress
from datacleaning..NashvillHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From datacleaning..NashvillHousing

ALTER TABLE NashvillHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvillHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvillHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvillHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvillHousing
Add OwnerSplitState Nvarchar(255);

Update NashvillHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


-- 5-Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From datacleaning..NashvillHousing
Group by SoldAsVacant
order by 2

Select distinct(SoldAsVacant)
From datacleaning..NashvillHousing



SELECT 
    SoldAsVacant,
    CASE 
        WHEN SoldAsVacant = 1 THEN 'Yes'
        WHEN SoldAsVacant = 0 THEN 'No'
    END AS SoldAsVacantText
FROM datacleaning..NashvillHousing;

--6- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From datacleaning..NashvillHousing
--order by ParcelID
)

Delete
From RowNumCTE
Where row_num > 1



-- Delete Unused Columns

Select *
From datacleaning..NashvillHousing
	   

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate