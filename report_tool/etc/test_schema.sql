CREATE TABLE MERCHANTS (
		ID integer primary key autoincrement,
		FULL_NAME text,
		WEB_NAME text,
		SITE_URL text,
		BULSTAT text,
		BILLING integer,
		DEPOSIT integer,
		MSGS_LIMIT integer,
		MSGS_SENT integer,
		ACCOUNT_BALANCE real,
		ACTIVE integer,
		CATEGORY integer,
		USER_ID integer
);

CREATE TABLE CATEGORIES (
		ID integer primary key autoincrement,
		NAME text,
		PRIO integer
);

CREATE TABLE USERS (
        ID integer primary key autoincrement,
        NAME text,
        KIN text,
		USER_LEVEL integer,
		CREATED_AT integer
);

CREATE TABLE USER_LEVELS (
        ID integer primary key autoincrement,
        NAME text
);
