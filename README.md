# Fuel Price Analytics: End-to-End Data Portfolio Project

## 📊 Project Overview
This project provides a comprehensive analysis of historical fuel prices (Petrol & Diesel) across various Indian states. Using a combination of Python, SQL, and Streamlit, it explores price trends, regional disparities, and the impact of crude oil fluctuations on consumer pricing.

### 🚀 Key Features
- **Interactive Dashboard**: Real-time filtering by state, fuel type, and date range.
- **Trend Analysis**: Visual insights into historical price spikes and stability periods.
- **SQL Analytics**: Advanced database queries including window functions and moving averages.
- **Automated Data Pipeline**: Script to enrich base crude data into a multi-dimensional dataset.

## 🛠️ Technical Stack
- **Languages**: Python (Pandas, Plotly, Seaborn), SQL (PostgreSQL)
- **Tools**: Jupyter Notebook, Streamlit
- **Visualization**: Plotly Interactive Charts, Matplotlib

## 📂 Project Structure
- `app.py`: Streamlit dashboard application.
- `fuel_analysis.ipynb`: Comprehensive Exploratory Data Analysis (EDA) notebook.
- `queries.sql`: SQL schema and analytical queries.
- `data_prep.py`: Data enrichment and transformation script.
- `fuel_data_enriched.csv`: The processed dataset used for analysis.

## 📈 Key Insights
1. **Regional Pricing**: Rajasthan consistently records the highest fuel prices due to state-level taxation.
2. **Fuel Correlation**: Petrol and Diesel prices maintain a 0.95+ correlation with global Crude Oil price shifts.
3. **Volatility Peaks**: Major price spikes were detected in 2022, corresponding with global geopolitical events.
4. **State Disparity**: Metropolitan areas show a 3-5% price surplus compared to rural regions.

## ⚙️ How to Run
1. **Clone the repository**:
   ```bash
   git clone <repo-url>
   cd fuel_price_analysis
   ```
2. **Install dependencies**:
   ```bash
   pip install pandas streamlit plotly matplotlib seaborn
   ```
3. **Run the Dashboard**:
   ```bash
   streamlit run app.py
   ```

## 🎯 About the Author
Developed by **Arpita Tiwari** as part of a Data Analyst Portfolio Project.
