import streamlit as st
import pandas as pd
import plotly.express as px

# Page config
st.set_page_config(page_title="OLA Ride Insights", layout="wide")

st.markdown("""
<style>
    .stApp {
        background-color: #eefac8 ;
    }
</style>
""", unsafe_allow_html=True)

st.title("OLA Ride Insights Dashboard")

# Load Data
@st.cache_data
def load_data():
    return pd.read_csv("OLA_Cleaned_Data1.csv")

df = load_data()


# Sidebar Filters
st.sidebar.header("Filters")

vehicle = st.sidebar.multiselect(
    "Select Vehicle Type",
    options=df["Vehicle_Type"].unique(),
    default=df["Vehicle_Type"].unique()
)

payment = st.sidebar.multiselect(
    "Select Payment Method",
    options=df["Payment_Method"].unique(),
    default=df["Payment_Method"].unique()
)

# Filter data
filtered_df = df[
    (df["Vehicle_Type"].isin(vehicle)) &
    (df["Payment_Method"].isin(payment))
]

# KPIs
total_rides = len(filtered_df)
total_revenue = filtered_df["Booking_Value"].sum()
successful_rides = len(filtered_df[filtered_df["Booking_Status"] == "Success"])
success_rate = (successful_rides / total_rides) * 100 if total_rides > 0 else 0

col1, col2, col3, col4 = st.columns(4)

col1.metric("Total Rides", total_rides)
col2.metric("Total Revenue", f"₹ {total_revenue:,.0f}")
col3.metric("Successful Rides", successful_rides)
col4.metric("Success Rate %", f"{success_rate:.2f}%")

st.markdown("---")

# Revenue by Payment Method
st.subheader("Revenue by Payment Method")
payment_chart = px.bar(
    filtered_df.groupby("Payment_Method")["Booking_Value"].sum().reset_index(),
    x="Payment_Method",
    y="Booking_Value"
)
st.plotly_chart(payment_chart, use_container_width=True)

# Booking Status Breakdown
st.subheader("Booking Status Breakdown")
status_chart = px.pie(
    filtered_df,
    names="Booking_Status"
)
st.plotly_chart(status_chart, use_container_width=True)

st.subheader("Top Vehicle Types")

vehicle_chart = px.bar(
    filtered_df.groupby("Vehicle_Type")["Booking_Value"].sum().reset_index(),
    x="Vehicle_Type",
    y="Booking_Value"
)
st.plotly_chart(vehicle_chart, use_container_width=True)

st.subheader("Cancellation Analysis")

cancel_data = filtered_df[filtered_df["Booking_Status"] != "Success"]

cancel_chart = px.histogram(
    cancel_data,
    x="Booking_Status"
)

st.plotly_chart(cancel_chart, use_container_width=True)



