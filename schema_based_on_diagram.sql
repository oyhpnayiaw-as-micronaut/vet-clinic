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

CREATE TABLE treatments (
  id serial PRIMARY KEY,
  type varchar(255) NOT NULL,
  name varchar(255) NOT NULL
);

CREATE TABLE invoice_items (
  id serial PRIMARY KEY,
  unit_price numeric(10,2) NOT NULL,
  quantity integer NOT NULL,
  total_price numeric(10,2) NOT NULL,
  invoice_id integer NOT NULL,
  treatment_id integer NOT NULL,
  CONSTRAINT fk_invoice_items_invoices
    FOREIGN KEY (invoice_id)
    REFERENCES invoices (id),
  CONSTRAINT fk_invoice_items_treatments
    FOREIGN KEY (treatment_id)
    REFERENCES treatments (id)
);

CREATE TABLE medical_histories_treatments (
  medical_history_id integer NOT NULL,
  treatment_id integer NOT NULL,
  CONSTRAINT fk_medical_histories_treatments_medical_histories
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories (id),
  CONSTRAINT fk_medical_histories_treatments_treatments
    FOREIGN KEY (treatment_id)
    REFERENCES treatments (id)
);

CREATE INDEX idx_medical_histories_patient_id ON medical_histories (patient_id);
CREATE INDEX idx_invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);
CREATE INDEX idx_medical_histories_treatments_medical_history_id ON medical_histories_treatments (medical_history_id);
CREATE INDEX idx_medical_histories_treatments_treatment_id ON medical_histories_treatments (treatment_id);
