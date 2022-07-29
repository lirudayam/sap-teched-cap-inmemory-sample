namespace sample.Service;

using {cuid} from '@sap/cds/common';

type Gender : Integer enum {
    Male    = 0;
    Female  = 1;
    Other   = 2;
    None    = 3;
    Unknown = 4;
}

type Address {
    HouseNumber : String;
    Street      : String;
    City        : String;
    Country     : String;
    PostalCode  : String;
}

entity Customer {
    key CustomerID   : Integer;
        City         : String(40);
        Country      : String(30);
        DateOfBirth  : Date not null;
        EmailAddress : String(255);
        Gender       : Gender;
        FirstName    : String(40);
        HouseNumber  : String(10);
        LastName     : String(40);
        PhoneNumber  : String(30);
        PostalCode   : String(10);
        Street       : String(60);
        Address      : Address;
        SalesOrders  : Association to many SalesOrderHeader
                           on SalesOrders.CustomerID = CustomerID;
}

entity Supplier {
    key SupplierID     : Integer not null;
        City           : String(40);
        Country        : String(3);
        EmailAddress   : String(255);
        HouseNumber    : String(10);
        PhoneNumber    : String(40);
        PostalCode     : String(30);
        Street         : String(60);
        SupplierName   : String;
        Address        : Address;
        Products       : Association to many Product
                             on Products.SupplierID = SupplierID;
        PurchaseOrders : Association to many PurchaseOrderHeader
                             on PurchaseOrders.SupplierID = SupplierID;
}

entity Product {
    key ProductID          : Integer not null;
        CategoryName       : String(40);
        CurrencyCode       : String(5);
        DimensionDepth     : Decimal;
        DimensionHeight    : Decimal;
        DimensionUnit      : String(3);
        DimensionWidth     : Decimal;
        LongDescription    : String(255);
        Name               : String(80) not null;
        PictureUrl         : String(255);
        Price              : Decimal;
        QuantityUnit       : String(3);
        ShortDescription   : String(255);
        SupplierID         : Integer;
        Weight             : Decimal;
        WeightUnit         : String(3);
        Picture            : Binary;

        Category           : Association to one ProductCategory
                                 on Category.CategoryName = CategoryName;
        Supplier           : Association to one Supplier
                                 on Supplier.SupplierID = SupplierID;
        Stock              : Association to one Stock
                                 on Stock.ProductID = ProductID;
        PurchaseOrderItems : Association to many PurchaseOrderItem
                                 on PurchaseOrderItems.ProductID = ProductID;
        SalesOrderItems    : Association to many SalesOrderItem
                                 on SalesOrderItems.ProductID = ProductID;
}

entity ProductCategory {
    key CategoryName             : String(40);
        MainCategoryName         : String(40);

        MainCategory             : Association to one ProductCategory
                                       on MainCategory.CategoryName = MainCategoryName;
        virtual NumberOfProducts : Integer;
}

entity ProductText {
    key ID               : Integer not null;
        Language         : String(2);
        LongDescription  : String(255);
        Name             : String(10);
        ProductID        : Integer;
        ShortDescription : String(255);
}

entity PurchaseOrderHeader {
    key PurchaseOrderID : Integer not null;
        CurrencyCode    : String(5);
        GrossAmount     : Decimal;
        NetAmount       : Decimal;
        SupplierID      : Integer;
        TaxAmount       : Decimal;
        Supplier        : Association to one Supplier
                              on Supplier.SupplierID = SupplierID;
        Items           : Composition of many PurchaseOrderItem
                              on Items.PurchaseOrderID = PurchaseOrderID;
}

entity PurchaseOrderItem {
    key ItemNumber      : Integer not null;
    key PurchaseOrderID : Integer not null;
        CurrencyCode    : String(5);
        GrossAmount     : Decimal;
        NetAmount       : Decimal;
        ProductID       : Integer;
        Quantity        : Integer not null;
        QuantityUnit    : String(3);
        TaxAmount       : Decimal;

        Product         : Association to one Product
                              on Product.ProductID = ProductID;
        Header          : Association to one PurchaseOrderHeader
                              on Header.PurchaseOrderID = PurchaseOrderID;
}

entity SalesOrderHeader {
    key SalesOrderID        : Integer not null;
        CreatedAt           : Date not null;
        CurrencyCode        : String(5);
        CustomerID          : Integer;
        GrossAmount         : Decimal;
        LifeCycleStatus     : String(1) not null;
        LifeCycleStatusName : String(255) not null;
        NetAmount           : Decimal;
        TaxAmount           : Decimal;

        Customer            : Association to one Customer
                                  on Customer.CustomerID = CustomerID;
        Items               : Composition of many SalesOrderItem
                                  on Items.SalesOrderID = SalesOrderID;
}

entity SalesOrderItem {
    key ItemNumber   : Integer not null;
    key SalesOrderID : Integer not null;
        CurrencyCode : String(5);
        DeliveryDate : Date;
        GrossAmount  : Decimal;
        NetAmount    : Decimal;
        ProductID    : Integer;
        Quantity     : Integer not null;
        QuantityUnit : String(3);
        TaxAmount    : Decimal;

        Product      : Association to one Product
                           on Product.ProductID = ProductID;
        Header       : Association to one SalesOrderHeader
                           on Header.SalesOrderID = SalesOrderID;
}

entity Stock {
    key ProductID       : Integer not null;
        LotSize         : Integer;
        MinStock        : Integer;
        Quantity        : Integer;
        QuantityLessMin : Boolean not null;
        Product         : Association to one Product
                              on Product.ProductID = ProductID;
}
