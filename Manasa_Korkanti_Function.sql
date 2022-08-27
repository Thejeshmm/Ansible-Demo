
/* 1. The Attendee_ID, Event_ID, registration date and a calculated field called FinalRegDate, which is three weeks after the RegistrationDate.*/
SELECT InnovationEvents.dbo.Registration.Attendee_ID,InnovationEvents.dbo.Registration.Event_ID,InnovationEvents.dbo.Registration.RegistrationDate,DATEADD(WEEK,3,InnovationEvents.dbo.Registration.RegistrationDate)AS FinalRegDate
FROM InnovationEvents.dbo.Registration;

/* 2. The first name of each attendee in lower case and the last name in upper case for attendees whose postcode is 3000 or more.*/
SELECT LOWER(InnovationEvents.dbo.Attendee.FirstName) AS FIRSTNAME,UPPER(InnovationEvents.dbo.Attendee.LastName) AS LASTNAME
FROM InnovationEvents.dbo.Attendee
WHERE InnovationEvents.dbo.Attendee.PostCode >=3000;

/* 3. Event_ID and event name of all unconfirmed events; append the word ‘cancelled’ to the end of the listing of the event name.*/
SELECT InnovationEvents.dbo.Event.Event_ID,CONCAT(InnovationEvents.dbo.Event.EventName,' cancelled') AS EVENTNAME
FROM InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Event.Confirmed=0;

/* 4. Event Id, event name and a calculated field called EqualInstalmentAmount rounded to two decimal places, indicating the instalment amount for the event fee to be paid in four equal instalments.*/
SELECT InnovationEvents.dbo.Event.Event_ID,InnovationEvents.dbo.Event.EventName,CAST(InnovationEvents.dbo.Event.EventFee/4 AS DECIMAL(10,2)) AS EqualInstalmentAmount 
FROM InnovationEvents.dbo.Event;

/* 5. Event name, location and the number of days that each event runs for. */
SELECT InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Event.Location,DATEDIFF(DAY,InnovationEvents.dbo.Event.StartDate,InnovationEvents.dbo.Event.EndDate)AS NUMBEROFDAYS
FROM  InnovationEvents.dbo.Event;

/* 6.	List the attendee’s First and Last names, the event name, the Registration fee amount paid, and a derived field listing a calculated discount of 12% of the Registration Fee Paid. */
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Registration.RegFeeAmntPaid,(0.12*InnovationEvents.dbo.Registration.RegFeeAmntPaid)AS DISCOUNT
FROM InnovationEvents.dbo.Attendee,InnovationEvents.dbo.Registration,InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Attendee.Attendee_ID=InnovationEvents.dbo.Registration.Attendee_ID
AND InnovationEvents.dbo.Event.Event_ID=InnovationEvents.dbo.Registration.Event_ID;