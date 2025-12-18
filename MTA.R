import requests
import pandas as pd

# ---- NYC 311 API endpoint ----
url = "https://data.cityofnewyork.us/resource/erm2-nwe9.json"

# ---- Parameters: filter by complaint type ----
params = {
  "$select": "unique_key,created_date,complaint_type,descriptor,borough,latitude,longitude",
  "$where": "(complaint_type in('Air Quality','Idling Vehicle')) and created_date > '2024-01-01T00:00:00'",
  "$limit": 50000
}

# ---- API request ----
print("Fetching Air Quality & Idling Vehicle complaints...")
r = requests.get(url, params=params)

# ---- Check result ----
if r.status_code != 200:
  print("Error:", r.status_code, r.text)
else:
  data = r.json()
if isinstance(data, list):
  df = pd.json_normalize(data)
print(f"✅ Retrieved {len(df):,} rows.")

# Clean columns
df["created_date"] = pd.to_datetime(df["created_date"], errors="coerce")
df["borough"] = df["borough"].astype("category")

# Preview
print(df.head())

# ---- Save to CSV ----
df.to_csv("air_quality_idling_311.csv", index=False)
print("💾 Saved to air_quality_idling_311.csv")
else:
  print("Unexpected response:", data)

