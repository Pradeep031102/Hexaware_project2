import pandas as pd
from sqlalchemy import create_engine

# Load the CSV file
df = pd.read_csv('C:\\Users\\prade\\OneDrive\\Desktop\\SupplyChain\\CarrierRates.csv', dtype=object)

# Convert data types to match SQL table schema
df['MinWeightQuantity'] = pd.to_numeric(df['MinWeightQuantity'], errors='coerce', downcast='float')
df['MaxWeightQuantity'] = pd.to_numeric(df['MaxWeightQuantity'], errors='coerce', downcast='float')
df['MinimumCost'] = pd.to_numeric(df['MinimumCost'], errors='coerce', downcast='float')
df['Rate'] = pd.to_numeric(df['Rate'], errors='coerce', downcast='float')
df['TransportDayCount'] = pd.to_numeric(df['TransportDayCount'], errors='coerce', downcast='integer')

# Convert the DataFrame to the desired SQL table format
CarrierRates_df = df[[
    "Carrier",
    "OriginPort",
    "DestinationPort",
    "MinWeightQuantity",
    "MaxWeightQuantity",
    "ServiceCode",
    "MinimumCost",
    "Rate",
    "ModeDescription",
    "TransportDayCount",
    "CarrierType"
]]

# Check for duplicates in the DataFrame based on primary key columns
duplicates = CarrierRates_df[CarrierRates_df.duplicated(
    subset=['Carrier', 'OriginPort', 'DestinationPort', 'MinWeightQuantity', 'MaxWeightQuantity'], keep=False)]
print("Duplicate rows in DataFrame:")
print(duplicates)

# Remove duplicates
CarrierRates_df = CarrierRates_df.drop_duplicates(
    subset=['Carrier', 'OriginPort', 'DestinationPort', 'MinWeightQuantity', 'MaxWeightQuantity'])

# Replace with your actual database connection string
connection_string = (
    r"mssql+pyodbc://DESKTOP-MB0Q7BK/SupplyChain?driver=ODBC+Driver+17+for+SQL+Server"
)
engine = create_engine(connection_string)

try:
    CarrierRates_df.to_sql('CarrierRates', engine, if_exists='append', index=False)
    print("Data loaded successfully!")
except Exception as e:
    print(f"An error occurred: {e}")