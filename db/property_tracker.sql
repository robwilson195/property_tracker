DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  number_bedrooms INT2,
  buy_let_status VARCHAR(255)
);
