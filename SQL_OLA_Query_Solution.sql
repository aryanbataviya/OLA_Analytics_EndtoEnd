CREATE TABLE ola (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(50),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT DECIMAL(10,2),
    C_TAT DECIMAL(10,2),
    Canceled_Rides_by_Customer VARCHAR(100),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(20),
    Incomplete_Rides_Reason VARCHAR(100),
    Booking_Value FLOAT,
    Payment_Method VARCHAR(50),
    Ride_Distance FLOAT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT,
    Vehicle_Images TEXT,
    Month INT,
    Day_Name VARCHAR(20),
    Hour INT,
    Ride_Success INT
);

----------------------------- SQL Questions ------------------------------

-- 1. Retrieve all successful bookings: 
Select * from ola
where Booking_Status = 'Success';


-- 2. Find the average ride distance for each vehicle type: 
select Vehicle_Type, avg(ride_distance) as Avg_Ride_Distance 
from ola
group by Vehicle_Type
ORDER BY Avg_Ride_Distance DESC;



-- 3. Get the total number of cancelled rides by customers: 
select count(*) as Customer_Cancellations 
from ola
where Booking_Status = 'Canceled By Customer';



-- 4. List the top 5 customers who booked the highest number of rides: 
select Customer_ID, count(*) as Total_rides
from ola
group by Customer_ID
order by Total_rides desc
limit 5;




-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues: 
select Canceled_Rides_by_Driver, count(*) as Driver_Personal_Cancellations from ola
group by Canceled_Rides_by_Driver
having Canceled_Rides_by_Driver = 'Personal & Car related issue';


-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings: 
select max(Driver_Ratings) as Max_Ratings, min(Driver_Ratings) as Min_Ratings 
from ola
where Vehicle_Type = 'Prime Sedan';



-- 7. Retrieve all rides where payment was made using UPI: 
select * from ola
where Payment_method = 'UPI';




-- 8. Find the average customer rating per vehicle type: 
select Vehicle_Type , Avg(Customer_Rating) as Avg_Customer_Rating from ola
group by Vehicle_Type
ORDER BY Avg_Customer_Rating DESC;



-- 9. Calculate the total booking value of rides completed successfully: 
select sum(booking_value) as Total_Success_Revenue
from ola
where Booking_Status = 'Success';



-- 10. List all incomplete rides along with the reason
SELECT Booking_ID, Incomplete_Rides_Reason
FROM ola
WHERE Incomplete_Rides = 'Yes';















