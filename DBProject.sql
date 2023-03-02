--create database project;

use project;

--drop database project

-- basic structure of database (2.1)
go
create procedure createAllTables
as
create table systemUser(
	username varchar(20)  primary key ,
	user_password varchar(20)
);

create table fan(
	nationalID varchar(20) primary key,
	fan_name varchar(20),
	birth_date date,
	fan_address varchar(20),
	phone_no int,
	fan_status bit,
	username varchar(20)
	foreign key (username) references systemUser on delete cascade on update cascade
);
create table stadium(
	id int primary key identity,
	stadium_name varchar(20),
	stadium_location varchar(20),
	capacity int,
	stadium_status bit
);

create table stadium_manager(
	id int primary key identity,
	manager_name varchar(20),
	stadium_id int foreign key references stadium(id) on delete cascade on update cascade,
	username varchar(20) foreign key references systemUser(username) on delete cascade on update cascade

);
create table club(
	club_id int primary key identity,
	club_name varchar(20),
	club_location varchar(20)
);
create table club_representative(
	 id int primary key identity,
	 representative_name varchar(20),
	 club_id int foreign key references club(club_id) on delete cascade on update cascade,
	 username varchar(20) foreign key references systemUser(username) on delete cascade on update cascade
);


create table sports_association_manager(
	id int primary key identity,
	asc_managaer_name varchar(20),
	username varchar(20) foreign key references systemUser(username) on delete cascade on update cascade
);

create table system_admin(
	id int primary key identity,
	admin_name varchar(20),
	username varchar(20) foreign key references systemUser(username) on delete cascade on update cascade
);

create table match(
	match_id int primary key identity,
	start_time datetime,
	end_time datetime,
	host_club_id int foreign key references club(club_id) on delete cascade on update cascade,
	guest_club_id int foreign key references club(club_id),
	stadium_id int foreign key references stadium(id) on delete cascade on update cascade
);

create table ticket(
	id int primary key identity,
	ticket_status bit,
	match_id int foreign key references match(match_id) on delete cascade on update cascade
);

create table ticket_buying_transactions(
	fan_national_id varchar(20) foreign key references fan(nationalID) on delete cascade on update cascade,
	ticket_id int foreign key references ticket(id)  on delete cascade on update cascade
	primary key(fan_national_id,ticket_id)
);

create table host_request(
	id int primary key identity,
	representative_id int foreign key references club_representative(id) ,
	manager_id int foreign key references stadium_manager(id) on delete cascade on update cascade,
	match_id int foreign key references match(match_id) ,
	host_request_status varchar(20) default 'unhandled'
);


go 
create procedure dropAllTables
as
drop table host_request;
drop table stadium_manager;
drop table club_representative;
drop table sports_association_manager;
drop table ticket_buying_transactions;
drop table ticket;
drop table match;
drop table stadium;
drop table club;
drop table system_admin;
drop table fan;
drop table systemUser;

go
Create Procedure clearAllTables AS
    delete From system_admin;
    delete From sports_association_manager;
	delete from ticket_buying_transactions;
    delete From ticket;
    delete From fan;
    delete From match;
    delete From host_request;
    delete From stadium_manager;
    delete From stadium;
    delete From club_representative;
    delete From club;
    delete From systemUser;


go 
create proc dropAllProceduresFunctionsViews
as
drop proc createAllTables;
drop proc dropAllTables;
drop proc clearAllTables;
drop proc addAssociationManager;
drop proc addNewMatch;
drop proc deleteMatch;
drop proc deleteMatchesOnStadium;
drop proc addClub;
drop proc addTicket;
drop proc deleteClub;
drop proc addStadium;
drop proc deleteStadium;
drop proc blockFan;
drop proc unblockFan;
drop proc addRepresentative;
drop proc addHostRequest;
drop proc addStadiumManager;
drop proc acceptRequest;
drop proc rejectRequest;
drop proc addFan;
drop proc purchaseTicket;
drop proc updateMatchHost;
drop function viewAvailableStadiumsOn;
drop function allUnassignedMatches;
drop function allPendingRequests;
drop function upcomingMatchesOfClub;
drop function availableMatchesToAttend;
drop function clubsNeverPlayed;
drop function matchWithHighestAttendance;
drop function matchesRankedByAttendance;
drop function requestsFromClub;
drop view allAssocManagers;
drop view allClubRepresentatives;
drop view allStadiumManagers;
drop view allFans;
drop view allMatches;
drop view allTickets;
drop view allCLubs;
drop view allStadiums;
drop view allRequests;
drop view clubsWithNoMatches;
drop view matchesPerTeam;
drop view clubsNeverMatched;

