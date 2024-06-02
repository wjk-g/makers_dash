import pandas as pd
import sys

# Read the data
df = pd.read_csv("src/data/clusters.csv", delimiter=";")
print(df.head())
df.to_csv(sys.stdout)
