package DB_DES;

use utf8;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT = qw(
	@MENU_DES
	%DB_DES
);

our @MENU_DES = (
	{ TABLE => 'MERCHANTS',  LABEL => 'Търговци',},
	{ TABLE => 'USERS',      LABEL => 'Потребители',},
);

our %DB_DES = (

	MERCHANTS => {
		LABEL => 'Търговци',
		FIELDS => {
			FULL_NAME => {
				LABEL => 'Пълно име',
				TYPE  => 'CHAR(64)'
			},
			WEB_NAME => {
				LABEL => 'Търговско име',
				TYPE  => 'CHAR(64)',
			},
			SITE_URL => {
				LABEL => 'WEB адрес',
				TYPE  => 'CHAR(64)',
			},
			BULSTAT    => {
				LABEL => 'Булстат',
				TYPE  => 'CHAR(16)',
			},
			BILLING    => {
				LABEL  => 'Тип - билинг',
				TYPE   => 'BOOLEAN',
			},

			DEPOSIT    => {
				LABEL  => 'Тип - депозит',
				TYPE  => 'BOOLEAN',
			},

			MSGS_LIMIT => {
				LABEL => 'Лимит на изходящи съобщения',
				TYPE  => "INT",
			},
			MSGS_SENT  => {
				LABEL => "Изпратени съобщения",
				TYPE  => "INT",
			},
			ACCOUNT_BALANCE => {
				LABEL => 'Баланс по сметката',
				TYPE  => 'REAL',
			},
			ACTIVE => {
				LABEL => "Активен",
				TYPE  => "BOOLEAN",
			},
			CATEGORY => {
				LABEL => "Категория",
				TYPE  => "LINK(CATEGORIES:NAME)",
			},
			USER_ID => {
				LABEL => "Потребител",
				TYPE  => "LINK(USERS:NAME)"
			},
		},
	},

	CATEGORIES => {
		LABEL => 'Категории',
		FIELDS => {
			NAME => {
				LABEL => "Име",
				TYPE  => "CHAR(64)",
			},
			PRIO => {
				LABEL => "Приоритет",
				TYPE  => "INT",
			},
		},
	},

	USERS => {
		LABEL  => 'Персонални данни',
		FIELDS => {
			NAME => {
				LABEL => 'Потребителско име',
				TYPE  => 'CHAR(32)',	
			},
			KIN  => {
				LABEL => 'Клиентски номер',
				TYPE  => 'CHAR(16)',
			},
			USER_LEVEL => {
				LABEL => 'Потребителско ниво',
				TYPE  => 'LINK(USER_LEVELS:NAME)',
			},
			CREATED_AT => {
				LABEL => "Дата и час на регистрация",
				TYPE  => "DATE",
			},
		},
	},

	USER_LEVELS => {
		LABEL => 'Потребителски нива',
		FIELDS => {
			NAME => {
				LABEL => 'Име',
				TYPE  => 'CHAR(32)',
			},
		},
	},

);

1;