Select * from systemUser
select * from club_representative

-- basic data retrieval (2.2)
go
create view allAssocManagers as
select a.username as username , s.user_password as user_password  , a.asc_managaer_name as asc_managaer_name
from sports_association_manager a INNER JOIN systemUser s 
on (a.username = s.username)


go 
create view allClubRepresentatives as 
select c.username as username , s.user_password as user_password  , c.representative_name as representative_name
from club_representative c INNER JOIN systemUser s
on (c.username = s.username)

go 
create view allStadiumManagers as 
select sm.username as username , s.user_password as user_password  , sm.manager_name as manager_name
from stadium_manager sm INNER JOIN systemUser s
on (sm.username = s.username)

go 
create view allFans as 
select f.username as username , s.user_password as user_password  , f.fan_name as fan_name , f.nationalID as national_id , f.birth_date as birth_date , f.fan_status as fan_status
from fan f INNER JOIN systemUser s
on (f.username = s.username)

go 
create view allMatches as
select c.club_name as host_club , c2.club_name as guest_club , m.start_time as start_time
from match m INNER JOIN club c2 on (m.guest_club_id = c2.club_id)
INNER JOIN club c on (m.host_club_id = c.club_id)
where c.club_id = m.host_club_id and c2.club_id = m.guest_club_id

go 
create view allUpcomingMatchesOfAllClubs as
select c.club_name as host_club , c2.club_name as guest_club , m.start_time as start_time, m.end_time as end_time
from match m INNER JOIN club c2 on (m.guest_club_id = c2.club_id)
INNER JOIN club c on (m.host_club_id = c.club_id)
where c.club_id = m.host_club_id and c2.club_id = m.guest_club_id and m.start_time>CURRENT_TIMESTAMP

go 
create view allPlayedMatchesOfAllClubs as
select c.club_name as host_club , c2.club_name as guest_club , m.start_time as start_time, m.end_time as end_time
from match m INNER JOIN club c2 on (m.guest_club_id = c2.club_id)
INNER JOIN club c on (m.host_club_id = c.club_id)
where c.club_id = m.host_club_id and c2.club_id = m.guest_club_id and m.start_time<CURRENT_TIMESTAMP


go
create view allTickets as 
select c1.club_name as host, c2.club_name as guest, s.stadium_name as stadium, m.start_time as start_time
from ticket t inner join match m on(t.match_id = m.match_id)
inner join club c1 on (m.host_club_id=c1.club_id)
inner join club c2 on (m.guest_club_id=c2.club_id)
inner join stadium s on (m.stadium_id = s.id)

go 
create view allCLubs as
select club_name as club, club_location as club_location
from club

go 
create view allStadiums as 
select stadium_name as stadium_name, stadium_location as stadium_location, capacity as capacity, stadium_status as stadium_status
from stadium

go 
create view allRequests as
select r.username as representative_username, m.username as manager_username, h.host_request_status as request_status 
from host_request h inner join stadium_manager m on (h.manager_id = m.id)
inner join club_representative r on (h.representative_id=r.id)


-- other requirements (2.3)

go
create proc addAssociationManager 
@name varchar(20),
@username varchar(20),
@password varchar(20)
as
if @username <> all (select username from systemUser)
begin
insert into systemUser values(@username,@password)
insert into sports_association_manager values(@name,@username)
end
else 
print('username already in use')

go
create proc addNewMatch
@hostName varchar(20),
@guestName varchar(20),
@start datetime,
@end datetime
as

declare @id1 int;
select @id1 = c.club_id
from club c
where c.club_name = @hostName

declare @id2 int;
select @id2 = c1.club_id
from club c1
where c1.club_name = @guestName

insert into match values(@start, @end, @id1, @id2,null)


