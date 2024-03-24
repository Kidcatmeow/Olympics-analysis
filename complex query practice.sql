-- How many olympics games have been held?
-- Problem Statement: Write a SQL query to find the total no of Olympic Games held as per the dataset.

    select count(distinct games) as total_olympic_games
    from olympics_history;

-- List down all Olympics games held so far.
-- Problem Statement: Write a SQL query to list down all the Olympic Games held so far.

	select distinct oh.year,oh.season,oh.city 
    from olympics_history oh
	order by year;

-- Mention the total no of nations who participated in each olympics game?
-- Problem Statement: SQL query to fetch total no of countries participated in each olympic games.

    with all_countries as
        (select oh.games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by oh.games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;

-- Which Sports were just played only once in the olympics.
      with t1 as
          	(select distinct games, sport
          	from olympics_history),
          t2 as
          	(select sport, count(1) as no_of_games
          	from t1
          	group by sport)
      select t2.*, t1.games
      from t2
      join t1 on t1.sport = t2.sport
      where t2.no_of_games = 1
      order by t1.sport;
      
-- Fetch the total no of sports played in each olympic games.
      with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;

-- Identify the sport which was played in all summer olympics.
-- Problem Statement: SQL query to fetch the list of all sports which have been part of every olympics.
-- Step 1. find how many summer olympic games are there
-- Step 2. find how many times each sport were played in summer olympics games

with t1 as
 	(select count(distinct games) as total_summer_games
	 from OLYMPICS_HISTORY 
	 where season = 'Summer'),
	 t2 as 
	 (select distinct sport,games
	  from OLYMPICS_HISTORY 
	  where season = 'Summer'
	  order by games),
	  t3 as
	  (select sport, count(games) as no_of_games
	  from t2
	  group by sport)
	  select * 
	  from t3
	  join t1 on t1.total_summer_games = t3.no_of_games;
      

