-- /*		Question Set 1 - Easy		*/
-- 1. Who is the senior most employee based on job title?

select * from employee
order by levels desc
limit 1;

-- 2. Which countries have the most Invoices?

select count(customer_id) as no_of_invoices, billing_country from invoice
group by billing_country 
order by no_of_invoices desc;

-- 3. What are top 3 values of total invoice?

select invoice_id, customer_id, billing_country, total from invoice
order by total desc
limit 3;

-- 4. Which city has the best customers? We would like to throw a promotional Music
-- Festival in the city we made the most money. Write a query that returns one city that
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice
-- totals

select billing_city as city, sum(total) as Sum_total from invoice
group by billing_city
order by sum_total desc
limit 5;


-- 5. Who is the best customer? The customer who has spent the most money will be
-- declared the best customer. Write a query that returns the person who has spent the
-- most money


select cu.customer_id, cu.first_name, cu.last_name, sum(inv.total) as spent
from customer as cu
join invoice as inv on cu.customer_id = inv.customer_id
group by cu.customer_id, cu.first_name, cu.last_name
order by spent desc
limit 5;


-- /*		Question Set 2 – Moderate		*/

-- Q1. Write query to return the email, first name, last name, & Genre of all Rock Music
-- listeners. Return your list ordered alphabetically by email starting with A

select distinct email, first_name, last_name, genre.name as genre_name
from customer
join invoice on invoice.invoice_id= customer.customer_id
join invoice_line on invoice_line.invoice_id=invoice.invoice_id
join track on track.track_id=invoice_line.track_id
join genre on genre.genre_id=track.genre_id
where genre.name = 'Rock'
order by genre_email;


-- 2. Let's invite the artists who have written the most rock music in our dataset. Write a
-- query that returns the Artist name and total track count of the top 10 rock bands


select distinct artist.name as artist_name, count(artist.artist_id) as track_count
from artist
join album on album.artist_id = artist.artist_id
join track on track.album_id = album.album_id
join genre on genre.genre_id = track.genre_id
where genre.name = 'Rock'
group by artist_name
order by track_count desc
limit 10;


-- Q3. Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the
-- longest songs listed first

select name, Milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;



-- /*		Question Set 3 – Advance		*/

-- 1. Find how much amount spent by each customer on artists? Write a query to return
-- customer name, artist name and total spent

select cu.customer_id, CONCAT(cu.first_name, ' ', cu.last_name) as customer_name, ar.name as artist_name, sum(il.unit_price * il.quantity) as total_spent
from customer as cu
join invoice as inv on inv.customer_id=cu.customer_id
join invoice_line as il on il.invoice_id = inv.invoice_id
join track as tr on tr.track_id = il.track_id
join album as al on al.album_id=tr.album_id
join artist as ar on ar.artist_id=al.artist_id
group by cu.customer_id, cu.first_name, cu.last_name, ar.name
order by total_spent desc;





