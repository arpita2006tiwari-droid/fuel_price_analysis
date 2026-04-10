import pandas as pd
import numpy as np
import os

# Define paths
INPUT_FILE = 'fuel_price.csv'
OUTPUT_FILE = 'fuel_data_enriched.csv'

def enrich_data():
    if not os.path.exists(INPUT_FILE):
        print(f"Error: {INPUT_FILE} not found.")
        return

    # Load original data
    df = pd.read_csv(INPUT_FILE)
    df['Date'] = pd.to_datetime(df['Date'])
    
    # List of Indian States and some major cities
    states_cities = {
        'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
        'Delhi': ['New Delhi'],
        'Karnataka': ['Bangalore', 'Mysore'],
        'Tamil Nadu': ['Chennai', 'Coimbatore'],
        'West Bengal': ['Kolkata', 'Darjeeling'],
        'Gujarat': ['Ahmedabad', 'Surat'],
        'Rajasthan': ['Jaipur', 'Udaipur'],
        'Uttar Pradesh': ['Lucknow', 'Kanpur']
    }
    
    states = list(states_cities.keys())
    
    enriched_rows = []
    
    for _, row in df.iterrows():
        # For each date and state, generate Petrol and Diesel prices
        for state in states:
            city = np.random.choice(states_cities[state])
            
            # Base logic: Petrol/Diesel prices are influenced by Crude but have taxes/margins
            # Petrol is usually Crude * multiplier + state_tax + base_margin
            # We'll add some randomness for different states
            state_tax_multiplier = 1.0 + (np.random.uniform(0.1, 0.25))
            
            crude = row['Crude_Oil_Price']
            
            # Generate Petrol Price
            petrol_price = (crude * 0.8) + (20 * state_tax_multiplier) + np.random.uniform(2, 5)
            # Generate Diesel Price
            diesel_price = (crude * 0.7) + (15 * state_tax_multiplier) + np.random.uniform(1, 4)
            
            # Add Petrol row
            enriched_rows.append({
                'Date': row['Date'],
                'State': state,
                'City': city,
                'Fuel_Type': 'Petrol',
                'Price_Per_Liter': round(petrol_price, 2)
            })
            
            # Add Diesel row
            enriched_rows.append({
                'Date': row['Date'],
                'State': state,
                'City': city,
                'Fuel_Type': 'Diesel',
                'Price_Per_Liter': round(diesel_price, 2)
            })
            
    enriched_df = pd.DataFrame(enriched_rows)
    
    # Save to CSV
    enriched_df.to_csv(OUTPUT_FILE, index=False)
    print(f"Enriched dataset saved to {OUTPUT_FILE}")
    print(f"Shape: {enriched_df.shape}")

if __name__ == "__main__":
    enrich_data()
