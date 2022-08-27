/* 1. All data stored for attendees, in alphabetical order of last name, then first name. */
SELECT * FROM InnovationEvents.dbo.Attendee
ORDER BY InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Attendee.FirstName;

/* 2. The event name and event fee for all events that cost more than $200.*/
SELECT InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Event.EventFee
FROM InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Event.EventFee >200;

/* 3. Registrations that were created after 01 August 2018 and before 31 August 2018, and where the fees were at least $300 or less than $100.*/
SELECT InnovationEvents.dbo.Registration.RegistrationDate,InnovationEvents.dbo.Registration.RegFeeAmntPaid
FROM InnovationEvents.dbo.Registration
WHERE InnovationEvents.dbo.Registration.RegistrationDate BETWEEN '01 August 2018' AND '31 August 2018'
AND ((InnovationEvents.DBO.Registration.RegFeeAmntPaid >=300) OR (InnovationEvents.DBO.Registration.RegFeeAmntPaid < 100));

/* 4. The first and last name for attendees who have a company listed.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName
FROM InnovationEvents.dbo.Attendee
WHERE InnovationEvents.dbo.Attendee.CompanyName IS NOT NULL;

/* 5. The first name of attendees who have a first name starting with ‘A’.*/
SELECT InnovationEvents.dbo.Attendee.FirstName
FROM InnovationEvents.dbo.Attendee
WHERE InnovationEvents.dbo.Attendee.FirstName LIKE 'A%';

/* 6. The event name of each event that has a start date after 1st December 2019. Do not list any duplicate names.*/
SELECT DISTINCT InnovationEvents.dbo.Event.EventName
FROM InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Event.StartDate > '01 December 2019';

/* 7. The first and last name for all attendees who do not have a title listed.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName
FROM InnovationEvents.dbo.Attendee
WHERE InnovationEvents.dbo.Attendee.Title IS NULL;


/* 8. The first name, last name and suburb of attendees who live in Richmond, Picton or Kellyville.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Attendee.Suburb
FROM InnovationEvents.dbo.Attendee
WHERE InnovationEvents.dbo.Attendee.Suburb IN('Richmond','Picton','Kellyville');

/* 9. All data for attendees who have the title of ‘Ms’ or a gender of ‘F’.*/
SELECT * FROM InnovationEvents.dbo.Attendee
WHERE (InnovationEvents.dbo.Attendee.Title ='Ms') OR (InnovationEvents.dbo.Attendee.Gender='F');
