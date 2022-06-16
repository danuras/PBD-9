--Praktikum 1
create trigger insert_customers on customers
for insert
as
declare @custID as varchar(10)
select @custID = customer_id from inserted
if @@ERROR = 0
begin
	print 'data ' + @custID + ' berhasil dimasukkan ke tabel customer';
end

select * from Customers

insert into Customers (customer_id, name, address, region_id, year_of_birth)
values ('CUS-000016', 'Agung Pahlepi', 'Jakarta', 'WL001', 2001)

--Praktikum 2

create trigger stok_barang on purchase_items
for insert
as
declare @stok as int
declare @jum_jual as int
declare @kodebarang as varchar(25)
select @kodebarang = item_id, @jum_jual = amount from inserted
select @stok = (select stok 
				from Items 
				where Items.item_id = @kodebarang) 

Select @stok -= @jum_jual

begin transaction

update items 
set stok = @stok 
where Items.item_id = @kodebarang
if @@ERROR=0
	commit transaction
else
	rollback transaction

select * from Purchase_Items
select * from items

insert into Purchase_Items 
(purchase_id, item_id, amount, purchasing_price, selling_price) 
values ('20160301-00003', 'CG-006-IT000038', 3, 439000.00, 450000.00)

select * from Items where item_id = 'CG-006-IT000038'

update Items set stok = 50 where item_id = 'CG-006-IT000038'
