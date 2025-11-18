    /* Top 25 companies companies with highest job openings */
    with total_job_applications as(
    select 
        company_id,
        count(*) as total_job_openings
        
    from 
    job_postings_fact 
    group by company_id
    order by total_job_openings desc
    )
    select 
      --  total_job_applications.*,
       company_dim.name,
       total_job_applications.total_job_openings
       
    from
        company_dim
    left join total_job_applications on total_job_applications.company_id=company_dim.company_id
    order by total_job_openings desc
    limit 25;


