Create Database Project;
use Project;
desc project;
desc ivf;
 select * from ivf;
 
 # 1. max_capacity_hrs
 
 -- Mean
 
 select avg(max_capacity_hrs) as mean_max_capacity_hrs from ivf; # 15.7065
 
 -- Median -- 18
 
 select  avg(max_capacity_hrs) as median_max_capacity_hrs
 From ( 
		select  max_capacity_hrs, row_number() over ( order by  max_capacity_hrs) as row_num,
			count(*) over () as total_count from ivf
	) as t
		where row_num in ( (( total_count + 1) / 2 ) , (( total_count + 2) / 2 ) );
        
 -- MODE
 
 select max_capacity_hrs as mode_max_capacity_hrs
 from (
		select max_capacity_hrs, count(*) as frequency
        from ivf
        group by max_capacity_hrs
        order by frequency desc
        limit 1
) as subquery;

-- STDEV 3.6177153224108136

select stddev(max_capacity_hrs) as std_max_capacity_hrs from ivf;

-- Variance 13.087864154005976

Select variance( max_capacity_hrs) as var_max_capacity_hrs from ivf;

-- Skewness -0.9434120546233669

SELECT 
    (SUM(POWER(max_capacity_hrs - (SELECT AVG(max_capacity_hrs) FROM ivf), 3)) / 
    (COUNT(*) * POWER((SELECT STDDEV(max_capacity_hrs) FROM ivf), 3))) AS skewness_max_capacity_hrs
FROM ivf;

-- Kurtosis -1.1099736948565195

SELECT 
    ((SUM(POWER(max_capacity_hrs - (SELECT AVG(max_capacity_hrs) FROM ivf), 4)) / 
    (COUNT(*) * POWER((SELECT STDDEV(max_capacity_hrs) FROM ivf), 4))) - 3) AS max_capacity_hrs
FROM ivf;

-- 2 . utilization_hrs

-- Mean 9.569590163934425

select avg(utilization_hrs) as mean_utilization_hrs from ivf;

-- Median

select avg(utilization_hrs) as median_utilization_hrs
From ( select utilization_hrs, row_number() over ( order by utilization_hrs) as row_num,
		count(*) over () total_count from ivf
) t 
	where row_num in ( ((total_count + 1) / 2) , (( total_count + 2) / 2) );
						
-- Mode

select utilization_hrs as mode_utilization_hrs
From ( select utilization_hrs, count(*) as frequency from ivf 
group by utilization_hrs 
order by frequency
 desc limit 1
 ) as t;
 
 -- SD
 
 select stddev(utilization_hrs) as std_utilization_hrs from ivf;
 
 -- Variance
 
 select variance(utilization_hrs) as var_utilization_hrs from ivf;
 
 --  Range
 
 select max(utilization_hrs) - min(utilization_hrs) as range_utilization_hrs from ivf;
 
 -- Skewness
 
 select 
		(sum( Power(utilization_hrs - ( select avg(utilization_hrs) from ivf), 3)) /
			(count(*) * power((select stddev(utilization_hrs) from ivf), 3))) as skewness_utilization_hrs
            from ivf;
            
-- Kurtosis

select
	( 
    SUM(POWER(utilization_hrs - ( select AVG(utilization_hrs) from ivf), 4)) /
		(count(*) * POWER((select stddev(utilization_hrs) from ivf), 4)) - 3
        ) as kurtosis_utilization_hrs from ivf;
        
-- 3. UTILIZATION_PCT

-- MEAN

SELECT AVG(UTILIZATION_PCT) AS MEAN_UTILIZATION_PCT FROM IVF;

-- MEDIAN

SELECT avg(UTILIZATION_PCT) AS MEDIAN_UTILIZATION_PCT
FROM ( SELECT UTILIZATION_PCT, row_number() OVER (order by UTILIZATION_PCT) as row_num,
		count(*) over () as total_count
        from ivf ) t
        where row_num in  ( (total_count + 1) / 2, (total_count + 2) / 2 );
-- Mode

select UTILIZATION_PCT AS MODE_UTILIZATION_PCT
FROM ( SELECT UTILIZATION_PCT, COUNT(*) AS FREQUENCY
FROM IVF
group by UTILIZATION_PCT
 ORDER BY Frequency DESC
 LIMIT 1
 ) T;

-- std dev

select stddev(UTILIZATION_PCT) as std_UTILIZATION_PCT from ivf;

-- variance

