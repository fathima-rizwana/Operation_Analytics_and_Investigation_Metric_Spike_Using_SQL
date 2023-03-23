#User Engagement: 
SELECT week(occurred_at) as week_num,
       COUNT(DISTINCT user_id) AS weekly_active_users
FROM events1 
WHERE event_type = 'engagement'
  AND event_name = 'login'
GROUP BY 1
ORDER BY 1 ;


#User growth
select monthofyear,num_users,prev_month_users,
concat(round((num_users-prev_month_users)*100/prev_month_users,0),'%') growth_percent from
(select monthofyear,num_users,
lag(num_users,1,0) over (order by monthofyear) prev_month_users from
(select month(created_at) as monthofyear,
       count(*) as num_users
from users3
group by 1
order by 1) t)g;


#Email Engagement:
SELECT week(occurred_at) AS week_num,
       COUNT(CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS weekly_digest,
       COUNT(CASE WHEN action = 'sent_reengagement_email' THEN user_id ELSE NULL END) AS reengagement_emails,
       COUNT(CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS email_opens,
       COUNT(CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS email_clickthroughs
FROM email_events 
GROUP BY 1
ORDER BY 1;


#weekly Engagement
SELECT week(occurred_at) AS weeknum,
       COUNT(DISTINCT user_id) AS weekly_users
       FROM events1 
WHERE event_type = 'engagement'
AND event_name = 'login'
GROUP BY 1
ORDER BY 1 ; 


# Weekly retention 
select first_login,
sum( case when week_num = 0 then 1 else 0 end) as week_0, 
sum( case when week_num = 1 then 1 else 0 end) as week_1, 
sum( case when week_num = 2 then 1 else 0 end) as week_2, 
sum( case when week_num = 3 then 1 else 0 end) as week_3, 
sum( case when week_num = 4 then 1 else 0 end) as week_4, 
sum( case when week_num = 5 then 1 else 0 end) as week_5, 
sum( case when week_num = 6 then 1 else 0 end) as week_6, 
sum( case when week_num = 7 then 1 else 0 end) as week_7, 
sum( case when week_num = 8 then 1 else 0 end) as week_8, 
sum( case when week_num = 9 then 1 else 0 end) as week_9, 
sum( case when week_num = 10 then 1 else 0 end) as week_10, 
sum( case when week_num = 11 then 1 else 0 end) as week_11, 
sum( case when week_num = 12 then 1 else 0 end) as week_12, 
sum( case when week_num = 13 then 1 else 0 end) as week_13, 
sum( case when week_num = 14 then 1 else 0 end) as week_14, 
sum( case when week_num = 15 then 1 else 0 end) as week_15, 
sum( case when week_num = 16 then 1 else 0 end) as week_16, 
sum( case when week_num = 17 then 1 else 0 end) as week_17 from 
(select m.user_id,m.login_week,n.first_login as first_login, 
m.login_week-n.first_login as week_num from
(select user_id, week(occurred_at) as login_week from events1 where event_name='login' 
group by user_id,week(occurred_at)) m,
(select user_id, min(week(occurred_at)) as first_login from events1 where event_name='login'
group by user_id) n
where m.user_id=n.user_id) as with_week_num group by first_login order by first_login;



