Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4;

--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4;

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country(확진자 중 사망자 수의 확률)
Select Location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%korea%'
order by 1,2

-- Looking at Total Cases vs population(인구 대비 확진자 수)
-- Shows what percentage of population got covid

Select Location, date, population, total_cases, (total_cases / population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
-- Where location like '%korea%'
order by 1,2


-- Looking at Countries with Highest Infection Rate compared to Populaion
Select Location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases / population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
-- Where location like '%korea%'
Group by Location, population
order by PercentPopulationInfected desc


-- Showing Countries with highest Death Count per Population
-- Looking at Countries with Highest Infection Rate compared to Populaion
Select Location, Max(cast(total_deaths as int)) as TotalDeathCount, Max((total_deaths / population)*100) as PercentPopulationDeath
From PortfolioProject..CovidDeaths
-- Where location like '%korea%'
Where continent is not null
Group by Location
order by TotalDeathCount desc


-- LET'S BREAK THINGS DOWN CONTINENT


-- Showing continents with highest death count(사망자수가 가장 많은 대륙)

Select continent, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
-- Where location like '%korea%'
Where continent is not null
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int)) / SUM(new_cases)*100 AS DeathPercentage
From PortfolioProject..CovidDeaths
-- Where location like '%korea%'
Where continent is not null
-- Group by date
order by 1,2

-- Looking at Total Population vs Vaccinations
-- USE CTE

With PopvsVac (continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
-- Where dea.location like '%korea%'
Where dea.continent is not null
-- order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric, 
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
-- Where dea.location like '%korea%'
-- Where dea.continent is not null
-- order by 2,3

select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated

--Creationg View to store date for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3

select *
From PercentPopulationVaccinated