select variance(UTILIZATION_PCT) as var_UTILIZATION_PCT from ivf;


-- Range

select max(UTILIZATION_PCT) - min(UTILIZATION_PCT) as range_UTILIZATION_PCT from ivf;

-- skewness

select
	(
    sum(Power(UTILIZATION_PCT - (select avg(UTILIZATION_PCT) from ivf), 3)) /
	(count(*) * power( (select stddev(UTILIZATION_PCT) from ivf), 3))
        )
        as skewness_UTILIZATION_PCT from ivf;
        
-- Kurtosis 

select 
(
(sum(power(UTILIZATION_PCT - (select avg(UTILIZATION_PCT) from ivf), 4)) /
( count(*) * power((select stddev(UTILIZATION_PCT) from ivf), 4))) - 3
) as kurtosis_UTILIZATION_PCT from ivf;

-- 4. technical_downtime_hrs

-- Mean

select avg(technical_downtime_hrs) as mean_technical_downtime_hrs
 from ivf;
 
 -- Median
 
 select avg(technical_downtime_hrs) as median_technical_downtime_hrs
From (
select technical_downtime_hrs, row_number() over(order by technical_downtime_hrs) as row_num,
count(*) over() as total_count from ivf
) t 
where row_num in ( (total_count + 1) / 2, (total_count + 2) / 2 );

-- Mode

select technical_downtime_hrs as mode_technical_downtime_hrs
From ( select technical_downtime_hrs,
count(*) as Frequency from ivf
group by technical_downtime_hrs
order by frequency desc
limit 1 ) t;

-- stddev

select stddev(technical_downtime_hrs) as std_technical_downtime_hrs from ivf;

-- variance

select variance(technical_downtime_hrs) as var_technical_downtime_hrs from ivf;

-- range

select max(technical_downtime_hrs) - min(technical_downtime_hrs) as range_technical_downtime_hrs from ivf;

-- skewness

select 
		( sum(power(technical_downtime_hrs - (select avg(technical_downtime_hrs) from ivf),3)) /
			( count(*) * power( (select stddev(technical_downtime_hrs) from ivf), 3))
		) as skewness_technical_downtime_hrs from ivf;

-- kurtosis

select 
( 
   (sum(
		Power( technical_downtime_hrs - (select avg(technical_downtime_hrs) from ivf), 4 ))
        /
        ( count(*) * Power( (select stddev(technical_downtime_hrs) from ivf), 4 ))
        ) - 3 
        
) as Kurtosis_technical_downtime_hrs from ivf;

-- 5 planned_maintenance_hrs

-- MEAN

select avg(planned_maintenance_hrs) as mean_planned_maintenance_hrs from ivf;

-- Median

select avg(planned_maintenance_hrs) as median_planned_maintenance_hrs
From (
		select planned_maintenance_hrs, row_number() over(order by planned_maintenance_hrs) as row_num,
        count(*) over() as total_count from ivf
	) t
    where row_num in ( (total_count + 1) / 2, (total_count + 2) / 2 );
    
-- Mode

select planned_maintenance_hrs as mode_planned_maintenance_hrs
From (
		select planned_maintenance_hrs,
        count(*) as frequency from ivf
        group by planned_maintenance_hrs
        order by frequency desc
        limit 1
	) t;

-- stddev

SELECT STDDEV(planned_maintenance_hrs) AS std_planned_maintenance_hrs from ivf;

-- variance

select variance(planned_maintenance_hrs) as var_planned_maintenance_hrs from ivf;

-- range

select max(planned_maintenance_hrs) - min(planned_maintenance_hrs) as range_planned_maintenance_hrs from ivf;
  
-- skewness

select
( 
sum(Power( planned_maintenance_hrs - ( select avg(planned_maintenance_hrs) from ivf ), 3 ))
/
( count(*) * Power( (select stddev(planned_maintenance_hrs) from ivf ), 3 ) )
) as skewness_planned_maintenance_hrs from ivf;

-- kurtosis

select
(
( sum(Power( planned_maintenance_hrs - (select avg(planned_maintenance_hrs) from ivf), 4))
/
( count(*) * power( (select stddev(planned_maintenance_hrs) from ivf), 4) )
) - 3) 
as kurt_planned_maintenance_hrs from ivf;

-- total_cases_day_lab

-- Mean

select avg(total_cases_day_lab) as mean_total_cases_day_lab from ivf;

-- Median