go
create view clubsWithNoMatches as
select c.club_name
from club c 
where c.club_id <> all (select m.host_club_id from match m) AND c.club_id <> all (select m.guest_club_id from match m)


go
create procedure deleteMatch
@host varchar(20),
@guest varchar(20),
@start datetime,
@end datetime

as
declare @id1 int;
declare @id2 int;

select @id1 = c.club_id
from club c
where c.club_name = @host

select @id2 = c1.club_id
from club c1
where c1.club_name = @guest

delete from match where host_club_id=@id1 and guest_club_id=@id2 and start_time=@start and end_time=@end


go 
create procedure deleteMatchesOnStadium
@name varchar(20)
as
declare @id int;
select @id = s.id
from stadium s 
where s.stadium_name = @name
delete from match where stadium_id=@id and start_time>CURRENT_TIMESTAMP

go 
create procedure addClub
@name varchar(20), @location varchar(20)
as
insert into club values(@name,@location)

select * from club

go
create procedure addTicket
@host varchar(20),
@guest varchar(20),
@start datetime
as
declare @id int;
declare @c1ID int;
declare @c2ID int;

select @c1ID=club_id
from club
where club_name=@host
select @c2ID=club_id
from club
where club_name=@guest

select @id=m.match_id
from match m inner join club c on (m.host_club_id=c.club_id)
inner join club c2 on (m.guest_club_id=c2.club_id)
where c.club_id=@c1ID and c2.club_id=@c2ID and m.start_time=@start

insert into ticket values(1,@id)


go 
create proc deleteClub
@name varchar(20)
as
delete from club where club_name=@name

go
create procedure addStadium
@name varchar(20),
@location varchar(20),
@cap int
as
insert into stadium values(@name,@location,@cap,1)

go
create proc deleteStadium
@name varchar(20)
as
delete from stadium where stadium_name=@name

go
create proc blockFan
@id varchar(20)
as
update fan 
set	fan_status=0
where nationalID=@id

go
create proc unblockFan
@id varchar(20)
as
update fan 
set	fan_status=1
where nationalID=@id

go 
create proc addRepresentative
@name varchar(20),
@clubName varchar(20),
@username varchar(20),
@password varchar(20)
as
declare @id int;
select @id=c.club_id
from club c
where c.club_name=@clubName
if @username <> all (select username from systemUser)
begin
insert into systemUser values(@username,@password)
insert into club_representative values(@name,@id,@username)
end
else
print('username already in use')


go
CREATE FUNCTION viewAvailableStadiumsOn 
(@x datetime)
returns table
AS	
return(
select s1.stadium_name ,s1.stadium_location , s1.capacity
from stadium s1
where s1.id in (
select s.id
from stadium s 
where s.stadium_status=1
except
select m.stadium_id
from match m
where  m.start_time>=@x)
)



go 
create proc addHostRequest
@clubname varchar(20),
@stadiumname varchar(20),
@start datetime
as
declare @clubID int;
declare @id1 int;
select @id1 = cr.id,@clubID=c.club_id
from club_representative cr inner join club c on (cr.club_id=c.club_id)
where c.club_name=@clubname

declare @id2 int;
select @id2=sm.id
from stadium_manager sm inner join stadium s on(sm.stadium_id=s.id)
where s.stadium_name=@stadiumname

declare @id3 int;
select @id3=m.match_id
from match m
where m.start_time=@start and m.host_club_id=@clubID

if @id3 <> any(select match_id from match) 
insert into host_request values(@id1,@id2,@id3,default)

go 
create proc addHostRequest2
@repusername varchar(20),
@stadiumname varchar(20),
@start datetime
as
begin
declare @clubID int;
declare @id1 int;
select @id1 = cr.id,@clubID=c.club_id
from club_representative cr inner join club c on (cr.club_id=c.club_id)
where cr.username=@repusername

declare @id2 int;
select @id2=sm.id
from stadium_manager sm inner join stadium s on(sm.stadium_id=s.id)
where s.stadium_name=@stadiumname

declare @id3 int;
select @id3=m.match_id
from match m
where m.start_time=@start and m.host_club_id=@clubID

if @id3 <> any(select match_id from match) 
insert into host_request values(@id1,@id2,@id3,default)
end


