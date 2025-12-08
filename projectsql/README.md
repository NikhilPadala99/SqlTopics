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

### 2.what are the top  skills required for top-paying jobs?

This query uses a CTE (Common Table Expression) called top_paying_job to first collect the top 10 highest-paying remote Data Analyst jobs. After that, it uses joins to combine data from multiple tables: a LEFT JOIN to attach company names to each job, and then INNER JOINS to link those top jobs with the skills tables (skills_job_dim and skills_dim) so we can see the list of skills required for each job. In short, the CTE helps filter and organize the main job data, and the joins help bring in all the related company and skill information.

```sql
with top_paying_job as (
select 
    job_id,
    job_title,
    salary_year_avg,
    job_country,
  
    company_dim.name as company_name
from 
    job_postings_fact 
left join company_dim on job_postings_fact.company_id=company_dim.company_id
where job_title_short='Data Analyst' and
        job_work_from_home=true  AND
        salary_year_avg IS NOT NULl
order by 
        salary_year_avg desc
limit 10
)
select 
       top_paying_job.*,
       skills_dim.skills

from top_paying_job
inner join  skills_job_dim on skills_job_dim.job_id=top_paying_job.job_id
inner join  skills_dim on skills_dim.skill_id=skills_job_dim.skill_id 
order by 
       salary_year_avg desc
       limit 10;
```

   🔍 Key Insights

  - **1. Shows highest-paying remote Data Analyst roles**

The querry gives the top 10 jobs with the highest yearly salary for remote Data Analysts and This gives the insight into which companies pay the most.

- **2. Shows skills required for those high-paying jobs**

Common skills typically found in high-paying Data Analyst roles include:

SQL

Python

Tableau / Power BI

Excel

Machine Learning basics

Cloud tools (AWS, GCP, Azure)

![Top Paying Job Skills](/assets/Image2_Skills_analyst.png)


This bar chart represents the required technical skill set for a top-paying Data Analytics leadership role. Each bar corresponds to a specific skill mentioned in the job posting, including SQL, Python, R, AWS, Azure, Databricks, Pandas, PySpark, Jupyter, and Excel.

This is mainly useful for Recruiters,Managers and Aspiring Data analysts

### 3.  Top Demanding Skills for Data Analyst and average salary for that skills?

The query identifies the top 10 most in-demand skills for Data Analyst roles by counting how many job postings require each skill and calculating the average salary associated with those jobs. First, the CTE (skill_count_tab) joins job postings with their listed skills, filters only Data Analyst positions with available salary data, then groups by skill to compute how frequently each skill appears and the average salary for that skill. In the main query,  join these results with the skills table to get the skill names and finally sort them in descending order of demand. Overall, the query tells  which skills are most commonly required and how well they are paid, helping to understand the most valuable skills in the Data Analyst job market.

```sql
with skill_count_tab as (
select 
    round(avg(salary_year_avg),2)as avg_sal_USD,
     skill_id ,
     count(*) as skill_count
   
from 
   skills_job_dim
Inner join job_postings_fact on job_postings_fact.job_id=skills_job_dim.job_id
where 
      job_title_short='Data Analyst' and
      salary_year_avg is not null
group by skill_id
)
select 
      
       --skill_count_tab.skill_id,
       skills,
       skill_count_tab.skill_count,
       skill_count_tab.avg_sal_USD
     
from 
    skills_dim 
Inner JOIN skill_count_tab on skill_count_tab.skill_id=skills_dim.skill_id
order by skill_count desc
limit 10;
```

   🔍 Key Insights

- **1. Shows the most in-demand skills**

Skills with the highest skill_count appear most frequently in Data Analyst job postings.
These are usually skills like SQL, Excel, Python, Tableau, Power BI, etc.
               
- **2. Shows which skills pay more**

The column avg_sal_USD tells you the average salary for jobs that require each skill.
This helps identify:

high-demand + high-salary skills (best skills to learn)

high-demand + low-salary skills (common but not high-paying)

low-demand + high-salary skills (specialized, niche skills)

- **3. Useful for career planning**

This Querry helps in choosing the career plan for Data Analyst aspires.It gives information of below : 

Which skills to focus on first (high demand)

Which skills increase salary (high avg salary)

Top 10 key skills for Data Analysts.

![Top skills for Data Analyst](/assets/Image3_Table.png)


This table shows the top 10 most in-demand skills for Data Analyst roles, along with their average annual salary in USD.
Demand is measured by the number of job postings that list each skill, while salary represents the average compensation for roles requiring that skill.

