

### EDA FOR IVF DATA ###

### IMPORT ALL NECESSARY LIBRARIES ###

import pandas as pd #data manipulation and analysis dataframes
import numpy as np #Numerical computing, handling arrays and mathematical operations
import matplotlib.pyplot as plt # Static plotting library fpor visualization
import seaborn as sns # Static data visualisation with aesthetics
import plotly.express as px # Interactive visualization for EDA
import bokeh.plotting as bp # High-level interactive for web-based plotting
import bokeh.models as bm # Custom models and widgets for enhancing bokeh plots
from sqlalchemy import create_engine # Database connectivity and executing queries in Python


# Load Dataset
ivf = pd.read_csv(r"C:\Users\DELL\OneDrive\Desktop\IVF PROJECT\Dataset\ivf_equipment_utilization_2yrs.csv")

#Setting up connection for mysql database

user = "root" # username
pw = "mysql123" #password
db= "project" #database name


# Creating an engine to connect to MYSQL database using sqlalchemy

engine = create_engine(f"mysql+pymysql://{user}:{pw}@127.0.0.1:3306/{db}") 

''' I couldn’t connect using **`localhost`** because **MySQL treats 
`root@localhost` and `root@127.0.0.1` as different users, and Python 
was connecting via TCP (`127.0.0.1`) while only `root@localhost` existed**, 
so authentication failed.'''


# Dumping the ivf data into the MySQL database table named 'project'
# 'if_exists' parameter is set to 'replace' to replace the table if it already exists
# 'chunksize' parameter is used to specify the number of rows to write at a time
# 'index' parameter is set to False to avoid writing DataFrame index as a column in the table

ivf.to_sql('ivf', con = engine, if_exists = 'replace', chunksize = 1000, index = False,method = 'multi' )

''' OperationalError: (pymysql.err.OperationalError) (1045, 
"Access denied for user 'root'@'localhost' (using password: YES)")
(Background on this error at: https://sqlalche.me/e/20/e3q8) '''

### changed localhost to 127.0.01:3306 

 ## loading data from database
# SQL query to select all records from the 'ivf' table in the MySQL database

sql = ' select * from ivf'

# Reading the mysql database 'ivf' into pandas dataframe

df = pd.read_sql_query(sql, con = engine)

#displaying dataframe

df.info()

# Converting the date column

df['date'] = pd.to_datetime(df['date'], format = 'mixed') #typecasting

# Creating Year column by extracting from date colmun

df['year'] = df['date'].dt.year

## display column

df.info()

# Automatically identify numerical columns

numerical_cols = df.select_dtypes(include = [np.number]).columns.tolist()

# removing year from numerical columns
numerical_cols.remove('year') 

# assign categorical columns

categorical_cols = df.select_dtypes(exclude = [np.number]).columns.tolist()              

categorical_cols.remove('date')     

## Business Moments

## Univaraite analysis

stats = {} # To store the values in a dictionary

for col in numerical_cols:
       stats[col] = {
           "Mean": f"{df[col].mean():.2f}",
           "Median": f"{df[col].median():.2f}",
           "Mode": f"{df[col].mode()[0]}",
           "Variance": f"{df[col].var():.2f}",
           "Range": f"{df[col].max() - df[col].min():.2f}",
           "Standard Deviation": f"{df[col].std():.2f}",
            "Skewness":f"{df[col].skew():.2f}",
            "Kurtosis": f"{df[col].kurt():.2f}"
                  		}
       
stats_df = pd.DataFrame(stats).T # We can able to view it

# --------------------

# Univariate Analysis & Outlier detection

# --------------------

# Histogram in One Window

# Calculate the number of rows for the sub_plot

n_rows = (len(numerical_cols) + 1) // 2 # ensures enough rows for all columns

# Creates a fig with subplots arranged in two columns

fig, axes = plt.subplots( n_rows, 2, figsize = (12, n_rows *4))# fig: The figure object containing all subplots. axes: A NumPy array of subplot objects, which are used to plot individual charts.
axes = axes.flatten() # Converts the 2D axes array into a one-dimensional array to make iteration easier.

#Loop through numerical columns to plot histogram

for i, col in enumerate(numerical_cols):
    sns.histplot(df[col], kde = True, ax =axes[i]) # Create histogram with kde curve
    axes[i].set_xlabel(col, fontsize = 10) # Set X-axis label to column name
    axes[i].tick_params( axis ='x', rotation = 45) # Rotate X label for better readability

