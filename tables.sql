-- Compassion Tracker Database Schema
-- This file creates all necessary tables for the application

-- Enable UUID extension if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255),
    email_notifications BOOLEAN DEFAULT true,
    sms_notifications BOOLEAN DEFAULT false,
    medication_reminders BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Care recipients table
CREATE TABLE IF NOT EXISTS care_recipients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) DEFAULT 'blue',
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- WebAuthn credentials table
CREATE TABLE IF NOT EXISTS webauthn_credentials (
    id VARCHAR(255) PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
    public_key TEXT NOT NULL,
    counter INTEGER NOT NULL,
    device_type VARCHAR(255) NOT NULL,
    backed_up BOOLEAN NOT NULL,
    transports TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Medications table
CREATE TABLE IF NOT EXISTS medications (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dosage VARCHAR(255) NOT NULL,
    instructions TEXT,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    current_inventory INTEGER DEFAULT 0,
    reorder_threshold INTEGER DEFAULT 5,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Medication schedules table
CREATE TABLE IF NOT EXISTS medication_schedules (
    id SERIAL PRIMARY KEY,
    medication_id INTEGER REFERENCES medications(id) ON DELETE CASCADE NOT NULL,
    time_of_day TIME NOT NULL,
    days_of_week TEXT[] NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Medication logs table
CREATE TABLE IF NOT EXISTS medication_logs (
    id SERIAL PRIMARY KEY,
    medication_id INTEGER REFERENCES medications(id) ON DELETE CASCADE NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    taken_at TIMESTAMP NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Appointments table
CREATE TABLE IF NOT EXISTS appointments (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME,
    location VARCHAR(255),
    notes TEXT,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Meals table
CREATE TABLE IF NOT EXISTS meals (
    id SERIAL PRIMARY KEY,
    meal_type VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    consumed_at TIMESTAMP NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Bowel movements table
CREATE TABLE IF NOT EXISTS bowel_movements (
    id SERIAL PRIMARY KEY,
    consistency VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL,
    notes TEXT,
    occurred_at TIMESTAMP NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Urination table
CREATE TABLE IF NOT EXISTS urination (
    id SERIAL PRIMARY KEY,
    color VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    volume INTEGER,
    urgency VARCHAR(50),
    notes TEXT,
    occurred_at TIMESTAMP NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Supplies table
CREATE TABLE IF NOT EXISTS supplies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    current_stock INTEGER DEFAULT 0,
    reorder_threshold INTEGER DEFAULT 5,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Supply usages table
CREATE TABLE IF NOT EXISTS supply_usages (
    id SERIAL PRIMARY KEY,
    supply_id INTEGER REFERENCES supplies(id) ON DELETE CASCADE NOT NULL,
    quantity_used INTEGER NOT NULL,
    used_at TIMESTAMP NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Sleep table
CREATE TABLE IF NOT EXISTS sleep (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    quality VARCHAR(50),
    notes TEXT,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Notes table
CREATE TABLE IF NOT EXISTS notes (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Inspiration messages table
CREATE TABLE IF NOT EXISTS inspiration_messages (
    id SERIAL PRIMARY KEY,
    message TEXT NOT NULL,
    author VARCHAR(255),
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Doctors table
CREATE TABLE IF NOT EXISTS doctors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    specialty VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    address TEXT,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Pharmacies table
CREATE TABLE IF NOT EXISTS pharmacies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    address TEXT,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Medication pharmacies relation table
CREATE TABLE IF NOT EXISTS medication_pharmacies (
    id SERIAL PRIMARY KEY,
    medication_id INTEGER REFERENCES medications(id) ON DELETE CASCADE NOT NULL,
    pharmacy_id INTEGER REFERENCES pharmacies(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(medication_id, pharmacy_id)
);

-- Emergency info table
CREATE TABLE IF NOT EXISTS emergency_info (
    id SERIAL PRIMARY KEY,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    date_of_birth DATE,
    social_security_number VARCHAR(255),
    insurance_provider VARCHAR(255),
    insurance_policy_number VARCHAR(255),
    primary_physician VARCHAR(255),
    primary_physician_phone VARCHAR(255),
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(255),
    emergency_contact_relationship VARCHAR(255),
    medical_conditions TEXT,
    allergies TEXT,
    current_medications TEXT,
    special_instructions TEXT,
    pin_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Blood pressure table
CREATE TABLE IF NOT EXISTS blood_pressure (
    id SERIAL PRIMARY KEY,
    systolic INTEGER NOT NULL,
    diastolic INTEGER NOT NULL,
    pulse INTEGER,
    notes TEXT,
    measured_at TIMESTAMP NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Glucose table
CREATE TABLE IF NOT EXISTS glucose (
    id SERIAL PRIMARY KEY,
    level INTEGER NOT NULL,
    measurement_type VARCHAR(50) NOT NULL,
    notes TEXT,
    measured_at TIMESTAMP NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Insulin table
CREATE TABLE IF NOT EXISTS insulin (
    id SERIAL PRIMARY KEY,
    units INTEGER NOT NULL,
    insulin_type VARCHAR(100) NOT NULL,
    injection_site VARCHAR(100),
    notes TEXT,
    administered_at TIMESTAMP NOT NULL,
    care_recipient_id INTEGER REFERENCES care_recipients(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_care_recipients_user_id ON care_recipients(user_id);
CREATE INDEX IF NOT EXISTS idx_medications_care_recipient_id ON medications(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_medication_logs_care_recipient_id ON medication_logs(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_care_recipient_id ON appointments(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_meals_care_recipient_id ON meals(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_bowel_movements_care_recipient_id ON bowel_movements(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_urination_care_recipient_id ON urination(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_sleep_care_recipient_id ON sleep(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_notes_care_recipient_id ON notes(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_emergency_info_care_recipient_id ON emergency_info(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_blood_pressure_care_recipient_id ON blood_pressure(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_glucose_care_recipient_id ON glucose(care_recipient_id);
CREATE INDEX IF NOT EXISTS idx_insulin_care_recipient_id ON insulin(care_recipient_id);

-- Insert some initial inspiration messages
INSERT INTO inspiration_messages (message, author, active) VALUES
('Every small step you take in caring for your loved one makes a meaningful difference.', 'Compassion Tracker Team', true),
('Your dedication and love shine through in every moment of care you provide.', 'Compassion Tracker Team', true),
('Remember that taking care of yourself is also part of taking care of those you love.', 'Compassion Tracker Team', true),
('You are stronger than you know and more appreciated than you realize.', 'Compassion Tracker Team', true),
('Each day of caregiving is a testament to the depth of your compassion.', 'Compassion Tracker Team', true)
ON CONFLICT DO NOTHING;