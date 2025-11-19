# Introduction
 Dive into Data job market ! focusing on Data Analyst roles,this project explores top paying jobs,in demand skills , and where the high demand meets high paying in Data analytics.
  
  SQl Querries? check them out here : [projectsql folder](/projectsql/)
# Background
   Driven by the quest to navigate the Data analyst job more effectived, this project idea was born from a desire to pinpoint top-paid and in-demand skills, Streaming other work to find otional jobs. 
   
   Data was taken from from csv files. checkout how Data was loaded from csv to vscode through [sql_load](/sql_load/).

   ### The Questions I want to answer through my SQL querries were

   1.what are the top paying data analyst jobs?

   2.what are the  skills required for top paying  jobs?

   3.What skills are in demand for data analyst job?

   4.What are the in demand skills with average salaries?

# Tools I Used
   For my deep dive into the data analyst job market, I harnessed the power of several key tools

  - **SQL :** The backbone of my analysis,aloowing me to querry the database and unearth critical insights. 
  - **PostgreSQL :** The choosen Database Management system,ideal for handling the job posting data.
  - **Visual-Studio :** My go-to for Dtabase Management and execute Querries through Sql extensions.
  - **Git&GitHub :** Essential for version control and sharing my SQL scripts and analysis,ensuring collabration and project tracking.

  # The Analysis
  Each Querry of This project aimed at investigating specific aspects of the Data analyst job market.
  Here's how i approached each question.

  ###   1.what are the top paying data analyst jobs?

  This analysis identifies the highest-paying remote Data Analyst jobs by filtering job postings with valid salary data and ordering them by yearly average salary. The result highlights the top companies offering fully remote roles with strong compensation.

```sql
  select 
     job_id,
     job_title,
     salary_year_avg,
     job_country,
     job_location,
     job_schedule_type,
     job_posted_date as Date,
     company_dim.name as company_name
   from 
       job_postings_fact 
   left join company_dim on job_postings_fact.company_id=company_dim.company_id
   where job_title_short='Data Analyst' and
         job_work_from_home=true  AND
         salary_year_avg IS NOT NULl
   order by 
          salary_year_avg desc
   limit 
        10;
   
   ```

   🔍 Key Insights

- Focuses only on Data Analyst job roles.
- Includes jobs that are fully remote (Work From Home = TRUE).
- Filters out entries without salary information to ensure accuracy.
- Ranks positions by highest yearly average salary.
- Provides company names, schedule type, and posting dates for context.

Here's some analysis breakdown of 2023 jobs 

-  **Mantys is a clear outlier:**

  Mantys offers ₹650K USD (highest by far).
This is almost double the second-highest salary.
This suggests the role is very senior or highly specialized.

-  **Salaries are consistently high :**

Most salaries are between $184K – $336K
This shows remote data roles pay extremely well especially in U.S.

-  **Big U.S. tech companies dominate:**

Companies like Meta, Pinterest, SmartAsset, and Motional appear in the top list.
These companies typically offer:

High compensation

Remote flexibility

Strong data-driven work culture

- **Many roles are leadership or senior-level:**

Examples:

Director of Analytics

Associate Director – Data Insights

Principal Data Analyst


![Top Paying Roles](/assets/job_salary_blue_gradient_sorted.png)

- Th above chart is taken by using chatgpt.
This chart shows different data-related job titles arranged from highest to lowest salary. Dark blue bars represent higher salaries, and lighter blue bars show lower salaries. It gives a quick visual idea of which roles pay more and which pay less.