import streamlit as st
import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import LabelEncoder
import joblib

# Assuming the model and encoder are saved from the notebook
# In the notebook, you can add code to save them:
# joblib.dump(rf_model, 'rf_model.pkl')
# joblib.dump(le, 'label_encoder.pkl')
# And load them here

# Load the model and encoder (replace with actual paths if saved)
rf_model = joblib.load('Project\\rf_model.pkl')
le = joblib.load('Project\\label_encoder.pkl')

# Define the feature columns
features = ['year', 'make', 'model', 'trim', 'body', 'transmission', 'state', 'condition', 'odometer', 'color', 'interior', 'seller', 'mmr']

# Categorical columns that were encoded
categorical_cols = ['make', 'model', 'trim', 'body', 'transmission', 'state', 'color', 'interior', 'seller']

# For simplicity, assume we have the original unique values for selectboxes
# In practice, you should load or define these from the training data
# Example placeholders; replace with actual unique values from df
unique_values = {
    'make': ['Ford', 'Chevrolet', 'Toyota', 'Honda', 'Nissan'],  # Add all unique makes
    'model': ['F-150', 'Camry', 'Altima', 'Civic', 'Fusion'],  # Add all unique models
    'trim': ['Base', 'LX', 'EX', 'SE', 'XLT'],  # Add all unique trims
    'body': ['Sedan', 'SUV', 'Truck', 'Coupe', 'Wagon'],  # Add all unique bodies
    'transmission': ['automatic', 'manual'],  # Add all unique transmissions
    'state': ['ca', 'tx', 'fl', 'ny', 'il'],  # Add all unique states
    'color': ['white', 'black', 'silver', 'gray', 'blue'],  # Add all unique colors
    'interior': ['black', 'gray', 'beige', 'tan', 'brown'],  # Add all unique interiors
    'seller': ['nissan-infiniti lt', 'ford motor credit company,llc', 'the hertz corporation'],  # Add all unique sellers
}

st.title('Car Selling Price Prediction')

# Input fields
inputs = {}
for col in features:
    if col in categorical_cols:
        inputs[col] = st.selectbox(f'Select {col}', unique_values.get(col, []))
    elif col == 'year':
        inputs[col] = st.number_input('Year', min_value=1990, max_value=2023, value=2015)
    elif col == 'condition':
        inputs[col] = st.slider('Condition', 0.0, 5.0, 3.0)
    elif col == 'odometer':
        inputs[col] = st.number_input('Odometer', min_value=0, value=50000)
    elif col == 'mmr':
        inputs[col] = st.number_input('MMR', min_value=0, value=20000)

# Encode categorical inputs
input_df = pd.DataFrame([inputs])
for col in categorical_cols:
    if col in input_df.columns:
        input_df[col] = le.fit_transform(input_df[col])  # Assuming le is fitted on all categories

# Predict
if st.button('Predict Selling Price'):
    prediction = rf_model.predict(input_df)[0]
    st.write(f'Predicted Selling Price: ${prediction:.2f}')
