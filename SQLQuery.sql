select * 
from profilio..Coviddeathmain 

--select * 
--from profilio..covidvaccinationmain

select location, date,total_cases,new_cases,total_deaths,population
from profilio..coviddeathmain
order by 1,2

 --looking at toal cases vs total deaths
 select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
 from profilio..coviddeathmain
 order by 1,2

 --looking at Countries with highest infection
 select location,population,max(total_cases) as HighesyInectionCount,max((total_cases/population))*lllll100 as DeathPercentage
 from profilio..coviddeathmain 
 group by location ,population

 --showing countries with highest death count per population

 select location,max(total_deaths) as TotalDeathCount
 from profilio..coviddeathmain 
 group by location
 order by TotalDeathCount desc
  
 --Break things down by Continent 
 select continent,max(total_deaths) as TotalDeathCount
 from profilio..coviddeathmain 
 where continent is not null
 group by continent
 order by TotalDeathCount desc


 --Global numbers
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast
(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Profilio..coviddeathmain
-- Where location like '%states%'
where continent is not null
-- Group By date
order by 1,2
 
-- Looking at both table

select dea.continent,dea.location,population,dea.date,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as Rolling
from profilio..coviddeathmain dea
join profilio..covidvaccinationmain vac
     on dea.location =vac.location
     and dea.date =vac.date
where dea.continent is not null
order by 2,3

--Use CTE

with PopvsVac (Continent ,Location, Date,Population,New_vaccinations,RollingpepoleVaccinated)
as
(select dea.continent,dea.location,population,dea.date,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as Rolling
from profilio..coviddeathmain dea
join profilio..covidvaccinationmain vac
     on dea.location =vac.location
     and dea.date =vac.date
where dea.continent is not null
)

select * 
from PopvsVac

--temp table
Drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar(255), 
Location nvarchar(255),
Date datetime,
population numeric,
New_vaccinations numeric ,
Rollingpeoplevaccinated numeric
)


insert into #PercentPopulationVaccinated
select 
    dea.continent,
    dea.location,
    TRY_CONVERT(date, dea.date) AS Date,
    TRY_CONVERT(numeric, vac.new_vaccinations) AS New_vaccinations,
    TRY_CONVERT(numeric, dea.population) AS Population,
    SUM(TRY_CONVERT(numeric, vac.new_vaccinations))
        OVER (PARTITION BY dea.location ORDER BY TRY_CONVERT(date, dea.date)) AS RollingPeopleVaccinated
from profilio..coviddeathmain dea
join profilio..covidvaccinationmain vac
     on dea.location =vac.location
     and dea.date =vac.date
where dea.continent is not null


select *
from #PercentPopulationVaccinated



--creating view to store data
Create View PercentPopulationVaccinated as 
select 
    dea.continent,
    dea.location,
    TRY_CONVERT(date, dea.date) AS Date,
    TRY_CONVERT(numeric, vac.new_vaccinations) AS New_vaccinations,
    TRY_CONVERT(numeric, dea.population) AS Population,
    SUM(TRY_CONVERT(numeric, vac.new_vaccinations))
        OVER (PARTITION BY dea.location ORDER BY TRY_CONVERT(date, dea.date)) AS RollingPeopleVaccinated
from profilio..coviddeathmain dea
join profilio..covidvaccinationmain vac
     on dea.location =vac.location
     and dea.date =vac.date
where dea.continent is not null
