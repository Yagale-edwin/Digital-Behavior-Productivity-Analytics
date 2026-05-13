create database burnout;
use burnout;
CREATE TABLE user_behaviors (
    User_ID VARCHAR(10),
    Gender varchar(10),
    Age INT,
    Occupation varchar(20),
    Study_hrs float,
    Sleep_Hours FLOAT,
    Screen_Time FLOAT,
    Break_Count float,
    Stress_Level VARCHAR(20),
    Mood VARCHAR(20),
    Productivity_Score INT,
    Burnout_Risk varchar(10)
);
select * from user_behaviors;
select count(*) as Total from user_behaviors;
select avg(Productivity_Score) As Average_Productivity_Score from user_behaviors;
select avg(Sleep_Hours) As Average_Sleep_Hours from user_behaviors;
select avg(Study_hrs) As Average_Study_hrs from user_behaviors;
select avg(Screen_Time) As Average_Screen_Time from user_behaviors;

update user_behaviors
set Sleep_Hours=6
where Sleep_Hours>16;

#productivity by sleep
select Sleep_Hours,avg(Productivity_Score)
from user_behaviors
group by Sleep_Hours
order by Sleep_Hours desc;

#productivity by stress
select Stress_Level,avg(Productivity_Score)
from user_behaviors
group by Stress_Level
order by avg(Productivity_Score) desc;

#productivity by screen time
select Screen_Time,avg(Productivity_Score)
from user_behaviors
group by Screen_Time
order by Screen_Time desc;

#top productive users
select User_ID,Productivity_Score from user_behaviors
order by Productivity_Score desc
limit 1;

#low productive users
select User_ID,Productivity_Score from user_behaviors
order by Productivity_Score asc
limit 1;

#Burnout_analysis
#burnout by sleep
select Burnout_Risk,avg(Sleep_Hours)
from user_behaviors
group by Burnout_Risk
order by avg(Sleep_Hours) desc;

#burnout by stress
select Burnout_Risk,count(Stress_Level)
from user_behaviors
group by Burnout_Risk
order by count(Stress_Level) desc;

#burnout by screen time
select Burnout_Risk,avg(Screen_Time)
from user_behaviors
group by Burnout_Risk
order by avg(Screen_Time) desc;

#high burnout users
select User_ID,Burnout_Risk from user_behaviors
where Burnout_Risk ="high";

#low burnout users
select User_ID,Burnout_Risk from user_behaviors
where Burnout_Risk ="low";

#User Segmentation Analysis
#1. Sleep Categories
select Sleep_Hours,count(User_ID)
from User_behaviors
group by Sleep_Hours
order by count(User_ID) desc;
#2. Screen Time Categories
select Screen_Time,count(User_ID)
from User_behaviors
group by Screen_Time
order by count(User_ID) desc;
#3.Productivity Categories
select Productivity_Score,count(User_ID)
from User_behaviors
group by Productivity_Score
order by count(User_ID) desc;
#4. Risk-Based Segmentation
select Burnout_Risk,count(User_ID)
from User_behaviors
group by Burnout_Risk
order by count(User_ID) desc;

#Pattern Analysis
#1. Sleep + Burnout + Productivity
select Sleep_Hours,Study_hrs,Screen_Time,Productivity_Score,Stress_Level,Burnout_Risk
from User_behaviors
where Sleep_Hours >6 and Study_hrs >5 and Screen_Time<5 ;
#who have better sleep,better study_hrs, and less screen_time has higher productivuty and less sterr and burnout
#Does higher study hrs burnout people more
select Study_hrs, Burnout_Risk from User_behaviors
where Study_hrs>7;
#2. Screen Time + Stress
select Screen_Time, Stress_Level from User_behaviors
where Screen_Time >6;
#User with higher Screen_time have higher stress level
#3. Stress + Productivity + Burnout
select Stress_Level,Productivity_Score,Burnout_Risk from User_behaviors
where Stress_Level="High";
#4. Top Productive Users’ Habits
select  Sleep_Hours,Study_hrs,Screen_Time,Productivity_Score from User_behaviors
where Productivity_Score>=8;
#5. High Burnout Users’ Habits
select  Sleep_Hours,Study_hrs,Screen_Time,Burnout_Risk from User_behaviors
where Burnout_Risk="High";

select Age,round(avg(Productivity_Score),2),round(avg(Study_hrs),2),round(avg(Screen_Time),2) from User_behaviors
group by Age
order by avg(Productivity_Score) asc;

select Burnout_Risk,Occupation,count(User_ID) from User_behaviors
where Burnout_Risk ="High"
group by Occupation
order by count(User_ID) desc;
#both Employee and Student have the more or less equal so behavior is matter for Burnout