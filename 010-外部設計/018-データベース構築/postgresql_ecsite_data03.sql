\encoding UTF8;

CREATE SEQUENCE SEQ_CAT_CATID;
CREATE SEQUENCE SEQ_ITEMS_ITEMID;
CREATE SEQUENCE SEQ_PURCHASE_ID;
CREATE SEQUENCE SEQ_PUR_DETAIL_ID;

ALTER SEQUENCE public.SEQ_CAT_CATID OWNER TO ecsite;
ALTER SEQUENCE public.SEQ_ITEMS_ITEMID OWNER TO ecsite;
ALTER SEQUENCE public.SEQ_PURCHASE_ID OWNER TO ecsite;
ALTER SEQUENCE public.SEQ_PUR_DETAIL_ID OWNER TO ecsite;

CREATE TABLE users (
	user_id		VARCHAR(255)	PRIMARY KEY,
	password	VARCHAR(255)		NOT NULL,
	user_name		VARCHAR(32),
	address		VARCHAR(255)
);
ALTER TABLE public.users OWNER TO ecsite;

CREATE TABLE categories (
	category_id		INTEGER			PRIMARY KEY DEFAULT NEXTVAL('SEQ_CAT_CATID'),
	category_name			VARCHAR(255)	NOT NULL
);
ALTER TABLE public.categories OWNER TO ecsite;

CREATE TABLE items (
	item_id			INTEGER			PRIMARY KEY DEFAULT NEXTVAL('SEQ_ITEMS_ITEMID'),
	item_name			VARCHAR(128)	NOT NULL,
	manufacturer	VARCHAR(32),
	category_id		INTEGER			NOT NULL,
	color			VARCHAR(16),
	price			INTEGER			NOT NULL DEFAULT 0,
	stock			INTEGER			NOT NULL DEFAULT 0,
	recommended		BOOLEAN			NOT NULL DEFAULT FALSE,
	FOREIGN KEY (category_id) REFERENCES categories (category_id)
);
ALTER TABLE public.items OWNER TO ecsite;

CREATE TABLE items_in_cart (
	user_id		VARCHAR(255),
	item_id		INTEGER,
	amount		INTEGER		NOT NULL,
	booked_date	DATE		NOT NULL,
	PRIMARY KEY (user_id, item_id),
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	FOREIGN KEY (item_id) REFERENCES items (item_id)
);
ALTER TABLE public.items_in_cart OWNER TO ecsite;

CREATE TABLE purchases (
	purchase_id		INTEGER			PRIMARY KEY DEFAULT NEXTVAL('SEQ_PURCHASE_ID'),
	purchased_user	VARCHAR(255)	NOT NULL,
	purchased_date	DATE			NOT NULL,
	destination		VARCHAR(255),
	cancel			BOOLEAN			NOT NULL DEFAULT FALSE,
	FOREIGN KEY (purchased_user) REFERENCES users (user_id)
);
ALTER TABLE public.purchases OWNER TO ecsite;

CREATE TABLE purchase_details (
	purchase_detail_id	INTEGER	PRIMARY KEY DEFAULT NEXTVAL('SEQ_PUR_DETAIL_ID'),
	purchase_id			INTEGER		NOT NULL,
	item_id				INTEGER		NOT NULL,
	amount				INTEGER		NOT NULL,
	FOREIGN KEY (purchase_id) REFERENCES purchases (purchase_id),
	FOREIGN KEY (item_id) REFERENCES items (item_id)
);
ALTER TABLE public.purchase_details OWNER TO ecsite;

CREATE TABLE administrators (
	admin_id		VARCHAR(255)	PRIMARY KEY,
	password		VARCHAR(255)		NOT NULL,
	admin_name			VARCHAR(32)
);
ALTER TABLE public.administrators OWNER TO ecsite;

INSERT INTO administrators (admin_id, password, admin_name) VALUES ('admin', 'admin', '管理者');

INSERT INTO categories (category_id,category_name) VALUES (0,'すべて');
INSERT INTO categories (category_id,category_name) VALUES (1,'帽子');
INSERT INTO categories (category_id,category_name) VALUES (2,'鞄');


INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄A','東京鞄店',2,'青色',1980,18,TRUE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄B','東京鞄店',2,'緑色',4980,15,FALSE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄E','(株)鞄',2,'紺色',2200,3,FALSE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄G','日本鞄製造',2,'黄色',2980,6,FALSE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄H','日本鞄製造',2,'茶色',780,17,TRUE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄F','(株)鞄',2,'赤色',2500,9,TRUE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄C','東京鞄店',2,'青色',1800,20,TRUE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄D','東京鞄店',2,'緑色',1980,2,FALSE);
INSERT INTO items (item_name,manufacturer,category_id,color,price,stock,recommended) VALUES ('鞄I','日本鞄製造',2,'茶色',690,1,FALSE);

