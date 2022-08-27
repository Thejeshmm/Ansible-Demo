
/* 1. Restrict the rows to the first and last names of attendees, and the total registration amount paid, for registered attendees who have paid total registration amounts of more than $300, sorted in descending order by total registration amount.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Registration.RegFeeAmntPaid
FROM InnovationEvents.dbo.Attendee
INNER JOIN InnovationEvents.dbo.Registration
ON InnovationEvents.dbo.Attendee.Attendee_ID=InnovationEvents.dbo.Registration.Attendee_ID
AND InnovationEvents.dbo.Registration.RegFeeAmntPaid >300
ORDER BY InnovationEvents.dbo.Registration.RegFeeAmntPaid DESC;

/* 2. Restrict the rows to the number of registrations from each state and the average registration amount paid per state.*/
SELECT COUNT(InnovationEvents.dbo.Registration.RegistrationDate) AS NUMBEROFREGISTRATION,AVG(InnovationEvents.dbo.Registration.RegFeeAmntPaid) AS AVGREGAMT
FROM InnovationEvents.dbo.Attendee
RIGHT OUTER JOIN InnovationEvents.dbo.Registration
ON InnovationEvents.dbo.Attendee.Attendee_ID=InnovationEvents.dbo.Registration.Attendee_ID
GROUP BY InnovationEvents.dbo.Attendee.State;

/* 3. The first name, last name and state of all attendees, and registration date, regardless of whether the attendee has registered or not, for attendees whose address is not in NSW.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Attendee.State,InnovationEvents.dbo.Registration.RegistrationDate
FROM (InnovationEvents.dbo.Attendee 
LEFT OUTER JOIN InnovationEvents.dbo.Registration
ON InnovationEvents.dbo.Attendee.Attendee_ID=InnovationEvents.dbo.Registration.Attendee_ID)
WHERE InnovationEvents.dbo.Attendee.State !='NSW';

/* 4. Attendee first name, last name, mobile number, registration date, registration paid, event name and event fee for all attendees who have an event registration.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Attendee.Mobile,InnovationEvents.dbo.Registration.RegistrationDate,InnovationEvents.dbo.Registration.RegFeeAmntPaid,
InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Event.EventFee
FROM (InnovationEvents.dbo.Registration
INNER JOIN InnovationEvents.dbo.Attendee ON InnovationEvents.dbo.Registration.Attendee_ID=InnovationEvents.dbo.Attendee.Attendee_ID)
INNER JOIN InnovationEvents.dbo.Event ON InnovationEvents.dbo.Registration.Event_ID= InnovationEvents.dbo.Event.Event_ID;


/* 5. Names and suburbs for all records from the Attendee and Staff tables.*/
SELECT InnovationEvents.dbo.Attendee.FirstName,InnovationEvents.dbo.Attendee.LastName,InnovationEvents.dbo.Attendee.Suburb
FROM InnovationEvents.dbo.Attendee
UNION
SELECT InnovationEvents.dbo.Staff.FirstName,InnovationEvents.dbo.Staff.LastName,InnovationEvents.dbo.Staff.Suburb
FROM InnovationEvents.dbo.Staff;
