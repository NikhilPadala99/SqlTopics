select count(*) from company_dim ;
select * from job_postings_fact orderselect * FROM skills_dim;select company_id,
      name
 from company_dim
 where company_id in (;
select company_id,
    job_no_degree_mention
     from job_postings_fact
     where job_no_degree_mention=true
     order by company_id
 ); limit 500;
 
select count(*)from skills_dim ;
select count(*)from skills_job_dim ;


SELECT 
   job_title_short as title,
   search_location as Country,
   job_posted_date at time zone 'UTC' at Time Zone 'EST' as DATE
   from job_postings_fact 
   limit 50;

   SELECT 
   job_title_short as title,
   search_location as Country,
   job_posted_date as date,
   EXTRACT (Month from job_posted_date) as month
   from job_postings_fact 
   limit 50;

   select 
    count(job_id) as job_count,
    EXTRACT(month from job_posted_date) as month
    from job_postings_fact
    where job_title_short='Data Analyst'
    group by month;

    select 
    avg(salary_year_avg) as avg_sal,
    avg(salary_hour_avg) as avg_hour,
    job_schedule_type ,
    count(job_schedule_type) as schedule_count
    from job_postings_fact
    where job_posted_date >'2023-06-1'             
    group by job_schedule_type 
    having avg(salary_year_avg) is not null and 
            avg(salary_hour_avg) is not null;
  
  select 
        EXTRACT(month from job_posted_date) as Month,
        count(job_id) as job_count 
       -- job_posted_date as Date_apply  
  from job_postings_fact
  
    where search_location='New York, United States' AND 
                   (job_posted_date at Time zone 'UTC' at Time Zone 'Est')>='2023-01-01'
    group by Month 
    order by job_count desc;

  select 
         job_title_short,
         count(job_id)  
         
  from job_postings_fact 
  where salary_year_avg is not null
   GROUP BY job_title_short;