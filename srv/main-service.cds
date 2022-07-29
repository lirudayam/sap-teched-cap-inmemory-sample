using sample.Service as db from '../db/data-model';

service MainService {

    entity Customer as projection on db.Customer;

    entity Supplier as projection on db.Supplier;

    entity Product as projection on db.Product;
    entity ProductCategory as select from db.ProductCategory {
        *,
        (select from db.Product { count(*) as NumberOfProducts : Integer } where Product.CategoryName = ProductCategory.CategoryName) as NumberOfProducts : Integer
    };
    entity ProductText as projection on db.ProductText;
    entity Stock as projection on db.Stock;

    entity PurchaseOrderHeader as projection on db.PurchaseOrderHeader;
    entity PurchaseOrderItem as projection on db.PurchaseOrderItem;

    entity SalesOrderHeader as projection on db.SalesOrderHeader;
    entity SalesOrderItem as projection on db.SalesOrderItem;

    action UpdateSalesOrderStatus(id: Integer, newStatus: String) returns Boolean;

    action GenerateSamplePurchaseOrders() returns Boolean;
    action GenerateSampleSalesOrders() returns Boolean;

    action ResetSampleData() returns Boolean;
}