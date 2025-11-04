--
-- Test 1: Join tables and sum data for output
--
IF OBJECT_ID('dbo.plays')        IS NOT NULL BEGIN DROP TABLE dbo.plays; END;
IF OBJECT_ID('dbo.reservations') IS NOT NULL BEGIN DROP TABLE dbo.reservations; END;

CREATE TABLE plays (
      id integer not null,
      title varchar(40) not null,
      writer varchar(40) not null,
      unique(id)
);

CREATE TABLE reservations (
      id integer not null,
      play_id integer not null,
      number_of_tickets integer not null,
      theater varchar(40) not null,
      unique(id)
);

INSERT INTO [dbo].[plays] ([id],[title],[writer])
     VALUES
           ('109' , 'Queens and Kings of Madagascar' , 'Paul Sat'),
           ('123' , 'Merlin'                         , 'Lee Roy'),
           ('142' , 'Key of the tea'                 , 'Max Rogers'),
           ('144' , 'ROMEance Comedy'                , 'Bohring Ashell'),
           ('145' , 'Nameless.'                      , 'Note Nul');

INSERT INTO [dbo].[reservations]
           ([id],[play_id],[number_of_tickets],[theater])
     VALUES
           (13 , 109     , 12                , 'Mc Rayleigh Theater'),
           (24 , 109     , 34                , 'Mc Rayleigh Theater'),
           (37 , 145     , 84                , 'Mc Rayleigh Theater'),
           (49 , 145     , 45                , 'Mc Rayleigh Theater'),
           (51 , 145     , 41                , 'Mc Rayleigh Theater'),
           (68 , 123     , 3                 , 'Mc Rayleigh Theater'),
           (83 , 142     , 46                , 'Mc Rayleigh Theater');

-- Query Answer
WITH summaryReservations AS
(
    SELECT play_id, SUM(number_of_tickets) AS NumberTickets
    FROM reservations
    GROUP BY play_id
)
SELECT p.id, p.title, COALESCE (sr.NumberTickets,0) AS reserved_tickets
FROM plays p
LEFT OUTER JOIN summaryReservations sr ON p.id = sr.play_id
ORDER BY reserved_tickets DESC, id;

--
-- Test 2: For trades find % difference from previous trade on account
--
IF OBJECT_ID('dbo.trades')        IS NOT NULL BEGIN DROP TABLE dbo.trades; END;

CREATE TABLE trades (
      id         integer not null,
      account    nvarchar(40) not null,
      benefit    nvarchar(1) not null,
      tradeDate  datetime2 not null,
      tradeValue decimal(19,4)
);

INSERT INTO [dbo].[trades] ([id],[account],[benefit],[tradeDate],[tradeValue])
     VALUES
           ( 101 , 'ABC1001' , 'A', '2020-01-01 00:11:00.000', 125.67),
           ( 104 , 'ABC1001' , 'A', '2020-01-02 00:12:00.000', 169.10),
           ( 109 , 'ABC1001' , 'A', '2020-01-03 00:13:00.000', 300.77),
           ( 110 , 'ABC1001' , 'A', '2020-01-04 00:13:00.000', 210.99);

-- Query Answer (only LAG() was needed in answer below, but other offset functions used as demo)

-- Offset Windows Functions
-- LAG()         - Look before current row
-- LEAD()        - Look after current row
-- FIRST_VALUE() - Get row from beginning of frame
-- LAST_VALUE()  - Get row from end of frame
WITH prevTrades AS
(
   SELECT account, benefit, tradeDate, tradeValue,
          LAG(tradeValue)         OVER (PARTITION BY account, benefit ORDER BY tradeDate) AS prevtradeValue,
          LEAD(tradeValue)        OVER (PARTITION BY account, benefit ORDER BY tradeDate) AS nexttradeValue,
          FIRST_VALUE(tradeValue) OVER (PARTITION BY account, benefit ORDER BY tradeDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS firstValue,
          LAST_VALUE(tradeValue)  OVER (PARTITION BY account, benefit ORDER BY tradeDate ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS lastValue
   FROM trades
)
SELECT account, benefit, tradeDate, tradeValue , CAST( ((tradeValue-prevtradeValue)*100/ prevtradeValue) as decimal(19,2)) as '% Diff'
FROM prevTrades;

--
-- Test 3: Find highest round of golf for each player
--
IF OBJECT_ID('dbo.golfplayers') IS NOT NULL BEGIN DROP TABLE dbo.golfplayers; END;
IF OBJECT_ID('dbo.golfrounds')  IS NOT NULL BEGIN DROP TABLE dbo.golfrounds; END;

CREATE TABLE golfplayers (
      id         integer not null,
      playername nvarchar(80) not null,
      unique(id)
);

CREATE TABLE golfrounds (
      id        integer not null,
      score     integer not null,
      rounddate datetime2 not null
);

INSERT INTO [dbo].[golfplayers] ([id],[playername])
     VALUES
           ( 1 , 'Tony Gyles'),
           ( 2 , 'John Smith'),
           ( 3 , 'Emily Jones'),
           ( 4 , 'Sid Snake');

INSERT INTO [dbo].[golfrounds] ([id],[score],[rounddate])
     VALUES
           ( 1 , 112, '2020-01-01 14:11:05'),
           ( 2 ,  80, '2020-01-01 15:22:22'),
           ( 3 ,  95, '2020-02-01 09:49:59'),
           ( 4 ,  43, '2020-03-01 11:36:03'),
           ( 2 ,  68, '2020-04-01 12:33:01'),
           ( 3 ,  77, '2020-05-01 13:49:27'),
           ( 1 , 125, '2020-06-01 16:07:38'),
           ( 2 ,  94, '2020-06-01 08:01:41'),
           ( 3 , 101, '2020-07-01 10:44:11'),
           ( 4 ,  49, '2020-08-01 13:32:49');

-- Query Answer
with AllRounds as
(
   select P.id, P.playername, R.score, R.rounddate
   from golfplayers as P inner join  golfrounds as R on p.id = R.id
),
TopRound as
(
    select AR.id, AR.playername, AR.score, AR.rounddate, ROW_NUMBER() OVER(PARTITION BY AR.id ORDER BY Ar.score DESC) as rownum
    from AllRounds as AR
)
select T.id, T.playername, T.score, T.rounddate from TopRound as T
where rownum = 1;
