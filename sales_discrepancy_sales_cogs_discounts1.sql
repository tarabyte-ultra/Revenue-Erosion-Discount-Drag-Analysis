SELECT month, 
	PRINTF('$%.2f', SUM(Gross_Sales)) AS Gross_Sales_, 
	ROUND(CAST(SUM(Discounts) AS REAL), 2) AS Discounts_,
	ROUND(CAST(SUM(Refunds) AS REAL), 2) AS Refunds_,
	ROUND(CAST(SUM(Discounts) AS REAL) / SUM(Gross_Sales) * 100, 2) AS Discount_Drag,
	PRINTF('$%.2f', SUM(Gross_Sales-(Discounts+Refunds))) AS Total_Net_Sales,
	ROUND(CAST(SUM(COGS) AS REAL), 2) AS Cost_of_Goods_Sold,
	ROUND(SUM(net_sales) - SUM(COGS), 2) AS Gross_Profit_,
	ROUND(CAST(SUM(Net_Sales) AS REAL) / SUM(Gross_Sales) * 100, 2) AS Gross_to_Net_Ratio,	
	ROUND(CAST(SUM(Gross_Profit) AS REAL) / SUM(Net_Sales) * 100, 2) AS Gross_Profit_Margin_,
	ROUND(CAST(SUM(Net_Operating_Income) AS REAL) / SUM(Net_Sales) * 100, 2) AS Operating_Margin_, 
	ROUND(CAST(SUM(Gross_Profit) AS REAL) - SUM(Total_Operating_Expenses), 2) AS Net_Operating_Income
	
FROM sales_discrepancy_csv
GROUP BY month
HAVING Discounts > 0
ORDER BY discount_drag DESC;