select avg(total_cases_day_lab) as median_total_cases_day_lab
FROM ( select total_cases_day_lab,
       row_number() over( order by total_cases_day_lab) as row_num,
       count(*) over() as total_count from ivf
       ) t
	where row_num in ( (total_count + 1) / 2 ,(total_count + 2) / 2);
    
-- Mode 

select total_cases_day_lab as mode_total_cases_day_lab
From ( select total_cases_day_lab,
		count(*) as Frequency from ivf
        group by total_cases_day_lab
        order by frequency desc
        limit 1
        ) t;
        
-- stddev

select stddev(total_cases_day_lab) as std_total_cases_day_lab from ivf;

-- variance

select variance(total_cases_day_lab) as var_total_cases_day_lab from ivf;

-- skewness

select
( sum(Power( total_cases_day_lab - ( select avg(total_cases_day_lab) from ivf), 3))
/
( count(*) * Power( (select stddev(total_cases_day_lab) from ivf), 3) )
) as skewness_total_cases_day_lab from ivf;

-- kurtosis

select

(
( sum(Power( total_cases_day_lab - (select avg(total_cases_day_lab) from ivf), 4))
/
( count(*) * power( (select stddev(total_cases_day_lab) from ivf), 4) ) 
) - 3 ) as kurt_total_cases_day_lab from ivf;

### DATA PREPROCESSING ######

-- Type Casting
use project;
desc ivf;

Create Table ivf_typecasted as
select 
	  cast(str_to_date(date, '%d-%m-%Y') as date) as Date_casted,
      lab_id,
      cast(equipment_type as char(255)) as equipment_type_casted,
	    equipment_id,
		max_capacity_hrs,
		utilization_hrs,
		utilization_pct,
		idle_hrs,
		technical_downtime_hrs,
		planned_maintenance_hrs,
		workflow_delay_events,
		avg_delay_minutes,
		primary_procedure,
		redundancy_available,
		total_cases_day_lab
	from
		ivf
        where nullif(date, '') is not null
        and
        str_to_date(nullif(date,''), '%d-%m-%Y') is not null ;
      desc ivf_typecasted;
      
-- Duplicate Records

select 
		max_capacity_hrs,
        utilization_hrs,
        utilization_pct,
        idle_hrs,
        technical_downtime_hrs,
        planned_maintenance_hrs,
        workflow_delay_events,
        avg_delay_minutes,
        primary_procedure,
        redundancy_available,
        total_cases_day_lab,
        count(*) as duplicate_count
        from temp_ivf
        group by 
        max_capacity_hrs,
        utilization_hrs,
        utilization_pct,
        idle_hrs,
        technical_downtime_hrs,
        planned_maintenance_hrs,
        workflow_delay_events,
        avg_delay_minutes,
        primary_procedure,
        redundancy_available,
        total_cases_day_lab
        having count(*) >1;
        
-- Remove Duplicates
        
create table temp_ivf as
select DISTINCT
    STR_TO_DATE(NULLIF(date, ''), '%d-%m-%Y') AS Date_casted,
    lab_id,
    CAST(equipment_type AS CHAR(255)) AS equipment_type_casted,
    equipment_id,
    max_capacity_hrs,
    utilization_hrs,
    utilization_pct,
    idle_hrs,
    technical_downtime_hrs,
    planned_maintenance_hrs,
    workflow_delay_events,
    avg_delay_minutes,
    primary_procedure,
    redundancy_available,
    total_cases_day_lab
FROM ivf;

-- Zero & Near Zero Variance;

select 
		variance(max_capacity_hrs) as max_capacity_hrs_var ,
        variance(utilization_hrs) as utilization_hrs_var,
        variance(utilization_pct) as utilization_pct_var,
        variance(idle_hrs) as idle_hrs_var,
        variance(technical_downtime_hrs) as technical_downtime_hrs_var,
        variance(planned_maintenance_hrs) as planned_maintenance_hrs_var,
        variance(workflow_delay_events) as workflow_delay_events_var,
        variance(avg_delay_minutes) as avg_delay_minutes_var,
        variance(primary_procedure) as primary_procedure_var,
        variance(redundancy_available) as redundancy_available_var ,
        variance(total_cases_day_lab) as total_cases_day_lab_var
        from temp_ivf;

-- Missing Values

