CREATE DATABASE sql_course;

-- DROP DATABASE IF EXISTS sql_course;

 create table Job_postings_jan as
    select * from job_postings_fact 
    where job_posted_date>='2023-01-01' AND
          (job_posted_date<'2023-02-01');

Alter Table job_postings_jan
Rename to January_jobs;

select * from job_postings_jan;

create table febrauary_jobs as
 select * from job_postings_fact
 where EXTRACT(month from job_posted_date) = 2;

 create table March_jobs as
 select * from job_postings_fact
 where EXTRACT(month from job_posted_date) = 3;

 -- case expression 
 select 
       count(job_id) as count_job,
       
        case 
          when job_location='New York, NY' Then 'Local'
         when job_location='Anywhere' Then 'onsite'
         else 'Remote' 
         end as location_job
 from 
      job_postings_fact
      group by location_job
      order by count_job desc;

select /*round(avg(salary_year_avg),0)*/
       job_title_short as title,
       salary_year_avg,
      /* round(
        percentile_cont(0.5) 
        within group (order by salary_year_avg):: numeric,0) as median_salary,*/
       -- count(job_id),
        case
        when salary_year_avg>'93876' then 'High payed'
        when salary_year_avg>'90000' and salary_year_avg<'93876' then 'Median payed'
        else 'Less Payed'
        end as Salary_rates
       
from job_postings_fact
where job_title_short='Data Analyst' and salary_year_avg is not null;

select job_title_short,
       Min(salary_year_avg) as min_salry,
       Max(salary_year_avg) as max_salry,
       Round(
        percentile_cont(0.5)
        within group(order by salary_year_avg)::numeric,2
       ) as Median_salary,
       count(job_id)
       from job_postings_fact
       group by job_title_short
       order by median_salary desc;

