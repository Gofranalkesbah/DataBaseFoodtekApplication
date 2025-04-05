create database [Foodtek Application]


create table [Role] (
    Id int primary key identity(1,1),
    NameEN varchar(50) not null unique check(NameEN LIKE '[A-Za-z ]%'),
    NameAR nvarchar(50) NOT NULL UNIQUE check(NameAR LIKE '%[^أ-ي ]%'),
	CreatedBy varchar(50) not null,
   UpdatedBy varchar(50) not null,
 IsActive Bit DEFAULT 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate()
);

create table Users (
    Id int primary key identity(1,1),
	UserName varchar(15) unique not null check (UserName LIKE '[A-Za-z]%'),
    FirstName varchar(50) not null check (FirstName LIKE '[A-Za-z]%' AND FirstName NOT LIKE '%[^A-Za-z ]%'), 
    LastName varchar(50) not null check (LastName LIKE '[A-Za-z]%' AND LastName NOT LIKE '%[^A-Za-z ]%'), 
    Email varchar(50) unique check (
           Email LIKE '_%@gmail.com' 
        OR Email LIKE '_%@hotmail.com' 
        OR Email LIKE '_%@outlook.com' 
        OR Email LIKE '_%@zoho.com'
    ),  
	 PhoneNumber varchar(10) not null unique check(
               PhoneNumber like '07[789]_______' and
               LEN(PhoneNumber) = 10),
    [password] varchar(50) not null check (
    len([password]) >=8 and
    [password] LIKE '%[a-z]%' and
    [password] LIKE '%[A-Z]%' and 
    [password] LIKE '%[0-9]%' and 
    [password] LIKE '%[@$!%*?&]%'
	), 
    ProfileImage varchar(max), 
    JoinDate datetime ,
    [Status] VARCHAR(20) NOT NULL  check (Status IN ('Active', 'Not Activated Yet', 'Forbidden', 'Blocked')),
	CreatedBy varchar(50) not null,
    UpdatedBy varchar(50) not null,
    IsActive Bit DEFAULT 0,
    UpdateDate datetime default GetDate(),
    CreationDate datetime default GetDate(),
    Role_id int ,
    foreign key(Role_id) references [Role](id)
);

create table Category(
Id int primary key identity(1,1), 
NameEN varchar(50) not null unique check(NameEN LIKE '[A-Za-z ]%'),
NameAR nvarchar(50) not null unique check(NameAR LIKE '%[^أ-ي ]%'),
[Image] varchar(255) not null check([Image] LIKE '%.png' OR [Image] LIKE '%.jpg' OR [Image] LIKE '%.webp'),
CreatedBy varchar(50) not null,
UpdatedBy varchar(50) not null,
IsActive Bit DEFAULT 0,
UpdateDate datetime default GetDate(),
CreationDate datetime default GetDate(),
Users_id int ,
foreign key(Users_id) references Users(id),
)

create table Item(
Id int primary key identity(1,1),
NameEN varchar(50) not null unique check(NameEN LIKE '%[A-Za-z ]%'),
NameAR nvarchar(50) not null unique check(NameAR LIKE '%[^أ-ي ]%'),
DescriptionAR nvarchar(255) check (DescriptionAR LIKE '%[^أ-ي ]%'),
DescriptionEN varchar(255) check (DescriptionEN LIKE '%[A-Za-z ]%'), 
Price float check (Price > 0), 
[Image] varchar(255) not null check([Image] LIKE '%.png' OR [Image] LIKE '%.jpg' OR [Image] LIKE '%.webp'),
CreatedBy varchar(50) not null,
UpdatedBy varchar(50) not null,
IsActive Bit DEFAULT 0,
UpdateDate datetime default GetDate(),
CreationDate datetime default GetDate(),
Users_id int ,
foreign key(Users_id) references Users(id),
   Category_id int ,
 foreign key(Category_id) references Category(id),
)

create table ItemOption (
Id int primary key identity(1,1),
NameEN varchar(50) not null unique check(NameEN LIKE '[A-Za-z ]%'),
NameAR nvarchar(50) not null unique check(NameAR LIKE '%[^أ-ي ]%'),
IsRequired bit not null default 0,
CreatedBy varchar(50) not null,
UpdatedBy varchar(50) not null,
IsActive Bit DEFAULT 0,
UpdateDate datetime default GetDate(),
CreationDate datetime default GetDate(),
Users_id int ,
foreign key(Users_id) references Users(id),
  Item_id int ,
 foreign key(Item_id) references Item(id),
)

create table Deliveries(
Id int primary key identity(1,1),
DeliveryStatues varchar(50) not null check (
        DeliveryStatues in ('Pending', 'In-Transit', 'Delivered', 'Canceled')),
PickUpLocation varchar(255) not null,
DropLocation varchar(255) not null,
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit DEFAULT 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
  Users_id int ,
  foreign key(Users_id) references Users(id),
)

create table [Order](
Id int primary key identity(1,1), 
TotalPrice decimal(10, 2) not null, 
Rate int check(Rate between 1 AND 5),
[Status] varchar(20) NOT NULL CHECK (
        [Status] IN ('Active', 'On Shipment', 'Complete', 'Canceled')),
Actions varchar(50) NOT NULL,
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit DEFAULT 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
Users_id int ,
foreign key(Users_id) references Users(id),
  Deliveries_id int,
  foreign key(Deliveries_id) references Deliveries(id)
)

