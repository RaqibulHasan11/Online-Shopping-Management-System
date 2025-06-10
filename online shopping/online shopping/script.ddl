-- Drop tables if they exist
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE order_item CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE orders CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE payment CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE product CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE product_category CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

-- Create Tables
CREATE TABLE order_item (
    order_item_id    NUMBER NOT NULL,
    quantity         NUMBER NOT NULL,
    price            NUMBER NOT NULL,
    order_order_id   NUMBER
);

ALTER TABLE order_item ADD CONSTRAINT order_item_pk PRIMARY KEY (order_item_id);

CREATE TABLE orders (
    order_id             NUMBER NOT NULL,
    order_date           DATE,
    total_amount         NUMBER NOT NULL,
    status               VARCHAR2(50) NOT NULL,
    user_user_id         NUMBER,
    product_product_id   NUMBER,
    payment_payment_id   NUMBER
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY (order_id);

CREATE TABLE payment (
    payment_id       NUMBER NOT NULL,
    payment_date     DATE,
    amount           NUMBER NOT NULL,
    payment_method   VARCHAR2(50),
    payment_status   VARCHAR2(50) NOT NULL,
    order_order_id   NUMBER
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY (payment_id);

CREATE TABLE product (
    product_id                     NUMBER NOT NULL,
    p_name                         VARCHAR2(100),
    description                    VARCHAR2(500),
    price                          NUMBER NOT NULL,
    stock                          NUMBER NOT NULL,
    product_category_category_id   NUMBER
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY (product_id);

CREATE TABLE product_category (
    category_id   NUMBER NOT NULL,
    name          VARCHAR2(50) NOT NULL,
    description   VARCHAR2(500)
);

ALTER TABLE product_category ADD CONSTRAINT product_category_pk PRIMARY KEY (category_id);

CREATE TABLE users (
    user_id    NUMBER NOT NULL,
    name       VARCHAR2(100) NOT NULL,
    email      VARCHAR2(100) NOT NULL,
    password   VARCHAR2(100) NOT NULL,
    address    VARCHAR2(200),
    phone      VARCHAR2(15)
);

ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY (user_id);

-- Add Foreign Keys
ALTER TABLE order_item
    ADD CONSTRAINT order_item_order_fk FOREIGN KEY (order_order_id)
        REFERENCES orders (order_id);

ALTER TABLE orders
    ADD CONSTRAINT orders_payment_fk FOREIGN KEY (payment_payment_id)
        REFERENCES payment (payment_id);

ALTER TABLE orders
    ADD CONSTRAINT orders_product_fk FOREIGN KEY (product_product_id)
        REFERENCES product (product_id);

ALTER TABLE orders
    ADD CONSTRAINT orders_user_fk FOREIGN KEY (user_user_id)
        REFERENCES users (user_id);

ALTER TABLE payment
    ADD CONSTRAINT payment_order_fk FOREIGN KEY (order_order_id)
        REFERENCES orders (order_id);

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY (product_category_category_id)
        REFERENCES product_category (category_id);