The table highlights that skills such as SQL and Excel dominate in demand, whereas Python, R, and Tableau command relatively higher salaries. This comparison helps identify skills that balance market demand and earning potential.


### **4. Overall Top Demanding skills with high average salary?**

This query identifies the most in-demand skills that also have a high average salary across all job postings. It first calculates the average yearly salary and number of job postings for each skill using a CTE (skill_count_tab). Only skills that appear in more than 200 job postings are included, ensuring the results focus on skills that are both common and relevant. The query then joins this data with the skills_dim table to display each skill’s name, its demand (skill_count), and its average salary. Finally, the results are sorted by highest average salary and the top 25 skills are returned.

```sql
with skill_count_tab as (
select 
    round(avg(salary_year_avg),2)as avg_sal_USD,
     skill_id ,
     count(*) as skill_count
   
from 
   skills_job_dim
Inner join job_postings_fact on job_postings_fact.job_id=skills_job_dim.job_id
where 
   
      salary_year_avg is not null
      
group by skill_id
having count(*)>200
)
select 
      
     
       skills,
       skill_count_tab.skill_count,
       skill_count_tab.avg_sal_USD
     
from 
    skills_dim 
Inner JOIN skill_count_tab on skill_count_tab.skill_id=skills_dim.skill_id
order by avg_sal_USD desc
limit 25;
```
   🔍 Key Insights

- The query highlights skills that are both popular and high-paying, because it requires at least 200 job postings.

- Skills that appear frequently tend to be core technical tools used across many data and tech roles.

- Sorting by average salary helps identify which skills offer the best pay potential in the market.

- This gives a clean view of the top-demand, top-salary skills, useful for deciding which skills to learn or highlight in a resume.

# What I Learned

**Data Agregation:** Got cozy with the group by and turned aggregate functions like count() and avg() into my data summarizing sidekicks.

**Analytical wizardy:** Leveled up my real-world-puzzle solving skills, turning questions into actionable, insightful SQL Querries


![Overall demanding skills](/assets/Image4_table.png)

This table summarizes the most in-demand technical skills across all roles, filtered to include only skills appearing in more than 200 job postings. It compares market demand (job count) with average annual salary, helping identify skills that offer both strong earning potential and widespread demand.

# Conclusion

### Insights:

**1.what are the top paying data analyst jobs:**
  This analysis identifies the highest-paying remote Data Analyst jobs by filtering job postings with valid salary data and ordering them by yearly average salary. The result highlights the top companies offering fully remote roles with strong compensation.

  **2. Skills required for top paying jobs**
This query uses a CTE (Common Table Expression) called top_paying_job to first collect the top 10 highest-paying remote Data Analyst jobs. After that, it uses joins to combine data from multiple tables: a LEFT JOIN to attach company names to each job, and then INNER JOINS to link those top jobs with the skills tables (skills_job_dim and skills_dim) so we can see the list of skills required for each job. In short, the CTE helps filter and organize the main job data, and the joins help bring in all the related company and skill information.

**3.Top Demanding Skills for Data Analyst ?**
The query identifies the top 10 most in-demand skills for Data Analyst roles by counting how many job postings require each skill and calculating the average salary associated with those jobs. First, the CTE (skill_count_tab) joins job postings with their listed skills, filters only Data Analyst positions with available salary data, then groups by skill to compute how frequently each skill appears and the average salary for that skill. In the main query,  join these results with the skills table to get the skill names and finally sort them in descending order of demand. Overall, the query tells  which skills are most commonly required and how well they are paid, helping to understand the most valuable skills in the Data Analyst job market.

**4. Top Demanding skills with high avrage Salaries:**
This query identifies the most in-demand skills that also have a high average salary across all job postings. It first calculates the average yearly salary and number of job postings for each skill using a CTE (skill_count_tab). Only skills that appear in more than 200 job postings are included, ensuring the results focus on skills that are both common and relevant. The query then joins this data with the skills_dim table to display each skill’s name, its demand (skill_count), and its average salary. Finally, the results are sorted by highest average salary and the top 25 skills are returned.

### Closing Thoughts

 This project enhanced my SQL skills and provided valuable insights into the data analyst job market.The findings from the analysis serve as a guide to priortizing skill development and job search efforts.Aspiring Data analyst can better position themselves in a competetive job market by focussing on high demand skills, high-salary skills.This exploration highlights the importance of continuous learning and adaption to emerging trends in the field og data analystics.