import pandas as pd
from sqlalchemy import create_engine

# Load the CSV file
df = pd.read_csv('C:\\Users\\prade\\OneDrive\\Desktop\\SupplyChain\\OrderList.csv', dtype=object)

# Convert data types to match SQL table schema
df['OrderID'] = pd.to_numeric(df['OrderID'], errors='coerce', downcast='integer')
df['OrderDate'] = pd.to_datetime(df['OrderDate'], errors='coerce')
df['ShipAheadDayCount'] = pd.to_numeric(df['ShipAheadDayCount'], errors='coerce', downcast='integer')
df['ShipLateDayCount'] = pd.to_numeric(df['ShipLateDayCount'], errors='coerce', downcast='integer')
df['ProductID'] = pd.to_numeric(df['ProductID'], errors='coerce', downcast='integer')
df['UnitQuantity'] = pd.to_numeric(df['UnitQuantity'], errors='coerce', downcast='integer')
df['Weight'] = pd.to_numeric(df['Weight'], errors='coerce', downcast='float')

# Convert the DataFrame to the desired SQL table format
Orders_df = pd.DataFrame(df[[
    "OrderID",
    "OrderDate",
    "OriginPort",
    "Carrier",
    "TPT",
    "ServiceLevel",
    "ShipAheadDayCount",
    "ShipLateDayCount",
    "Customer",
    "ProductID",
    "PlantCode",
    "DestinationPort",
    "UnitQuantity",
    "Weight"
]])

# Verify the data types
print(Orders_df.dtypes)

# Replace with your actual database connection string
 
connection_string = r"mssql+pyodbc://DESKTOP-MB0Q7BK/SupplyChain?driver=ODBC+Driver+17+for+SQL+Server"
engine = create_engine(connection_string)

# Load the DataFrame into the SQL table
Orders_df.to_sql('Orders', engine, if_exists='append', index=False)

print("Data loaded successfully!")