go 
create function allUnassignedMatches
(@clubname varchar(20))
returns table
as
return(
select c2.club_name as club_name, m.start_time as start_time
from match m left outer join stadium s on (m.stadium_id=s.id)
inner join club c1 on (m.host_club_id=c1.club_id) inner join club c2 on (m.guest_club_id=c2.club_id)
where c1.club_name=@clubname and m.stadium_id is null
)

go
create proc addStadiumManager
@name varchar(20),
@stadium varchar(20),
@username varchar(20),
@pass varchar(20)
as

declare @id int;
select @id = s.id
from stadium s 
where s.stadium_name=@stadium

if @username <> any (select username from systemUser)
begin
insert into systemUser values(@username, @pass)
insert into stadium_manager values(@name,@id,@username)
end
else
print('username already in use')

select * from allPendingRequests ('karol123')

go
create function allPendingRequests
(@managerUsername varchar(20))
returns
@out Table 
(representative_name varchar(20),
club_name varchar(20),
start_time datetime
)
AS
begin

declare @managerID int;
select @managerID = m.id
from stadium_manager m
where m.username = @managerUsername

insert into @out
select representative_name=r.representative_name , club_name=g.club_name , start_time=m.start_time 
from host_request h inner join club_representative r on (h.representative_id = r.id)
inner join club g on (r.club_id = g.club_id)
inner join match m on (h.match_id = m.match_id)
where h.manager_id = @managerID and h.host_request_status='unhandled'

return
end


go
create proc acceptRequest
@stadiumManager_username varchar(20),
@hostClub varchar(20),
@guestClub varchar(20),
@start datetime
as

declare @managerID int;
declare @stadiumID int;

select @managerID=m.id, @stadiumID=m.stadium_id
from stadium_manager m 
where m.username=@stadiumManager_username

declare @hostID int;
declare @guestID int;

select @hostID=m.club_id
from club m
where m.club_name=@hostClub

select @guestID=m.club_id
from club m
where m.club_name=@guestClub

declare @matchID int;
select @matchID=m.match_id
from match m
where m.host_club_id=@hostID and m.guest_club_id=@guestID and m.start_time=@start

declare @repID int;
select @repID=c.id
from club_representative c
where c.club_id=@hostID

update host_request 
set host_request_status = 'accepted'
where representative_id = @repID and manager_id = @managerID and match_id = @matchID

update match
set stadium_id = @stadiumID
where match_id=@matchID



go
create proc rejectRequest
@stadiumManager_username varchar(20),
@hostClub varchar(20),
@guestClub varchar(20),
@start datetime
as

declare @managerID int;
select @managerID=m.id
from stadium_manager m 
where m.username=@stadiumManager_username

declare @hostID int;
declare @guestID int;

select @hostID=m.club_id
from club m
where m.club_name=@hostClub

select @guestID=m.club_id
from club m
where m.club_name=@guestClub

declare @matchID int;
select @matchID=m.match_id
from match m
where m.host_club_id=@hostClub and m.guest_club_id=@guestID

declare @repID int;
select @repID=c.id
from club_representative c
where c.club_id=@hostID

update host_request 
set host_request_status = 'rejected'
where representative_id = @repID and manager_id = @managerID and match_id = @matchID

update match
set stadium_id = null
where match_id=@matchID


go
create proc addFan
@name varchar(20),
@username varchar(20),
@password varchar(20),
@nationalID varchar(20),
@birthdate datetime,
@address varchar(20),
@phone int
as
if @username <> all (select a.username from systemUser a) and @nationalID <> all (select f.nationalID from fan f)
begin
insert into systemUser values(@username,@password);
insert into fan values(@nationalID,@name,@birthdate,@address,@phone,1,@username)
end
else
print('username or national ID already in use')


go
create function upcomingMatchesOfClub
(@club varchar(20))
returns
@out Table 
(
clubname varchar(20),
opposingclub varchar(20),
matchstart datetime,
stadiumName varchar(20)
)as
Begin
insert into @out
select clubname=c1.club_name , opposingclub = c2.club_name, matchstart=m.start_time, stadiumName=s.stadium_name
from match m inner join club c1 on(m.host_club_id=c1.club_id)
inner join club c2 on(m.guest_club_id=c2.club_id) inner join stadium s on(m.stadium_id=s.id)
where (c1.club_name=@club or c2.club_name=@club ) and m.start_time>=CURRENT_TIMESTAMP
return
end



