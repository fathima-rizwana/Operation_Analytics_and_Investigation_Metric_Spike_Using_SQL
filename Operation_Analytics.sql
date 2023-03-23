use case_study_2;

CREATE TABLE job_data 
(
    ds	VARCHAR(512),
    job_id	VARCHAR(512),
    actor_id	VARCHAR(512),
    event	VARCHAR(512),
    language	VARCHAR(512),
    time_spent	VARCHAR(512),
    org	VARCHAR(512)
);

INSERT INTO job_data (ds, job_id, actor_id, event, language, time_spent, org) VALUES
	('2020-11-30', '21', '1001', 'skip', 'English', '15', 'A'),
	('2020-11-30', '22', '1006', 'transfer', 'Arabic', '25', 'B'),
	('2020-11-29', '23', '1003', 'decision', 'Persian', '20', 'C'),
	('2020-11-28', '23', '1005', 'transfer', 'Persian', '22', 'D'),
	('2020-11-28', '25', '1002', 'decision', 'Hindi', '11', 'B'),
	('2020-11-27', '11', '1007', 'decision', 'French', '104', 'D'),
	('2020-11-26', '23', '1004', 'skip', 'Persian', '56', 'A'),
	('2020-11-25', '20', '1003', 'transfer', 'Italian', '45', 'C');
    
 select * from job_data;   
 
 select ds,sum(time_spent)/3600 from job_data group by ds ;
 
 
#Calculate the number of jobs reviewed per hour per day for November 2020?
select ds,count(job_id) as jobs_per_day, sum(time_spent)/3600 as hours_spent,
round(count(job_id)/(sum(time_spent)/3600),2) as no_jobs_hr_day
from job_data  
where ds >='2020-11-01'  and ds <='2020-11-30'  
group by ds ;
 
# Calculate the percentage share of each language in the last 30 days?
select language, count(language)*100/(Select count(*) from job_data) as lang_perc 
from job_data group by language;


#Let’s say you see some duplicate rows in the data. How will you display duplicates from the table?
With CTE as (Select *,row_number()

Over (partition by job_id order by job_id) as num

From job_data)Select * from CTE where num >1 order by job_id;

#Throughput
with temp_table as(select ds ,count(job_id) as job_nums,sum(time_spent) as total_time 
from job_data 
group by ds)
select ds , 
sum(job_nums) over (order by ds rows between 6 preceding and current 
row)/sum(total_time) as 7day_rolling_average 
from temp_table;

