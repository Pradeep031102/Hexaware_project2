import pandas as pd
from sqlalchemy import create_engine

# Load the CSV file
df = pd.read_csv('C:\\Users\\prade\\OneDrive\\Desktop\\SupplyChain\\PlantCapacities.csv', dtype=object)

# Alternatively, if you have already loaded the DataFrame, convert all columns to object
df = df.astype(object)

# Verify the conversion
# print(df.dtypes)

PlantCapacities_df = pd.DataFrame(df[["PlantCode","DailyCapacity"]])

print(PlantCapacities_df)

# Replace with your actual database connection string
 
connection_string = r"mssql+pyodbc://DESKTOP-MB0Q7BK/SupplyChain?driver=ODBC+Driver+17+for+SQL+Server"
engine = create_engine(connection_string)

# Load the DataFrame into the SQL table
PlantCapacities_df.to_sql('PlantCapacities', engine, if_exists='append', index=False)