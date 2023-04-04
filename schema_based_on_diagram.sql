DROP DATABASE clinic;

CREATE DATABASE clinic;

\c clinic;

CREATE TABLE patients (
  id serial PRIMARY KEY,
  name varchar(255) NOT NULL,
  date_of_birth date NOT NULL
);

CREATE TABLE medical_histories (
  id serial PRIMARY KEY,
  admitted_at timestamp NOT NULL,
  patient_id integer NOT NULL,
  status varchar(255) NOT NULL,
  CONSTRAINT fk_medical_histories_patients
    FOREIGN KEY (patient_id)
    REFERENCES patients (id)
);

CREATE TABLE invoices (
  id serial PRIMARY KEY,
  total_amount numeric(10,2) NOT NULL,
  generated_at timestamp NOT NULL,
  payed_at timestamp,
  medical_history_id integer NOT NULL,
  CONSTRAINT fk_invoices_medical_histories
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories (id)
);

