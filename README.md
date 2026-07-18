<img width="1237" height="626" alt="dashboard" src="https://github.com/user-attachments/assets/b71b0149-8497-4815-bf28-54a2a20933dd" />
# COVID-19 Tableau 대시보드

## 프로젝트 소개

SQL을 활용하여 코로나19 데이터를 조회·가공한 후 Tableau를 이용해 국가별 감염 현황과 사망률을 시각화한 프로젝트입니다.

## 사용 기술
* SQL Server
* Tableau Public
* Excel

## 주요 분석 내용

### 1. 전 세계 확진자 및 사망자 집계 (Global Numbers)
* 일자별 신규 확진자(`new_cases`)와 신규 사망자(`new_deaths`)의 총합을 구하여, 전 세계 누적 확진율 대비 사망률(`DeathPercentage`) 지표를 도출했습니다.

### 2. 대륙별 사망자 수 비교 (Total Deaths Per Continent)
* 국가 단위 데이터와 대륙별 집계 데이터가 섞여 통계가 왜곡되는 것을 방지하기 위해 `where continent is not null` 조건 및 `World`, `European Union` 등의 항목을 제외하는 필터링을 거쳐 순수 대륙별 누적 사망자 수(`TotalDeathCount`)를 정확하게 대조했습니다.

### 3. 국가별 인구 대비 감염률 분석 (Percent Population Infected Per Country)
* 단순히 확진자 수의 절대 규모만 비교하면 인구 대국의 수치에 착시가 생기므로, 국가별 총인구(`Population`) 대비 최대 누적 확진자 수(`MAX(total_cases)`)를 연산하여 인구 비례 감염 밀도 지표를 추출하고 지리적 맵(Map)으로 시각화했습니다.

### 4. 월별 감염 추이 시각화 (Percent Deaths Per Continent)
* 팬데믹 초기부터의 누적 확산 추이를 라인 차트로 정밀 추적하여 서구권 국가들과 아시아권(한국, 일본)의 인구 대비 감염률 곡선 및 피크(Peak) 트렌드를 시계열로 대조 분석했습니다.

## SQL 파일

* [Tableau Portfolio Project SQL Query.sql](./Tableau%20Portfolio%20Project%20SQL%20Query.sql)
  * *주요 포함 내용:* 데이터 정합성(Data Integrity) 확보를 위한 대륙·국가별 필터링 조건 기입, 인구 대비 누적 확진율/사망률 연산 쿼리, 시계열 그룹화(`GROUP BY`) 제어 스크립트 수록.

## Tableau Public

https://public.tableau.com/app/profile/jaejeong.park/viz/CovidDashboard_17836064779280/1_1?publish=yes

## 데이터 출처

Our World in Data COVID-19 Dataset
https://ourworldindata.org/coronavirus
