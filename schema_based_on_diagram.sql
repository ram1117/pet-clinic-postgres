CREATE TABLE patients (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(255),
date_of_birth DATE
);

CREATE TABLE treatments (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
type VARCHAR(255),
name VARCHAR(255)
);

CREATE TABLE medical_histories (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
admitted_at TIMESTAMP,
patient_id INT REFERENCES patients(id),
status VARCHAR(255)
);

CREATE INDEX mh_patientid_asc ON medical_histories (patient_id ASC);

-- join table for medical histories and treatments table

CREATE TABLE treatment_join (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  med_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id)
);

CREATE INDEX tr_historyid_asc ON treatment_join (med_history_id  ASC);
CREATE INDEX tr_treatmentid_asc ON treatment_join (treatment_id  ASC);


CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price FLOAT,
  quantity INT,
  total_price FLOAT,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id)
);

CREATE INDEX invitems_invid_asc ON invoice_items (invoice_id ASC);
CREATE INDEX invitems_treatmentid_asc ON invoice_items (treatment_id ASC);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount FLOAT,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  med_history_id INT REFERENCES medical_histories(id)
);

CREATE INDEX invoices_mhistoryid_asc ON invoices (med_history_id ASC);