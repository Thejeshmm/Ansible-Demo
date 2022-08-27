/* open the database */
use InnovationEvents
go

/* 1. Using Data Definition Language (DDL) elements of SQL, write the script to create the INDUSTRY table. */
CREATE TABLE Industry (
                IndustryName NVARCHAR(50) NOT NULL,
                Description NVARCHAR(100) NOT NULL,
                CONSTRAINT Industry_pk PRIMARY KEY (IndustryName)
);

/* 2. Using Data Definition Language (DDL) elements of SQL, write the script to create the COMPANY table. */
CREATE TABLE Company (
                CompanyName NVARCHAR(50) NOT NULL,
                ABN NCHAR(11) NOT NULL,
				StreetAddress NVARCHAR(50) NOT NULL,
				Suburb NVARCHAR(40) NOT NULL,
				State NVARCHAR(3) NOT NULL,
				Country NVARCHAR(50) NOT NULL,
				IndustryName NVARCHAR(50) NOT NULL,
                CONSTRAINT Company_pk PRIMARY KEY (CompanyName)				
);

/* 3. Write the SQL statement to manipulate the COMPANY table and add a UNIQUE Non-cluster Index to the ABN column, named uniqueABN_Idx.*/ 	
ALTER TABLE InnovationEvents.dbo.Company
ADD  CONSTRAINT uniqueABN_Idx UNIQUE(ABN);

/* 4. Write the SQL statement to manipulate the COMPANY table and add a FOREIGN KEY constraint to the IndustryName column that references the Primary Key of the INDUSTRY table.*/
ALTER TABLE InnovationEvents.dbo.Company
ADD CONSTRAINT Company_Industry_fk FOREIGN KEY(IndustryName) REFERENCES Industry(IndustryName);


