/* open the database*/
 use InnovationEvents
 go

/* 1. Create a view (called vwEv3Attendees) that contains the first and last names of attendees who have registered for event number 3, the event name and the registration amount paid. Execute the SQL statements to create the view.*/
CREATE VIEW vwEv3Attendees AS
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Registration.RegFeeAmntPaid
FROM InnovationEvents.dbo.Attendee,InnovationEvents.dbo.Registration,InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Attendee.Attendee_ID = InnovationEvents.dbo.Registration.Attendee_ID
AND (InnovationEvents.dbo.Registration.Event_ID = InnovationEvents.dbo.Event.Event_ID
AND InnovationEvents.dbo.Event.Event_ID=3);


/* 2. Create a view (called vwNSWAttendees) that contains all attendee details for attendees whose address is in NSW. Execute the SQL statements to create the view.*/
CREATE VIEW vwNSWAttendees AS
SELECT *
FROM InnovationEvents.dbo.Attendee
WHERE InnovationEvents.dbo.Attendee.State = 'NSW';


/* 3. Create a stored procedure (called spSelect_vwEv3Attendees) to retrieve all records and columns from wvEv3Attendees. Execute the stored procedure.*/
CREATE PROCEDURE spSelect_vwEv3Attendees
AS
SELECT * FROM vwEv3Attendees
GO;

EXEC spSelect_vwEv3Attendees;

/* 4. Create a stored procedure (called spInsert_vwNSWAttendees) to insert a new record into vwNSWAttendees and the Registrations table, using parameters for all relevant data. Execute the stored procedure.*/
CREATE PROCEDURE spInsert_vwNSWAttendees
@Attendee_ID INT,
@First_Name NVARCHAR(30) ,
@Last_Name NVARCHAR(30) ,
@Title NVARCHAR(20) ,
@CompanyName NVARCHAR(50),
@StreetAddress NVARCHAR(50),
@Suburb NVARCHAR(40),
@State NVARCHAR(3),
@Country NVARCHAR(50),
@PostCode NVARCHAR(4),
@Phone NVARCHAR(10),
@Mobile NVARCHAR(10),
@Gender NVARCHAR(1),
@Event_ID INT ,
@Staff_ID INT,
@RegistrationDate DATE,
@RegFeeAmntPaid DECIMAL(6,2)
AS
BEGIN
INSERT INTO vwNSWAttendees(Attendee_ID,FirstName,LastName,Title,CompanyName,StreetAddress,Suburb,State,Country,PostCode,Phone,Mobile,Gender)VALUES
						(@Attendee_ID,@First_Name,@Last_Name,@Title,@CompanyName,@StreetAddress,@Suburb,@State,@Country,@PostCode,@Phone,@Mobile,@Gender)

INSERT INTO InnovationEvents.dbo.Registration(Attendee_ID,Event_ID,Staff_ID,RegistrationDate,RegFeeAmntPaid) VALUES
						(@Attendee_ID,@Event_ID,@Staff_ID,@RegistrationDate,@RegFeeAmntPaid)
END


EXEC spInsert_vwNSWAttendees  @Attendee_ID =100 ,
@First_Name ='Akanksha' ,
@Last_Name = 'Kalamkar' ,
@Title ='Mrs' ,
@CompanyName = 'Tafe',
@StreetAddress ='Kairawa',
@Suburb = 'South Hurstville',
@State =' NSW',
@Country = 'Australia',
@PostCode = '2221',
@Phone='5446464',
@Mobile = '83478932',
@Gender= 'F',
@Event_ID = '2' ,
@Staff_ID ='4',
@RegistrationDate = '12 july 2021',
@RegFeeAmntPaid = '60';


/* 5. Manipulate the Event table to add a new column that will track the number of attendees registered for each event. Name the new column AttendeeCount. Execute the statement to create the new column.*/
ALTER table InnovationEvents.dbo.Event
ADD AttendeeCount INT;


/* 6. Create a trigger on the Registration table that will update AttendeeCount on the Event table each time a new Registration occurs. The value of the AttendeeCount should be the number of registrations for the Event. Name the trigger tr_Registrations_AfterInsert.*/
CREATE TRIGGER tr_Registrations_AfterInsert
ON InnovationEvents.dbo.Registration
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
UPDATE InnovationEvents.dbo.Event
SET  AttendeeCount = (SELECT COUNT(InnovationEvents.dbo.Registration.Attendee_ID)
                          FROM   InnovationEvents.dbo.Registration
                          WHERE  InnovationEvents.dbo.Event.Event_ID = InnovationEvents.dbo.Registration.Event_ID)
END


/* 7. Create a trigger on the vwEv3Attendees view to delete records from Registration where attendees have not paid any registration amounts. Write the SQL statements to execute the trigger to delete the records.*/
CREATE TRIGGER tr_Registrations_AfterDelete
ON vwEv3Attendees
INSTEAD OF DELETE
AS
BEGIN
DELETE FROM vwEv3Attendees
WHERE RegFeeAmntPaid='0';
END


/* 8. Delete the view vwEv3Attendees from the database.*/
DROP VIEW vwEv3Attendees ;


/* 9. Delete the stored procedure spSelect_vwEv3Attendees from the database.*/
DROP PROCEDURE spSelect_vwEv3Attendees ;

/* 10. Update the Registration table and set the RegFeeAmntPaid to $50 for all registrations where the RegFeeAmntPaid is 0, using parameters for all relevant data. Execute the SQL statement.*/
UPDATE InnovationEvents.dbo.Registration
SET RegFeeAmntPaid = 50
WHERE RegFeeAmntPaid = 0;

/* 11. Manipulate the Registration table to add a check constraint ensuring that when new registrations are made, the minimum registration fee payable is $50. Execute the SQL statements to apply the check constraint.*/
ALTER TABLE InnovationEvents.dbo.Registration
ADD CONSTRAINT  CHECKAMT_CHK CHECK(RegFeeAmntPaid>=50);

/* 12. Manipulate the Attendee table to add a check constraint ensuring that all postcodes added to the table are exactly four digits (numeric) long. Execute the SQL statements to apply the check constraint.*/
ALTER TABLE InnovationEvents.dbo.Attendee
ADD CONSTRAINT CHECKPOSTCODE_CHK CHECK(LEN(PostCode)= 4);

