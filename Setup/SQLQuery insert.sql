
-- Insert data into Role table
INSERT INTO [Role] (NameEN, NameAR, CreatedBy, UpdatedBy) 
VALUES ('SuperAdmin', N'المشرف', 'System', 'System');
INSERT INTO [Role] (NameEN, NameAR, CreatedBy, UpdatedBy) 
VALUES ('Admin', N'مدير', 'System', 'System');
INSERT INTO [Role] (NameEN, NameAR, CreatedBy, UpdatedBy) 
VALUES ('Driver', N'سائق', 'System', 'System');
INSERT INTO [Role] (NameEN, NameAR, CreatedBy, UpdatedBy) 
VALUES ('Client', N'عميل', 'System', 'System');
INSERT INTO [Role] (NameEN, NameAR, CreatedBy, UpdatedBy) 
VALUES ('Employee', N'موظف', 'System', 'System');


-- Insert data into Users table
INSERT INTO Users (UserName, FirstName, LastName, Email, PhoneNumber, [password], ProfileImage, JoinDate, [Status], CreatedBy, UpdatedBy, Role_id)
VALUES ('Ali.Khaled', 'Ali', 'Khaled', 'ali.khaled@gmail.com', '0789123456', 'Password123!', 'profile1.jpg', GETDATE(), 'Active', 'System', 'System', 1);
INSERT INTO Users (UserName, FirstName, LastName, Email, PhoneNumber, [password], ProfileImage, JoinDate, [Status], CreatedBy, UpdatedBy, Role_id)
VALUES ('Eman_Mahmoud' , 'Eman', 'Mahmoud', 'Eman@gmail.com', '0781234567', 'EmanPass123@', 'profile2.jpg', GETDATE(), 'Not Activated Yet', 'SuperAdmin', 'SuperAdmin', 5);
INSERT INTO Users (UserName, FirstName, LastName, Email, PhoneNumber, [password], ProfileImage, JoinDate, [Status], CreatedBy, UpdatedBy, Role_id)
VALUES ('Lina Ahmad', 'Lina', 'Ahmad', 'lina.ahmad@hotmail.com', '0789876543', 'Lina@7890', 'profile3.jpg', GETDATE(), 'Active', 'Admin', 'Admin', 4);
INSERT INTO Users (UserName, FirstName, LastName, Email, PhoneNumber, [password], ProfileImage, JoinDate, [Status], CreatedBy, UpdatedBy, Role_id)
VALUES ('KareemAli' , 'Kareem', 'Ali', 'kareem.ali@gmail.com', '0781122334', 'Kareem@6789', 'profile4.jpg', GETDATE(), 'Not Activated Yet', 'Admin', 'Admin', 3);
INSERT INTO Users (UserName, FirstName, LastName, Email, PhoneNumber, [password], ProfileImage, JoinDate, [Status], CreatedBy, UpdatedBy, Role_id)
VALUES ('Osama_Ahmad' , 'Osama', 'Ahmad', 'Osama@gmail.com', '0791234567', 'Osama@999', 'profile5.jpg', GETDATE(), 'Forbidden', 'Admin', 'Admin', 2);

 
-- Insert data into Category table
INSERT INTO Category (NameEN, NameAR, [Image], CreatedBy, UpdatedBy, Users_id)
VALUES ('Pizza', N'بيتزا', 'pizza.jpg', 'Admin', 'Admin', 2);
INSERT INTO Category (NameEN, NameAR, [Image], CreatedBy, UpdatedBy, Users_id)
VALUES ('Burgers', N'برجر', 'burger.jpg', 'Admin', 'Admin', 2);

-- Insert data into Item table
INSERT INTO Item (NameEN, NameAR, DescriptionAR, DescriptionEN, Price, [Image], CreatedBy, UpdatedBy, Users_id, Category_id)
VALUES ('Cheese Pizza', N'بيتزا بالجبنة', N'بيتزا مع جبنة لذيذة', 'Pizza with delicious cheese', 5.99, 'cheese_pizza.jpg', 'Admin', 'Admin', 2, 1);
INSERT INTO Item (NameEN, NameAR, DescriptionAR, DescriptionEN, Price, [Image], CreatedBy, UpdatedBy, Users_id, Category_id)
VALUES ('Beef Burger', N'برجر لحم البقر', N'برجر مع لحم بقر طازج', 'Burger with fresh beef', 3.99, 'beef_burger.jpg', 'Admin', 'Admin', 2, 2);