# Adjust layout to prevent overlap

plt.tight_layout()
plt.show()

# ----------------------------
# Boxplots in Another Window (Two Panes)
# ----------------------------

# Calculate the number of rows for the sub_plot

n_rows = (len(numerical_cols) + 1) // 2 # ensures enough rows for all columns

# Creates a fig with subplots arranged in two columns

fig, axes = plt.subplots(n_rows, 2, figsize = (12, n_rows * 4))
axes = axes.flatten() # Flatten axes to make iteration easier

# Loop through numerical columns to create boxplot

for i, col in enumerate(numerical_cols):
    sns.boxplot(x = df[col], ax = axes[i]) # Create box plot
    axes[i].set_xlabel(col, fontsize = 10) # set axis label to column name
    axes[i].tick_params( axis = 'x', rotation = 45) # Rotate X label for better readability
    
# adjust layout

plt.tight_layout()
plt.show()

for i, col in enumerate(numerical_cols):
    # Highlighting outliers
    Q1 = df[col].quantile(0.25)
    Q3 = df[col].quantile(0.75)
    IQR = Q3 - Q1
    outliers = df[(df[col] < (Q1 - 1.5 * IQR)) | (df[col] > (Q3 + 1.5 * IQR))]
    print(f"Outliers detected in {col}:\n", outliers[col])
    plt.show()
    
for col in categorical_cols:
     plt.figure(figsize = (6, 4))
     sns.countplot(x = df[col])
     plt.title(f"Count of {col}")
     plt.show()
     
 ## Plotly Pie Chart

fig = px.pie(df, names = "redundancy_available", title="Pie Chart of redundancy Available", hole = 0.5)# hole is size of center hole. Creates a donut chart with a 30% hole in the center.
fig.show(renderer = "browser")

 
# Class imbalance bar plot using Bokeh
p = bp.figure(x_range = list(df['redundancy_available'].unique()), title = "Class Imbalance in redundancy_available",
              toolbar_location = "below", tools = "zoom_in, zoom_out") # tools specifies which tools are included in the toolbar.
p.vbar(x = df['redundancy_available'].unique(), top = df['redundancy_available'].value_counts().values, width = 0.5) #vbar is vertical bar
bp.show(p)


# Bivariate Analysis (Both numeric, One numeric and one categorical)

# 1. Create scatter plot
plt.figure(figsize = (8, 6))  # Set figure size
plt.scatter(df['utilization_hrs'], df['idle_hrs'], alpha = 0.5)  # Scatter plot with transparency
plt.xlabel('utilization_hrs')  # Label for x-axis
plt.ylabel('idle_hrs')  # Label for y-axis
plt.title('Scatter Plot of idle_hrs vs utilization_hrs')  # Set title
plt.grid(True)  # Enable grid for better readability

plt.figure(figsize = (8,6))
plt.scatter(df['technical_downtime_hrs'], df['utilization_hrs'], alpha= 0.5)
plt.xlabel('technical_downtime_hrs')
plt.ylabel('utilization_hrs')
plt.title('Scatter Plot of techincal_downtime_hrs vs Utilization')
plt.grid(True)
#2.
# Show the plot
plt.show()

# Create an interactive scatter plot using Plotly
scatter = px.scatter(df, 
                     x = 'utilization_hrs', 
                     y = 'idle_hrs', 
                     color = 'redundancy_available', 
                     size_max = 60, 
                     title = 'Scatter Plot of utilization_hrs vs idle_hrs')

# Show the plot
scatter.show(renderer = "browser")

sns.boxplot(x = df["redundancy_available"], y = df["utilization_hrs"])
plt.title("redundancy_available vs utilization_hrs")
plt.show()

sns.boxplot(x = df["redundancy_available"], y = df["idle_hrs"])
plt.title("redundancy_available vs idle_hrs")
plt.show()

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#AutoEDA

# D-Tale
########

# pip install dtale
import dtale
import pandas as pd

# Read the CSV file into a DataFrame
df = pd.read_csv(r"C:\Users\DELL\OneDrive\Desktop\IVF PROJECT\Dataset\ivf_equipment_utilization_2yrs.csv")

# Display the DataFrame using D-Tale
d = dtale.show(df, host = 'localhost', port = 8000)

# Open the browser to view the interactive D-Tale dashboard
d.open_browser()
