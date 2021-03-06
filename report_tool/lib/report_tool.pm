package report_tool;
use Dancer ':syntax';

our $VERSION = '0.1';

use DB_DES;
use DBI;

get '/' => sub {
    template 'index', {
		MENU => \@MENU_DES,	
	};
};

get '/report/:table' => sub {
	my $params = params;

	my $table = $params->{'table'};

	my @link_tables = ();
	for my $k (keys %{ $DB_DES{$table}{'FIELDS'} }) {
		my $t = $DB_DES{$table}{'FIELDS'};
		if ($t->{$k}{'TYPE'} =~ /LINK\((\w+):(\w+)\)/) {
			$t->{$k}{'IS_LINK'} = 1;
			$t->{$k}{'LT'} = $1;
			$t->{$k}{'LF'} = $2;
			push @link_tables, $1;
		}
	}	

	template 'report', {
		DB_DES      => \%DB_DES,
		TABLE       => $table,
		LINK_TABLES => \@link_tables,
	};
};

post '/report/:table' => sub {
	my $params = params;

	my $table 		= $params->{'table'};
	my $marked 		= $params->{'ttt'};
	my $firstCondition	= $params->{'firstCondition'};
	my $secondCondition	= $params->{'secondCondition'};
	my $thirdCondition	= $params->{'thirdCondition'};
	my $cols;
	my @data;
	
	if(ref($marked) eq 'ARRAY')
	{
		$cols = join( ", ", @$marked );
	}
	else
	{
		$cols = $marked;
	}
	
	if (defined $cols)
	{
		my $dbh = db_connect();
		my $sth = $dbh->prepare("SELECT $cols FROM $table WHERE $firstCondition $secondCondition $thirdCondition ORDER BY $firstCondition");
		$sth->execute();
	

		while (my @test = $sth->fetchrow_array()) {
			push ( @data, @test );
		}

	}

	my @link_tables = ();
	for my $k (keys %{ $DB_DES{$table}{'FIELDS'} }) {
		my $t = $DB_DES{$table}{'FIELDS'};
		if ($t->{$k}{'TYPE'} =~ /LINK\((\w+):(\w+)\)/) {
			$t->{$k}{'IS_LINK'} = 1;
			$t->{$k}{'LT'} = $1;
			$t->{$k}{'LF'} = $2;
			push @link_tables, $1;
		}
	}	


	template 'report', {
		DB_DES		=> \%DB_DES,
		TABLE		=> $table,
		LINK_TABLES	=> \@link_tables,
		QUERY		=> $marked,
		FF		=> \@data,
	};

};

sub db_connect {
	
	my $db_connection_str = setting('DB_CONN_STR');
	my $dbh = DBI->connect($db_connection_str,,,{FetchHashKeyName => 'NAME_lc'}) or die "error: [$DBI::errstr] [$!]";

	return $dbh;
}

sub db_disconnect {
	my $dbh = shift;

	$dbh->disconnect();
}

true;