-- Insert data into ItemOption table
INSERT INTO ItemOption (NameEN, NameAR, IsRequired, CreatedBy, UpdatedBy, Users_id, Item_id)
VALUES ('Extra Cheese', N'جبن إضافي', 0, 'Admin', 'Admin', 2, 1);
INSERT INTO ItemOption (NameEN, NameAR, IsRequired, CreatedBy, UpdatedBy, Users_id, Item_id)
VALUES ('No Pickles', N'بدون مخلل', 0, 'Admin', 'Admin', 2, 2);

-- Insert data into Deliveries table
INSERT INTO Deliveries (DeliveryStatues, PickUpLocation, DropLocation, CreatedBy, UpdatedBy, Users_id)
VALUES ('Pending', 'Restaurant Location', 'Customer Address 1', 'Admin', 'Admin', 4);
INSERT INTO Deliveries (DeliveryStatues, PickUpLocation, DropLocation, CreatedBy, UpdatedBy, Users_id)
VALUES ('In-Transit', 'Restaurant Location', 'Customer Address 2', 'Admin', 'Admin', 4);

-- Insert data into [Order] table
INSERT INTO [Order] (TotalPrice, Rate, [Status], Actions, CreatedBy, UpdatedBy, Users_id, Deliveries_id)
VALUES (10.99, 5, 'Active', 'New Order', 'Admin', 'Admin', 4, 1);
INSERT INTO [Order] (TotalPrice, Rate, [Status], Actions, CreatedBy, UpdatedBy, Users_id, Deliveries_id)
VALUES (8.99, 4, 'On Shipment', 'Order Dispatched', 'Admin', 'Admin', 3, 2);

-- Insert data into [Discount&offers] table
INSERT INTO [Discount&offers] (TitleEN, TitleAR, DescriptionEN, DescriptionAR, StartDate, EndDate, LimitAmount, Code, [Image], DiscountPercentage, CreatedBy, UpdatedBy, Users_id, Item_id, Order_id)
VALUES ('New Year Discount', N'خصم رأس السنة', 'Get 20% off for New Year', N'خصم 20% لرأس السنة', '2025-04-06 ', '2025-04-30', 100, 'NEWYEAR20', 'new_year_discount.jpg', 20, 'Admin', 'Admin', 2, 1, 1);

-- Insert data into Notifications table
INSERT INTO Notifications (Title, NotificationType, IsRead, CreatedBy, UpdatedBy, Users_id, [Discount&offers_id])
VALUES ('New Year Discount Available', 'New Order', 0, 'Admin', 'Admin', 2, 1);

-- Insert data into Issue table
INSERT INTO Issue (Title, Email, [Status], CreatedBy, UpdatedBy, Users_id, Notifications_id)
VALUES ('Order not received', 'johndoe@gmail.com', 'Open', 'Admin', 'Admin', 4, 1);

-- Insert data into Suggest table
INSERT INTO Suggest (Title, Email, [Status], CreatedBy, UpdatedBy, Users_id)
VALUES ('App improvement suggestion', 'janedoe@gmail.com', 'Received', 'Admin', 'Admin', 4);

-- Insert data into Reviews table
INSERT INTO Reviews (Rate, Comment, CreatedBy, UpdatedBy, Users_id, Order_id, Item_id)
VALUES (5, 'Great pizza!', 'Admin', 'Admin', 4, 1, 1);

-- Insert data into Payment table
INSERT INTO Payment (Amount, PaymentType, PaymentStatues, CreatedBy, UpdatedBy, Users_id, Order_id)
VALUES (10.99, 'Credit Card', 'Completed', 'Admin', 'Admin', 4, 1);

-- Insert data into OrderHistory table
INSERT INTO OrderHistory (TotalPrice, Rate, [Status], CreatedBy, UpdatedBy, Users_id, Order_id)
VALUES (10.99, 'With Shipment', 'Active', 'Admin', 'Admin', 4, 1);

-- Insert data into Client_Category table
INSERT INTO Client_Category (Users_id, Category_id)
VALUES (4, 1);
INSERT INTO Client_Category (Users_id, Category_id)
VALUES (4, 2);

-- Insert data into Client_Item table
INSERT INTO Client_Item (Users_id, Item_id)
VALUES (4, 1);
INSERT INTO Client_Item (Users_id, Item_id)
VALUES (4, 2);

-- Insert data into Client_Discount table
INSERT INTO Client_Discount (Users_id, [Discount&offers_id])
VALUES (4, 1);

-- Insert data into Order_Item table
INSERT INTO Order_Item (Order_id, Item_id)
VALUES (1, 1);
INSERT INTO Order_Item (Order_id, Item_id)
VALUES (2, 2);

-- Insert data into Category_Discount table
INSERT INTO Category_Discount (Category_id, [Discount&offers_id])
VALUES (1, 1);
INSERT INTO Category_Discount (Category_id, [Discount&offers_id])
VALUES (2, 1);
