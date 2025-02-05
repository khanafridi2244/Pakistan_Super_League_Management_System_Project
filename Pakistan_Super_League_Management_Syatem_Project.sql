USE PSL;

create table match_t
(
matchID varchar (10) not null,
matchdate date,
result char (10),
primary key(matchID)
);
insert into match_t(matchID , matchdate , result) values('M1' , '2023-4-1' , 'win');
insert into match_t(matchID , matchdate , result) values('M2' , '2021-6-10' , 'lose');
insert into match_t(matchID , matchdate , result) values('M3' , '2016-2-3' , 'lose');
insert into match_t(matchID , matchdate , result) values('M4' , '2022-2-12' , 'win');

create table venue(
venueID varchar (10) not null,
venuename char (17),
country char (19),
primary key(venueID)
);
insert into venue(venueID , venuename , country) values('V1' , 'ghazzafi' , 'pakistan');
insert into venue(venueID , venuename , country) values('V2' , 'aliantia' , 'austrila');
insert into venue(venueID , venuename , country) values('V3' , 'hidarabad' , 'india');
insert into venue(venueID , venuename , country) values('V4' , 'ghazzafi' , 'pakistan');


create table support_staff(
staffID varchar (10) not null,
city char (15),
country char (17),
postal_code varchar(12),
primary key(staffID)
);
insert into support_staff(staffID , city , country , postal_code) values('S1' , 'peshawar' , 'pakistan' , '27399');
insert into support_staff(staffID , city , country , postal_code) values('S2' , 'sharja' , 'arab' , '00345');
insert into support_staff(staffID , city , country , postal_code) values('S3' , 'lahore' , 'pakistan' , '99744');
insert into support_staff(staffID , city , country , postal_code) values('S4' , 'mumbai' , 'india' , '88764');

create table team_owner(
ownerID varchar (10) not null,
ownername char (19),
city char (20),
country char (17),
primary key(ownerID)
);
insert into team_owner(ownerID , ownername , city , country) values('OW1' , 'AFRIDI' , 'PESHAWAR' , 'PAKISTAN');
insert into team_owner(ownerID , ownername , city , country) values('OW2' , 'KHAN' , 'ISLAMABAD' , 'PAKISTAN');
insert into team_owner(ownerID , ownername , city , country) values('OW3' , 'RAJA' , 'HADARABAD' , 'INDIA');
insert into team_owner(ownerID , ownername , city , country) values('OW4' , 'AFGHAN' , 'KABAL' , 'AFGHANISTAN');

create table team
(  teamID varchar(10) not null,
   teamname char(15),
   ownerID varchar(10) NOT NULL,
   primary key(teamID),
   constraint team_FK foreign key(ownerID) references team_owner(ownerID)
);
insert into team(teamID , teamname , ownerID) values('T1' , 'PAKISTAN' , 'OW1');
insert into team(teamID , teamname , ownerID) values('T2' , 'AUSTRILA' , 'OW2');
insert into team(teamID , teamname , ownerID) values('T3' , 'INDIA' , 'OW4');
insert into team(teamID , teamname , ownerID) values('T4' , 'UAE' , 'OW3');

create table played_at(
matchID varchar (10) not null,
venueID varchar (10) not null,
primary key(matchID , venueID),
constraint played_at_FK foreign key(matchID) references match_t(matchID),
constraint played_at_F foreign key(venueID) references venue(venueID)
);
insert into played_at(matchID , venueID) values('M1' , 'V4');
insert into played_at(matchID , venueID) values('M3' , 'V2');
insert into played_at(matchID , venueID) values('M4' , 'V1');
insert into played_at(matchID , venueID) values('M2' , 'V4');

create table player
(  playerID varchar(10) not null,
   roll char(15),
   city char(10),
   country char(20),
   postalcode int(8),
   teamID varchar(10) not null,
   primary key(playerID),
   constraint player_FK foreign key(teamID) references team(teamID)
);
insert into player(playerID , roll ,  city , country , postalcode , teamID) values('P1' , 'batsman' , 'peshawar' , 'pakistan' , '27399' , 'T1');
insert into player(playerID , roll ,  city , country , postalcode , teamID) values('P2' , 'all_rounder' , 'higake' , 'austrila' , '58754' , 'T2');
insert into player(playerID , roll ,  city , country , postalcode , teamID) values('P3' , 'keeper' , 'mumbai' , 'india' , '78955' , 'T3');
insert into player(playerID , roll ,  city , country , postalcode , teamID) values('P4' , 'bowler' , 'sharja' , 'UAE' , '5462' , 'T4');


create table individual_score
(  scoreID varchar(10) not null,
   strikerate int,
   runs int,
   catches int,
   playerID varchar(10) not null,
   primary key(scoreID),
   constraint individual_score_FK foreign key(playerID) references player(playerID)
);
insert into individual_score(scoreID , strikerate , runs , catches , playerID) values('S1' , '125' , '129023' , '12' , 'P1');
insert into individual_score(scoreID , strikerate , runs , catches , playerID) values('S2' , '98' , '1290' , '8' , 'P2');
insert into individual_score(scoreID , strikerate , runs , catches , playerID) values('S3' , '100' , '12090' , '45' , 'P3');
insert into individual_score(scoreID , strikerate , runs , catches , playerID) values('S4' , '45' , '200' , '10' , 'P4');

create table works_for(
staffID varchar (10) not null,
teamID varchar (10) not null,
constraint work_for_FK foreign key(staffID) references support_staff(staffID),
constraint work_for_F foreign key(teamID) references team(teamID)
);
insert into works_for(staffID , teamID) values('S2' , 'T4');
insert into works_for(staffID , teamID) values('S3' , 'T3');
insert into works_for(staffID , teamID) values('S1' , 'T2');
insert into works_for(staffID , teamID) values('S4' , 'T1');


create table team_plays_matches(
matchID varchar (12) not null,
teamID varchar (12) not null,
primary key(matchID , teamID),
constraint team_plays_matches_FK foreign key(matchID) references match_t(matchID),
constraint team_plays_matches_F foreign key(teamID) references team(teamID)
);
insert into team_plays_matches(matchID , teamID) values('M2' , 'T2');
insert into team_plays_matches(matchID , teamID) values('M1' , 'T4');
insert into team_plays_matches(matchID , teamID) values('M4' , 'T1');
insert into team_plays_matches(matchID , teamID) values('M3' , 'T3');


