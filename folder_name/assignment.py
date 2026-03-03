import streamlit as st
import pandas as pd
import sqlite3

# Connect to SQLite DB
def get_connection():
    return sqlite3.connect(r"C:\Users\karthik\OneDrive\Desktop\SMA TECH\Assignment 1\assignment.db")

def run_query(query, params=()):
    conn = get_connection()
    df = pd.read_sql_query(query, conn, params=params)
    conn.close()
    return df


st.title("Used Car Market Analysis Dashboard")

menu = st.sidebar.selectbox(
    "Select Analysis",
    ["Popular Cars",
     "Repeat Patterns", 
     "Low Price Analysis", 
     "Segmentation"]
)



if menu == "Popular Cars":

        
    st.header("Popular Cars by Year & State")

    years = run_query("SELECT DISTINCT sale_year FROM car_prices;")
    states = run_query("SELECT DISTINCT state FROM car_prices")

    year = st.selectbox("Select Year", years["sale_year"].dropna())
    state = st.selectbox("Select State", states["state"].dropna())

    query = """
    SELECT make, model, COUNT(*) as total_sales
    FROM car_prices
    WHERE sale_year = ?
    AND state = ?
    GROUP BY make, model
    ORDER BY total_sales DESC
    LIMIT 10
    """

    df = run_query(query, (year, state))
    st.dataframe(df)

    st.header("Sales Trend Over Time")
    query = """
        SELECT sale_month as month,
            COUNT(*) as total_sales
        FROM car_prices
        WHERE sale_year = ?
        AND state = ?
        GROUP BY month
        ORDER BY month
        """

    df_trend = run_query(query, (year, state))

    st.line_chart(df_trend.set_index("month"))

elif menu == "Repeat Patterns":
    st.header("Repeat VIN Analysis")

    query = """
    SELECT vin, COUNT(*) as repeat_count
    FROM car_prices
    GROUP BY vin
    HAVING repeat_count > 1
    ORDER BY repeat_count DESC
    LIMIT 20
    """

    df = run_query(query)
    st.dataframe(df)


elif menu == "Low Price Analysis":
    st.header("Low Price Analysis")

    query = """
    SELECT make, AVG(sellingprice) as avg_price
    FROM car_prices
    GROUP BY make
    ORDER BY avg_price ASC
    LIMIT 10
    """

    df = run_query(query)
    st.dataframe(df)

    st.subheader("Price vs Odometer")

    query = """
    SELECT odometer, sellingprice
    FROM car_prices
    WHERE odometer IS NOT NULL
    LIMIT 1000
    """


    df = run_query(query)
    st.scatter_chart(df, x="odometer", y="sellingprice")



elif menu == "Segmentation":
    st.header("Car Segmentation")
    
    

    colors = run_query("SELECT DISTINCT color FROM car_prices WHERE color IS NOT NULL")
    interiors = run_query("SELECT DISTINCT interior FROM car_prices WHERE interior IS NOT NULL")
    states = run_query("SELECT DISTINCT state FROM car_prices")
    
    state = st.selectbox("Select State", states["state"].dropna())
    color = st.selectbox("Select Exterior Color", colors["color"])
    interior = st.selectbox("Select Interior", interiors["interior"])
    budget = st.slider("Select Max Budget", 1000, 50000, 20000)
    

    query = """
    SELECT make, model, color, interior, sellingprice
    FROM car_prices
    WHERE color = ?
    AND interior = ?
    AND sellingprice <= ?
    AND state = ?
    LIMIT 20
    """

    df = run_query(query, (color, interior, budget, state))
    st.dataframe(df)
