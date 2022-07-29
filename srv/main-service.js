const LOG = cds.log('main-service');

const {
    SalesOrderHeader,
    SalesOrderItem,
    PurchaseOrderHeader,
    PurchaseOrderItem
} = cds.entities('sample.Service');

const samplePurchases = require('./sample-purchase-orders.json');
const sampleSales = require('./sample-sales-orders.json');

module.exports = async (srv) => {

    srv.on("UpdateSalesOrderStatus", async (req) => {

        const { id, newStatus } = req.data;

        if (id && newStatus) {
            const salesOrder = await SELECT.one.from(SalesOrderHeader).where({ SalesOrderID: id }); 
            if (salesOrder) {
                await UPDATE(SalesOrderHeader).set({ LifeCycleStatus: id }).where({
                    SalesOrderID: id
                });
            }
        }
    });

    srv.on("GenerateSamplePurchaseOrders", async (req) => {
        LOG.info("Adding samples purchase order data");
        await INSERT.into(PurchaseOrderHeader).entries(samplePurchases);
        return true;
    });

    srv.on("GenerateSampleSalesOrders", async (req) => {
        LOG.info("Adding samples sales order data");
        await INSERT.into(SalesOrderHeader).entries(sampleSales);
        return true;
    });

    srv.on("ResetSampleData", async (req) => {
        LOG.info("Clearing purchase and sales data");
        await DELETE.from(PurchaseOrderHeader);
        await DELETE.from(SalesOrderHeader);

        await DELETE.from(PurchaseOrderItem);
        await DELETE.from(SalesOrderItem);
        return true;
    });
};