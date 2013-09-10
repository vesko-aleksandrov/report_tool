#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $DBNAME = "/home/ceci/src/perl/staj/report_tool/etc/test.db";

my $DBH = DBI->connect("dbi:SQLite:dbname=$DBNAME");

my $TEST_ROWS_COUNT = $ARGV[0] || 10;

for (1..$TEST_ROWS_COUNT) {

	my $username = generate_random_string(10);
	my $kin      = gen_rand_kin();
	my $user_level = int(rand(3)) + 1;
	my $created_at = time - int(rand(20000));
	my $sth = $DBH->prepare("insert into USERS (NAME, KIN, USER_LEVEL, CREATED_AT) values (?,?,?,?) ");
	$sth->execute($username, $kin, $user_level, $created_at);

	my $user_id = $DBH->sqlite_last_insert_rowid();


	my $full_name  = generate_random_string(16);
	my $web_name   = substr($full_name, 0, 6);
	my $site_url   =  "http://" . generate_random_string(6) .".com";
	my $bulstat    = gen_rand_kin();
	my $billing    = int(rand(2));
	my $deposit    = int(rand(2));
	my $msgs_limit = $user_level * 1000;
	my $msgs_sent  = int(rand(100));
	my $account_balance = sprintf("%.2f", rand(1000));
	my $active   = int(rand(2));
	my $category = int(rand(10)) + 1;
	
	$sth = $DBH->prepare("insert into MERCHANTS (FULL_NAME, WEB_NAME, SITE_URL, BULSTAT, BILLING , DEPOSIT, MSGS_LIMIT, MSGS_SENT, ACCOUNT_BALANCE, ACTIVE, CATEGORY, USER_ID) VALUES (?,?,?,?,?,?,?,?,?,?,?,?) ");
	$sth->execute($full_name, $web_name, $site_url, $bulstat, $billing, $deposit, $msgs_limit, $msgs_sent, $account_balance, $active, $category, $user_id);
}




sub generate_random_string{
    my $len = shift; 

    my @chars=('a'..'z','A'..'Z','0'..'9','_');
    my $random_string;
    for(1..$len){
        # rand @chars will generate a random 
        # number between 0 and scalar @chars
        $random_string.=$chars[rand @chars];
    }

	return $random_string;
}

sub gen_rand_kin {
	my $kin;
	for (1..10) {
		$kin .= int(rand(10));
	}
}
