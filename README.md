# 📊 **Sales Revenue Erosion & Discount Drag Analysis**

### **Why did discounts spike to $21k in March while Net Operating Income, Gross Margin and Operating Margin decline?** ###

---

## 📌 **Summary**

This project investigates a critical operational red flag: **excessive promotional discounting eroding Net Operating Income (NOI) despite Gross Sales growth**. 

*This dataset contains simulated data modeled after a real-world problem I encountered.* 

Sales, Discounts, Refunds, Inventory and COGS were consistent from month to month until a $21,150.00 spike in discounts raised a red flag.  Excessive discount amounts erode the gross profit margin and net operating income, while significantly raising margin erosion.  The core business is stable under normal conditions but an aggressive discount strategy in one month leads to severe margin erosion.  Analyze sales data to find whether this is a data error, misclassification or a system glitch rather than a spike in customer discounts.


### 🚩 **Key Findings** 
* March promotional discounts inflated gross sales while driving down the net operating income
* Sales growth was artificially manufactured by heavy discounts
* Operating Margin fell to (-10.95%) due to heavy discounts, reducing revenue while fixed operating expenses remained constant
* Discounts accounted for 26.50% of market erosion, compared to the average of 3.08% monthly market erosion
* Sales volume declined by 13.88%
* The single month of March discounts caused 9.6 months of damage (961.47%) to margin erosion 
* Gross profit was 16.58% less efficient than the avg previous 11 months
* Total profit loss for the month of March was $12,607.67
* Gross margin and operating margin declined as margin erosion increased
* Baseline months (Apr–Feb) averages 94.82% Gross to Net Ratio
* March Gross to Net drops drastically to 68.53% due to the $21,150 promotional discount
* Although the heavy discounting moved inventory, the discount drag eroded profit margins faster than the sales volume can compensate 
* Analyzing monthly inventory turnover ratios reveal that heavy discounting failed to accelerate inventory for slow moving stock  
---


![alt text](/resources/dashboardC.jpg)
---
---

## 🔍 **Audit Trail**
**Audit checklist:**

1.	Verify whether it is a technical error (connection error, sync error or import error)
2.	Items were mistakenly categorized as “discounts” 
3.	Verify manual entry (processed a discount log incorrectly)
4.	Check bulk promotion misconfiguration
5.	Check credit misclassification


**Process to check:**
1.	Cost of Goods Sold (COGS) – discrepancies or shrinkage, goods sold at or below cost
2.	Month End Inventory Value – monthly inventory turnover and excess baseline stock
3.	Discounts & Discount Drag – percentage of gross sales eroded by discounts 
4.	Compare Refunds to Discounts – did refunds drop while discounts spiked?
5.	Gross Profit – items categorized incorrectly, contribution for the month
6.	Gross Profit Margin – did the issue degrade profitability or offset somewhere else
7.	Gross to Net Ratio – how effectively is Gross Sales converted to Net Sales
8.	Operating Margin -operational profit from every dollar of net sales 
9.	Net Operating Income (NOI) – total revenue



---
---



## 🛠️ **Data Stack & Tools Used**

* **SQL:** data extraction, aggregate models 
* **Excel:** profit modeling, KPI dashboarding
* **Markdown / GitHub:** Portfolio presentation & documentation.
---
---

## 📐**KPI Definitions & Analytical Formulas**
| Metric | Calculation / Logic | Analytical Focus |
| :--- | :--- | :--- |
| **Gross Profit Margin** | `(Gross Profit / Net Sales ) ` |Profit percentage of total revenue|
| **Gross Profit** | `(Net Sales - COGS) ` | Total profit from services |
| **Gross-to-Net Ratio** | `((Net Sales / Gross Sales)*100)` | Percentage of gross revenue retained after discounts & refunds |
| **Discount Drag** | `((Discounts/ Gross Sales)*100)` | Percentage of total gross sales discounted|
| **Operating Margin** | `(Net Operating Income / Net Sales)` | Overall operational efficiency yield (final profits)|
| **Net Operating Income (NOI)** | `(Gross Profit - Total Operating Expenses)` | Operational yield |

---
![alt text](</resources/excel p&lCN.png>)
---
---

## 💻 **SQL Query Audit** 

The core query below aggregates monthly sales data, calculates Net Operating Income, and computes the Discount Drag ratio:

```sql
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
```
---

![alt text](</resources/sql (1)C.png>)

---
---
## 🚩 **Findings and Diagnostic Analysis** 

**After analyzing the data, the jump in discounts was not due to a data error or misclassification, but rather to a sales event.  The Store ran a massive sales promotion throughout March to liquidate old inventory.  
What was the true financial impact of the March Promotion?** 

1. **Discount Drag** 

    The analysis highlights a severe operational jump from 3.08% to 29.58% variance which indicates a massive anomaly in discount drag.  Discount Drag spike to 29.58% for the month of March.  The normal baseline months (April- February) show a steady percentage of 2%-4%.  In one single month, the aggressive discount strategy caused almost 10 months of damage to the business, due to uncapped promotional discounts.

2.  **Operating Profit and Margin**

    While Gross Profit and Gross Profit Margin dropped significantly, Operating Margin declined into negative territory.  Sales volume decreased by 13.88%.   Gross Profit was 16.58% less efficient than the average previous 11 months.  Net Operating Income (NOI) underperformed, resulting in a $5367 loss.  Because Fixed Operating Expenses remained stable, the erosion of Gross Margin flowed directly to the bottom line.  

3.  **Discounts vs. Monthly Inventory Turnover Ratio**

    A common justification for aggressive discounts is inventory liquidation of slow turnover items.  However, analyzing Discount Drag with the Monthly Inventory Turnover Ratio demonstrates diminishing returns.  Despite discounts being applied, Gross Margin and Operating Margin were sliced without solving inventory bottlenecks.



---
---

## 🎯 **Action Plan and Recommendations**

**Restructuring discount promotions is required immediately to restore net profit** 

1.	Implement promotional caps for maximum allowable discounts to prevent discount drag from exceeding 15%.
2.	Align discounts specifically to aged inventory. Reserve discounts for aged stock, 90 days or older.
3.	Eliminate baseline promotional discounting on top selling products.
4.	Transition slow-turnover items to flash clearance bundles rather than storewide promotions.  
5.	Monitor monthly profits and margins.
6.	Reward repeat purchases with points or perks instead of heavy discounts.

---

---

![alt text](/resources/slidedeck1C.jpg)
---

![alt text](</resources/slidedeck12 (1)C.png>)
---
![alt text](</resources/slidedeck123 (1)C.png>)
---
![alt text](</resources/slidedeck1234 (1)C.png>)
---
![alt text](</resources/slidedeck12345 (1)C.png>)
---
![alt text](</resources/slidedeck123456 (1)C.png>)
---
![alt text](</resources/slidedeck1234567 (1)C.png>)
---
---
## 📂 **Repository Structure**

```
├── data/
│   └── sales_discrepancy_csv.csv      # Raw transactional dataset
├── sql/
│   └── sales_discount_drag_audit.sql  # Optimized SQLite aggregate script
├── docs/
│   └── Executive_Audit_Report.docx     # Full executive project documentation
└── README.md                           # Project summary & documentation
```

## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/tara-hatcher-/)


## Authors

- [@tarabyte-ultra](https://github.com/tarabyte-ultra)


---