create table [Discount&offers](
Id int primary key identity(1,1),
TitleEN varchar(50) not null unique check(TitleEN LIKE '%[A-Za-z ]%'),
TitleAR nvarchar(50) not null unique check(TitleAR LIKE '%[^أ-ي ]%'),
DescriptionEN varchar(255) check (DescriptionEN LIKE '%[A-Za-z ]%'),
DescriptionAR nvarchar(255) check (DescriptionAR LIKE '%[^أ-ي ]%'),
StartDate datetime not null check (StartDate >= GETDATE()), 
EndDate datetime not null check ( EndDate >= GETDATE()),
LimitAmount float null check (LimitAmount > 0),
Code varchar(50) check (Code NOT LIKE '%[^A-Za-z0-9]%'), 
[Image] varchar(max) null,
DiscountPercentage int null check (DiscountPercentage BETWEEN 1 AND 50),
CreatedBy varchar(50) not null,
UpdatedBy varchar(50) not null,
IsActive Bit DEFAULT 0,
UpdateDate datetime default GetDate(),
CreationDate datetime default GetDate(),
Users_id int ,
foreign key(Users_id) references Users(id),
 Item_id int, 
 FOREIGN KEY(Item_id) REFERENCES Item(id) ,
 Order_id int, 
 FOREIGN KEY(Order_id) REFERENCES [Order](id)
);

create table Notifications(
Id int primary key identity(1,1),
Title varchar(50) not null  ,
NotificationType varchar(100) not null check (
                   NotificationType in ('Issue' , 'Support' , 'New Order' , 'New System Action')),
IsRead bit not null default 0,
CreatedBy varchar(50) not null,
UpdatedBy varchar(50) not null,
IsActive Bit DEFAULT 0,
UpdateDate datetime default GetDate(),
CreationDate datetime default GetDate(),
Users_id int ,
foreign key(Users_id) references Users(id),
[Discount&offers_id] int ,
 foreign key([Discount&offers_id]) references [Discount&offers](id),
)

create table Issue (
Id int primary key identity(1,1),
Title varchar(255) not null , 
Email varchar(50) unique check (
           Email LIKE '_%@gmail.com' 
        OR Email LIKE '_%@hotmail.com' 
        OR Email LIKE '_%@outlook.com' 
        OR Email LIKE '_%@zoho.com'
),
[Status] varchar(30) not null check (
        [Status] IN ('Open', 'Pending', 'Waiting Customer Response', 'Closed')
    ),
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit DEFAULT 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
 Users_id int ,
 foreign key(Users_id) references Users(id),
 Notifications_id int ,
 foreign key(Notifications_id) references Notifications(id),
) 

create table Suggest(
Id int primary key identity(1,1),
Title varchar(255) not null , 
Email varchar(50) unique check (
           Email LIKE '_%@gmail.com' 
        OR Email LIKE '_%@hotmail.com' 
        OR Email LIKE '_%@outlook.com' 
        OR Email LIKE '_%@zoho.com'
), 
[Status] varchar(30) not null check (
        [Status] IN ('Received', 'Approved', 'Rejected')
    ),
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit DEFAULT 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
 Users_id int ,
 foreign key(Users_id) references Users(id),
)

create table Reviews(
Id int primary key identity(1,1),
Rate int check(Rate between 1 AND 5), 
Comment varchar(250) null ,
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit default 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
 Users_id int ,
 foreign key(Users_id) references Users(id),
 Order_id int ,
 foreign key(Order_id) references [Order](id),
  Item_id int ,
 foreign key(Item_id) references Item(id),
)

create table Payment(
Id int primary key identity(1,1),
Amount decimal(18, 2) check (Amount > 0),
PaymentType varchar(50) not null check (
        PaymentType in ('Credit Card', 'Debit Card')) ,
PaymentStatues varchar(50) not null check (
        PaymentStatues in ('Pending', 'Completed', 'Failed')),
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit default 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
  Users_id int ,
 foreign key(Users_id) references Users(id),
 Order_id int ,
 foreign key(Order_id) references [Order](id),
)

create table OrderHistory(
Id int primary key identity(1,1),
TotalPrice decimal(10, 2) not null, 
Rate varchar(50) not null check (Rate IN ('With Shipment', 'Canceled', 'Complete')),
[Status] varchar(50) not null check ([Status] IN ('Active', 'On Shipment', 'Complete', 'Canceled')),
CreatedBy varchar(50) not null,
 UpdatedBy varchar(50) not null,
 IsActive Bit default 0,
 UpdateDate datetime default GetDate(),
 CreationDate datetime default GetDate(),
  Users_id int ,
 foreign key(Users_id) references Users(id),
 Order_id int ,
 foreign key(Order_id) references [Order](id),
)

create table Client_Category(
Users_id int ,
foreign key(Users_id) references Users(id),
 Category_id int ,
 foreign key(Category_id) references Category(id),
 PRIMARY KEY (Users_id, Category_id),
)

create table Client_Item(
Users_id int ,
foreign key(Users_id) references Users(id),
 Item_id int ,
 foreign key(Item_id) references Item(id),
 PRIMARY KEY (Users_id, Item_id),
)

create table Client_Discount(
 Users_id int ,
 foreign key(Users_id) references Users(id),
 [Discount&offers_id] int ,
 foreign key([Discount&offers_id]) references [Discount&offers](id),
  PRIMARY KEY (Users_id, [Discount&offers_id]),
)

create table Order_Item(
 Order_id int ,
 foreign key(Order_id) references [Order](id),
 Item_id int ,
 foreign key(Item_id) references Item(id),
  PRIMARY KEY (Order_id, Item_id ),
)

create table Category_Discount(
 Category_id int ,
 foreign key(Category_id) references Category(id),
 [Discount&offers_id] int ,
 foreign key([Discount&offers_id]) references [Discount&offers](id),
   PRIMARY KEY ( Category_id, [Discount&offers_id] ),
)
