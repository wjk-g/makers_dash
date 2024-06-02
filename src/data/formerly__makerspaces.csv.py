import pandas as pd
import sys

# Read the data
df = pd.read_csv("src/data/makerspaces.csv")
df.to_csv(sys.stdout)
