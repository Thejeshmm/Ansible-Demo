/* 1.	The first name, last name and total registration fee sales amount of the staff member who has made the most sales for event registrations (limited to one row).*/
SELECT query1.*
FROM (SELECT b.FirstName,b.LastName, SUM(a.RegFeeAmntPaid) AS TOTAL_AMT
      FROM InnovationEvents.dbo.Registration a,InnovationEvents.dbo.Staff b
	  WHERE a.Staff_ID=b.Staff_ID
      GROUP BY b.LastName,b.FirstName
	  ) query1,

     (SELECT MAX(query2.total_amt) AS highest_amt
      FROM (SELECT c.staff_ID, SUM(c.RegFeeAmntPaid) AS total_amt
            FROM InnovationEvents.dbo.Registration c
            GROUP BY c.Staff_ID) query2) query3
WHERE query1.total_amt = query3.highest_amt;


/* 2. The event ID, event name and fee for events that have registrations, where the event fee is more than the average of event fees (for events that have registrations).*/
SELECT InnovationEvents.dbo.Event.Event_ID,InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Event.EventFee
FROM InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Event.Confirmed='1'
AND InnovationEvents.dbo.Event.EventFee > (SELECT AVG(InnovationEvents.dbo.Event.EventFee)AS AVERAGE
											 FROM InnovationEvents.dbo.Event
											 WHERE InnovationEvents.dbo.Event.Confirmed='1');
											 

/* 3. The event ID, name and fee for events where the event fee is less than the average of all event fees.3.	The event ID, name and fee for events where the event fee is less than the average of all event fees.*/
SELECT InnovationEvents.dbo.Event.Event_ID,InnovationEvents.dbo.Event.EventName,InnovationEvents.dbo.Event.EventFee
FROM InnovationEvents.dbo.Event
WHERE InnovationEvents.dbo.Event.EventFee > (SELECT AVG(InnovationEvents.dbo.Event.EventFee)AS AVERAGE
											 FROM InnovationEvents.dbo.Event);


/* 4.	The names of all attendees with their total number of registrations.*/
SELECT b.FirstName,b.LastName,COUNT(a.Attendee_ID) AS REGNUM FROM (SELECT InnovationEvents.dbo.Registration.Attendee_ID FROM InnovationEvents.dbo.Registration ) AS a, InnovationEvents.dbo.Attendee AS b
WHERE a.Attendee_ID=b.Attendee_ID
GROUP BY b.FirstName,b.LastName
