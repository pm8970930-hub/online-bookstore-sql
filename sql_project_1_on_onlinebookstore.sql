create table books(Book_ID serial primary key,
	Title varchar(100),
	Author varchar(100),
	Genre varchar(100),
	Published_Year int,
	Price numeric(10,2),
	Stock int
		
);

select * from books;


create table customers(Customer_ID serial primary key,
	Name varchar(100),
	Email varchar(100),
	Phone varchar(15),
	City varchar(50),
	Country varchar(150));

select * from Customers;

create table orders(Order_ID serial primary key,
	Customer_ID int references customers(Customer_ID),
	Book_ID int references books(Book_ID),
	Order_Date date,
	Quantity int,
	Total_Amount numeric(10,2));


select * from orders;


--imort data into books table
--retrieve all books in the "Fiction" genre
select title,genre from books where genre='Fiction';

--find books published after the year 1950
select * from books where published_year>1950;


--list all customers from the canada
select * from customers where country='Canada';

--show order placed in november 2023
select * from orders where order_date between '2023-11-1' and '2023-11-30';

--retrieve the total stock of books available
select sum(stock) as total_stock from books;

--find the details of the most expensive book
select * from books order by price desc limit 1;


--show all customers who ordered more than 1 quantity of a book
select * from orders where quantity>1;

--retrieve all orders where the total amount exceeds $20
select * from orders where total_amount>20;

--list all the genres available in books table
select distinct genre from books;

--find the book with lowest stock
select * from books order by stock limit 1;

--calculate the total revenue generated from all orders
select sum(total_amount) as revenue from orders;

--retrive the total number of books aold forneach genre 
select b.genre,sum(o.quantity) as total_books_sold from orders o join books b on o.book_id=b.book_id
group by b.genre;



--find the average price of books in the 'Fantasy' GENRE
select avg(price) as avaerage_price from books where genre='Fantasy';

--list all customers who have placed al least 2 orders
select o.customer_id,c.name,count(o.order_id) as order_count from orders o join customers c
on o.customer_id=c.customer_id
group by o.customer_id,c.name having count(o.order_id)>=2;

--find the most frequently ordered books
select book_id,count(order_id) as order_count from orders 
group by book_id
order by order_count desc limit 1;

--show the top 3 most expensive books of 'fantasy' genre
select * from books where genre='Fantasy' order by price desc limit 3;


--retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_books_sold
from orders o join books b on b.book_id=o.book_id 
group by b.author;

--list the cities where customers who spent over $30 are located
select distinct c.city,o.total_amount from orders o join customers c on 
o.customer_id=c.customer_id 
where o.total_amount>30;

--find the customer who spent the most on orders
select c.customer_id,c.name,sum(o.total_amount) as total_spent
from orders o join customers c on o.customer_id=c.customer_id 
group by c.customer_id,c.name order by total_spent desc limit 1;


--calculate the stock remaining after fulfilling all orders
select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as order_quantity,
b.stock-coalesce(sum(o.quantity),0) as remaining_stock from books b
left join orders o on b.book_id=o.book_id 
group by b.book_id;