go
create function upcomingMatchesOfClub2
(@clubrep varchar(20))
returns
@out Table 
(
clubname varchar(20),
opposingclub varchar(20),
matchstart datetime,
stadiumName varchar(20)
)as
Begin

declare @club varchar(20);
select @club=c.club_name
from club c inner join club_representative r on (c.club_id=r.club_id)
where r.username=@clubrep

insert into @out
select clubname=c1.club_name , opposingclub = c2.club_name, matchstart=m.start_time, stadiumName=s.stadium_name
from match m inner join club c1 on(m.host_club_id=c1.club_id)
inner join club c2 on(m.guest_club_id=c2.club_id) inner join stadium s on(m.stadium_id=s.id)
where (c1.club_name=@club or c2.club_name=@club ) and m.start_time>=CURRENT_TIMESTAMP
return
end




go
create function availableMatchesToAttend
(@date datetime)
returns @out table 
(
hostName varchar(20),
guestName varchar,
matchStart datetime,
stadiumName varchar(20)
)
as
begin
insert into @out
select hostName = c1.club_name, guestName = c2.club_name, matchStart=m.start_time, stadiumName = s.stadium_name
from match m inner join club c1 on (m.host_club_id=c1.club_id)
inner join club c2 on (m.guest_club_id=c2.club_id)
inner join stadium s on (m.stadium_id=s.id)
where m.start_time > @date
return
end





go 
create proc purchaseTicket
@fanID varchar(20),
@hostName varchar(20),
@guestName varchar(20),
@start datetime
as

declare @matchID int;
declare @fanStatus bit;
declare @c1ID int;
declare @c2ID int;

select @c1ID=x.club_id
from club x
where x.club_name=@hostName
select @c2ID=x.club_id
from club x
where x.club_name=@guestName

select @fanStatus=f.fan_status
from fan f 
where f.nationalID=@fanID

select @matchID=m.match_id
from match m 
where m.host_club_id=@c1ID and m.guest_club_id=@c2ID AND m.start_time=@start

declare @ticketID int;
declare @ticketStatus bit;

select @ticketID=t.id, @ticketStatus=t.ticket_status
from ticket t
where t.match_id=@matchID

if @ticketStatus=1 and @fanStatus=1 and @start>CURRENT_TIMESTAMP
begin
insert into ticket_buying_transactions values(@fanID,@ticketID)
update ticket 
set ticket_status=0
where id=@ticketID
end

go
create procedure updateMatchHost
@host varchar(20),
@guest varchar(20),
@start datetime
as
declare @matchID int;
declare @hostID int;
declare @guestID int;
select @matchID = m.match_id, @hostID=c1.club_id, @guestID=c2.club_id
from match m inner join club c1 on (m.host_club_id=c1.club_id)
inner join club c2 on (m.guest_club_id=c2.club_id)
where m.start_time=@start and c1.club_name=@host and c2.club_name=@guest

update match
set host_club_id = @guestID, guest_club_id=@hostID, stadium_id=null
where start_time=@start and host_club_id=@hostID and guest_club_id=@guestID

go 
create view matchesPerTeam
as
(select c.club_name--, count(m1.match_id) as number_of_matches_played
from club c inner join match m1 on (c.club_id=m1.host_club_id)
where m1.start_time<CURRENT_TIMESTAMP
group by c.club_name)
union
(select c1.club_name, count(m2.match_id) as number_of_matches_played
from club c1 inner join match m2 on (c1.club_id=m2.guest_club_id)
where m2.start_time<CURRENT_TIMESTAMP
group by c1.club_name)

go 
create view clubsNeverMatched
as
((select h.club_name as club, g.club_name as club2
from club h,club g 
where h.club_id<g.club_id and h.club_name<>g.club_name)  except 
(select c1.club_name as club, c2.club_name as club2
from match m inner join club c1 on (m.host_club_id=c1.club_id)
inner join club c2 on (m.guest_club_id=c2.club_id)
where c1.club_id <> c2.club_id 
))except
(
select c1.club_name as club, c2.club_name as club2
from match m inner join club c1 on (m.guest_club_id=c1.club_id)
inner join club c2 on (m.host_club_id=c2.club_id)
where c1.club_id <> c2.club_id 
)