select
	count(*) as total_rows,
    sum( case when date is null then 1 else 0 end) as mising_date,
    sum( case when max_capacity_hrs is null then 1 else 0 end) as missing_max_capacity_hr,
    sum( Case when utilization_hrs is null then 1 else 0 end) as missing_utilization_hrs,
    sum( Case when idle_hrs is null then 1 else 0 end) as missing_idle_hrs,
    sum( Case when technical_downtime_hrs is null then 1 else 0 end) as missing_technical_downtime_hrs,
    sum( Case when planned_maintenance_hrs is null then 1 else 0 end) as missing_planned_maintenance_hrs,
    sum( Case when workflow_delay_events is null then 1 else 0 end) as missing_workflow_delay_events,
    sum( Case when avg_delay_minutes is null then 1 else 0 end) as missing_avg_delay_minutes,
    sum( Case when primary_procedure is null then 1 else 0 end) as missing_primary_procedure,
    sum( case when redundancy_available is null then 1 else 0 end) as missing_redundancy_available,
    sum( Case when total_cases_day_lab is null then 1 else 0 end) as missing_total_cases_day_lab
    from ivf;

select sum(case when idle_hrs = '' then 1 else 0 end) as null_idle from ivf;
    select * from ivf where `Date` = '23-06-2023' and equipment_type = 'incubator';
    
  # Discretization 
  
 ### Using avg function for bins helps to be it dynamic when new rows gets added instead of assigning constant high and low values ######
#### It also helps to see avg for each column in the table ###
 use project;
 select 
		max_capacity_hrs,
		case
			when max_capacity_hrs is null then 'Unkown'
            when max_capacity_hrs < ( select avg(max_capacity_hrs) from ivf_typecasted )
            then 'Low'
            else 'High'
		end as max_capacity_hrs_bins,

		 utilization_hrs,
		case 
			when utilization_hrs is null then 'Unkown'
			when  utilization_hrs < ( select avg(utilization_hrs) from ivf_typecasted )
            then 'Low'
            else 'High'
		end as  utilization_hrs_bins,
        
        idle_hrs,
		case 
			when idle_hrs is null then 'Unknown'
			when  idle_hrs < ( select avg(idle_hrs) from ivf_typecasted )
            then 'Low'
            else 'High'
		end as   idle_hrs_bins,

		technical_downtime_hrs,
		case
			when technical_downtime_hrs is null then 'Unkown'
			when technical_downtime_hrs < ( select avg(technical_downtime_hrs) from ivf_typecasted)
            then 'Low'
            else 'High'
		end as technical_downtime_hrs_bins,
        
         planned_maintenance_hrs,
		case
			when planned_maintenance_hrs is null then'Unknown'
            when planned_maintenance_hrs < ( select avg(planned_maintenance_hrs) from ivf_typecasted)
            then 'Low'
            else 'High'
		end as planned_maintenance_hrs_bins,
  
		 workflow_delay_events,
		case 
			when workflow_delay_events is null then 'Unknown'
            when workflow_delay_events < ( select avg(workflow_delay_events) from ivf_typecasted)
            then 'Low'
            else 'High'
		end as workflow_delay_events_bins,
        
         avg_delay_minutes,
        case 
			when avg_delay_minutes is null then 'Unknown'
            when avg_delay_minutes < ( select avg(avg_delay_minutes) from ivf_typecasted)
            then 'Low'
            else 'High'
		end as avg_delay_minutes_bins,
        
         total_cases_day_lab,
         case
			 when  total_cases_day_lab is null then 'Unknown'
             when  total_cases_day_lab < ( select avg( total_cases_day_lab) from ivf_typecasted )
             then 'Low'
             else 'High'
		 end as  total_cases_day_lab_bins
         
FROM ivf_typecasted;

desc ivf_typecasted;
    
# Encoding

	select *,
        case when redundancy_available = "False" then 0 else 1 end as redundancy_availablity
        from ivf_typecasted;
			
-- Transformation
Create table ivf_transformed 
select *, 
		
		case when idle_hrs is null or idle_hrs < 0 then null
        else log(idle_hrs + 1)	
        end as idle_hrs_log,
        
     
        case when technical_downtime_hrs is null or technical_downtime_hrs  < 0 then null
        else log(technical_downtime_hrs + 1) 
        end as technical_downtime_hrs_log,
        
        
        case when planned_maintenance_hrs is null or planned_maintenance_hrs < 0 then null
        else log(planned_maintenance_hrs + 1) 
        end as planned_maintenance_hrs_log,
        
      
        case when avg_delay_minutes is null or avg_delay_minutes < 0 then null
        else log(avg_delay_minutes + 1) 
        end as avg_delay_minutes_log,
        sqrt(workflow_delay_events) as workflow_delay_events_sqr
	from ivf_typecasted;

