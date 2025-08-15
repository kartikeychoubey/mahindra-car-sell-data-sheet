import sqlite3
import matplotlib.pyplot as plt
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas

# --- STEP 1: Create SQLite database with sample Mahindra sales data ---
conn = sqlite3.connect("mahindra_sales.db")
cursor = conn.cursor()

cursor.execute("DROP TABLE IF EXISTS sales")
cursor.execute("""
CREATE TABLE sales (
    month TEXT,
    model TEXT,
    quantity INTEGER,
    price_per_unit REAL
)
""")

data = [
    ("Jan", "XUV700", 120, 1800000),
    ("Feb", "XUV700", 140, 1800000),
    ("Mar", "XUV700", 150, 1800000),
    ("Apr", "Thar", 100, 1500000),
    ("May", "Thar", 110, 1500000),
    ("Jun", "Thar", 130, 1500000),
    ("Jul", "Scorpio N", 90, 1600000),
    ("Aug", "Scorpio N", 95, 1600000),
    ("Sep", "Bolero", 80, 1000000),
    ("Oct", "Bolero", 85, 1000000),
    ("Nov", "Bolero Neo", 75, 900000),
    ("Dec", "Bolero Neo", 88, 900000)
]

cursor.executemany("INSERT INTO sales VALUES (?, ?, ?, ?)", data)
conn.commit()

# --- STEP 2: Extract total quantity and total revenue ---
cursor.execute("SELECT SUM(quantity), SUM(quantity * price_per_unit) FROM sales")
total_qty, total_revenue = cursor.fetchone()

# --- STEP 3: Get monthly revenue for chart ---
cursor.execute("SELECT month, SUM(quantity * price_per_unit) as revenue FROM sales GROUP BY month")
rows = cursor.fetchall()

months = [row[0] for row in rows]
revenues = [row[1] for row in rows]

# --- STEP 4: Create dark-mode bar chart ---
plt.style.use("dark_background")
plt.figure(figsize=(8, 5))
plt.bar(months, revenues, color="cyan")
plt.title("Monthly Revenue (Mahindra Cars)", color="white")
plt.xlabel("Month", color="white")
plt.ylabel("Revenue (INR)", color="white")
plt.tight_layout()
chart_path = "sales_chart_dark.png"
plt.savefig(chart_path, dpi=300)
plt.close()

# --- STEP 5: Create PDF report ---
pdf_path = "Mahindra_Sales_Report_Dark.pdf"
c = canvas.Canvas(pdf_path, pagesize=A4)
c.setFont("Helvetica-Bold", 18)
c.drawString(50, 800, "Mahindra Cars Sales Report (Dark Theme)")

c.setFont("Helvetica", 12)
c.drawString(50, 770, f"Total Quantity Sold: {total_qty}")
c.drawString(50, 750, f"Total Revenue: ₹ {total_revenue:,.2f}")

c.drawImage(chart_path, 50, 450, width=500, height=250)

c.setFont("Helvetica-Oblique", 10)
c.drawString(50, 420, "Data source: Simulated Mahindra Sales Dataset")

c.save()

conn.close()

print(f"Report generated: {pdf_path}")