go
create function clubsNeverPlayed
(@clubName varchar(20))
returns @out table
(clubName varchar(20))
as
begin

declare @clubID int;
select @clubID=club_id
from club
where club_name=@clubName

insert into @out

select clubName=h.club_name
from club h
where h.club_name<>all(
(
select c1.club_name
from match m inner join club c1 on (m.guest_club_id=c1.club_id)
where m.host_club_id=@clubID
) 
union
(
select c2.club_name
from match m inner join club c2 on (m.host_club_id=c2.club_id)
where m.guest_club_id=@clubID 
)
)
except
(select club_name
from club 
where club_id = @clubID)
return
end

go
create function matchWithHighestAttendance ()
returns @out table
(
host_club varchar(20),
guest_club varchar(20),
no_of_sold_tickets int
)
as
begin

insert into @out
select host_club=h.club_name ,guest_club = g.club_name, no_of_sold_ticket = count(tbt.ticket_id)
from ticket_buying_transactions tbt inner join ticket t on(tbt.ticket_id=t.id)
inner join match m on (t.match_id=m.match_id) inner join club h on (m.host_club_id=h.club_id)
inner join club g on(m.guest_club_id=g.club_id)
group by h.club_name,g.club_name

return
end

go 
create function matchesRankedByAttendance ()
returns @out table
(
host varchar(20),
guest varchar(20),
no_of_sold_ticket int
)
as
begin
insert into @out
select host_club=h.club_name,guest_club = g.club_name, no_of_sold_ticket=count(tbt.ticket_id) 
from ticket_buying_transactions tbt inner join ticket t on(tbt.ticket_id=t.id)
inner join match m on (t.match_id=m.match_id) inner join club h on (m.host_club_id=h.club_id)
inner join club g on(m.guest_club_id=g.club_id)
group by h.club_name,g.club_name
order by no_of_sold_ticket desc
return
end


go
create function requestsFromClub
(
@stadiumName varchar(20),
@clubName varchar(20)
)
returns @out table(
host_club varchar(20),
guest_club varchar(20)
)
as
begin

declare @managerID int;
declare @representativeID int;

select @managerID=m.id
from stadium s inner join stadium_manager m on(s.id=m.stadium_id)
where s.stadium_name=@stadiumName

select @representativeID=r.id
from club c inner join club_representative r on(c.club_id=r.club_id)
where c.club_name=@clubName

insert into @out
select host_club=c1.club_name, guest_club=c2.club_name
from host_request r inner join match m on(r.match_id=m.match_id)
inner join club c1 on(m.host_club_id=c1.club_id) inner join club c2 on
(m.guest_club_id=c2.club_id)
where r.representative_id=@representativeID and r.manager_id=@managerID and r.host_request_status='unhandled'

return
end


go 
create proc loginProcedure
@username varchar(20),
@password varchar(20),
@check bit OUTPUT
as
begin
if exists(
select s.username
from systemUser s inner join system_admin ad on (s.username=ad.username)
where ad.username=@username and @password=s.user_password)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end

go 
create proc loginProcedureSM
@username varchar(20),
@password varchar(20),
@check bit OUTPUT
as
begin
if exists(
select s.username
from systemUser s inner join sports_association_manager ad on (s.username=ad.username)
where ad.username=@username and @password=s.user_password)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end

--checks if username is already in database returns 1
go 
create proc checkUsername
@username varchar(20),
@check bit OUTPUT
as
begin
if exists(
select s.username
from systemUser s
where s.username=@username)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end




go
create proc checkIfClubHasRep
@clubname varchar(20),
@check bit OUTPUT
as
begin
if exists(
select c.club_name
from club c inner join club_representative r on c.club_id=r.club_id
where c.club_name=@clubname)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end

go
create proc checkIfStadHasMNG
@stadium varchar(20),
@check bit OUTPUT
as
begin
if exists(
select c.stadium_name
from stadium c inner join stadium_manager r on c.id=r.stadium_id
where c.stadium_name=@stadium)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end