select * from ivf_transformed;
 
 ### Scaling ###
 
 desc ivf_typecasted;
 create table ivf_scaled as 
 select
		Date_casted,
        lab_id,
        equipment_type_casted,
        equipment_id,
        max_capacity_hrs,
        case
			when max_capacity_hrs is null then null
            when ( select max(max_capacity_hrs) from ivf_typecasted) = 
            (select min(max_capacity_hrs) from ivf_typecasted) then 0
            else ( max_capacity_hrs - ( select min(max_capacity_hrs) from ivf_typecasted)) 
        / 
        ( ( select max(max_capacity_hrs) from ivf_typecasted) - (select min(max_capacity_hrs) from ivf_typecasted) )
        end as max_capacity_hrs_scaled,
        utilization_hrs,
         case
			when utilization_hrs is null then null
            when ( select max(utilization_hrs) from ivf_typecasted) = 
            (select min(utilization_hrs) from ivf_typecasted) then 0
            else ( utilization_hrs - ( select min(utilization_hrs) from ivf_typecasted)) 
        / 
        ( ( select max(max_capacity_hrs) from ivf_typecasted) - (select min(max_capacity_hrs) from ivf_typecasted) )
        end as utilization_hrs_scaled,
        utilization_pct,
        case 
			when utilization_pct is null then null
            when ( select max(utilization_pct) from ivf_typecasted) = 
				 ( select min(utilization_pct) from ivf_typecasted) then 0
            else (utilization_pct - ( select min(utilization_pct) from ivf_typecasted))
					/
                   ( (select max(utilization_pct) from ivf_typecasted) - ( select min(utilization_pct) from ivf_typecasted) )
        end as utilization_pct_scaled,
        idle_hrs,
        case 
			when idle_hrs is null then null
            when ( select max(idle_hrs) from ivf_typecasted) = 
				 ( select min(idle_hrs) from ivf_typecasted) then 0
            else (idle_hrs - ( select min(idle_hrs) from ivf_typecasted))
					/
                   ( (select max(idle_hrs) from ivf_typecasted) - ( select min(idle_hrs) from ivf_typecasted) )
        end as idle_hrs_scaled,
        technical_downtime_hrs,
		  case 
			when technical_downtime_hrs is null then null
            when ( select max(technical_downtime_hrs) from ivf_typecasted) = ( select min(technical_downtime_hrs) from ivf_typecasted) then 0
            else (idle_hrs - ( select min(technical_downtime_hrs) from ivf_typecasted))
					/
                   ( (select max(technical_downtime_hrs) from ivf_typecasted) - ( select min(technical_downtime_hrs) from ivf_typecasted) )
        end as technical_downtime_hrs_scaled, 
        planned_maintenance_hrs,
         case 
			when planned_maintenance_hrs is null then null
            when ( select max(planned_maintenance_hrs) from ivf_typecasted) = ( select min(planned_maintenance_hrs) from ivf_typecasted) then 0
            else (idle_hrs - ( select min(planned_maintenance_hrs) from ivf_typecasted))
					/
                   ( (select max(planned_maintenance_hrs) from ivf_typecasted) - ( select min(planned_maintenance_hrs) from ivf_typecasted) )
        end as planned_maintenance_hrs_scaled,
        workflow_delay_events,
         case 
			when workflow_delay_events is null then null
            when ( select max(workflow_delay_events) from ivf_typecasted) = ( select min(workflow_delay_events) from ivf_typecasted) then 0
            else (idle_hrs - ( select min(workflow_delay_events) from ivf_typecasted))
					/
                   ( (select max(workflow_delay_events) from ivf_typecasted) - ( select min(workflow_delay_events) from ivf_typecasted) )
        end as workflow_delay_events_scaled,
        avg_delay_minutes,
         case 
			when avg_delay_minutes is null then null
            when ( select max(avg_delay_minutes) from ivf_typecasted) = ( select min(avg_delay_minutes) from ivf_typecasted) then 0
            else (idle_hrs - ( select min(avg_delay_minutes) from ivf_typecasted))
					/
                   ( (select max(avg_delay_minutes) from ivf_typecasted) - ( select min(avg_delay_minutes) from ivf_typecasted) )
        end as avg_delay_minutes_scaled,
        primary_procedure,
        redundancy_available,
        total_cases_day_lab
        from ivf_typecasted;   
        
select * from ivf_scaled;