go 
create proc checkIfClubInSystem
@clubname varchar(20),
@check bit OUTPUT
as
begin
if exists(
select c.club_name
from club c
where c.club_name=@clubname)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end


go 
create proc checkIfStadiumInSystem
@stadiumname varchar(20),
@check bit OUTPUT
as
begin
if exists(
select c.stadium_name
from stadium c
where c.stadium_name=@stadiumname)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end





go 
create proc usersLogin
@username varchar(20),
@password varchar(20),
@type int output,
@check bit OUTPUT
as
begin
if exists(
select username
from systemUser
where username=@username and user_password=@password)
BEGIN
   SET @check = 1 
   select @check

if exists(
select username
from system_admin
where username=@username)
Begin
	set @type=1
	select @type
end

if exists(
select username
from sports_association_manager
where username=@username)
Begin
	set @type=2
	select @type
end

if exists(
select username
from club_representative
where username=@username)
Begin
	set @type=3
	select @type
end

if exists(
select username
from stadium_manager
where username=@username)
Begin
	set @type=4
	select @type
end

if exists(
select username
from fan
where username=@username)
Begin
	set @type=5
	select @type
end

END

ELSE
BEGIN
   SET @check = 0 
   select @check
   set @type = 100
   select @type
END

end

declare @bit bit;
declare @type varchar(20);
exec usersLogin 'ahmed123', '1234', @type out,@bit out




declare @var bit;
exec checkUsername 'ahmed1232', @var out
select @var



go
insert into club values('zamalek','cairo')
insert into club values('ismaily','ismailia')

exec addNewMatch 'zamalek', 'ahly','2022/12/19 18:00:00', '2022/12/19 20:00:00'
select * from match
select * from club
select * from stadium
select * from allUpcomingMatchesOfAllClubs
select * from systemUser
select * from sports_association_manager


select * from club_representative
select * from upcomingMatchesOfClub2('marwan123')
select * from match
select * from club



select * from stadium
delete from host_request


go 
create proc checkifrequestisUNHANDLED
@stadUser varchar(20),
@host varchar(20),
@guest varchar(20),
@start datetime,
@check bit output
as
begin
if exists(
select r.id
from host_request r inner join match m on(r.match_id=m.match_id)
inner join club h on(m.host_club_id=h.club_id) inner join club g
on (m.guest_club_id=g.club_id) inner join stadium_manager sm on (r.manager_id=sm.id)
where h.club_name=@host and g.club_name=@guest and m.start_time=@start and sm.username=@stadUser and r.host_request_status='unhandled')
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end


go 
create proc checkifmatchcanbeAttended
@fanID varchar(20),
@host varchar(20),
@guest varchar(20),
@start datetime,
@check bit output
as
begin
if exists(
select *
from availableMatchesToAttend (@start)
) and exists(
select nationalID from fan where nationalID=@fanID and fan_status=1
) and exists(
select m.match_id
from match m inner join club h on m.host_club_id=h.club_id inner join club g on m.guest_club_id=g.club_id
where h.club_name=@host and g.club_name=@guest and m.start_time=start_time
)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end


go
create proc checkIfthereAreMatches
@start datetime,
@check bit output
as
begin
if exists(
select * from availableMatchesToAttend(@start)
)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end


go
create proc checkMatchinSystem
@host varchar(20),
@guest varchar(20),
@start datetime,
@check bit output
as
begin
if exists(
select * 
from match m inner join club h on m.host_club_id=h.club_id inner join club g on m.guest_club_id=g.club_id
where h.club_name=@host and g.club_name=@guest and m.start_time=@start
)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end

go
create proc checkRequestinSystem
@clubRep varchar(20),
@stadium varchar(20),
@start datetime,
@check bit output
as
begin
if exists(
select * 
from host_request r inner join match m on r.match_id=m.match_id
inner join club c on m.host_club_id=c.club_id inner join stadium s on m.stadium_id=s.id inner join
club_representative cr on c.club_id=cr.club_id
where s.stadium_name=@stadium and m.start_time=@start and cr.username=@clubRep

)
BEGIN
   SET @check = 1 
   select @check
END

ELSE
BEGIN
    SET @check = 0 
   select @check
END

end

