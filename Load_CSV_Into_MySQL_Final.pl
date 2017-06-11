#!/usr/bin/perl
use strict;
use warnings;
use DBI;
 
# resource/reference code edited by Dennis Ungar 6/11/2017
# resource/reference code - location - http://www.scytheofwise.com/csv-insert-mysql-in-perl/
# Assumption - csv file is located in same directory as this script. DENNIS UNGAR
# Assumption - first row in csv file will always be the field names.
 

my $file = "tabledata.csv";
my @fields;
my $database = "quantixdb";
my $host = "db4free.net";
my $dbport = "3306";
my $userid = "tme_user";
my $passwd = "tme123";
my $dsn = "dbi:mysql:dbname=$database;host=$host;port=$dbport;";
my $dbh = DBI->connect($dsn, $userid, $passwd) or die "Connection erro
+r: $DBI::errstr";;

 
#Drop table if it exists
$dbh->do("DROP TABLE if exists csvimport");
 
#Create table 
$dbh->do("CREATE TABLE csvimport (name VARCHAR(25), day INT(2), temp DECIMAL (3,1))");

 
open(my $data, '<', $file) or die "Could not open '$file' $!\n";
 
while (my $line = <$data>)
{
    next if $. == 1;  # resource/reference code - https://stackoverflow.com/questions/41008744/loading-text-file-onto-mysql-skip-first-row  skips the process of inserting the first row of the csv file
    chomp $line;
    @fields = split "," , $line;
    pushvalues(@fields);
}
 
sub pushvalues
{
    my @toinsert = @_;
    my $rowinsert = $dbh->prepare("INSERT INTO csvimport VALUES(?,?,?)");
    $rowinsert->execute($toinsert[0],$toinsert[1],$toinsert[2]);
}

# Validate Insertion of values to table
# resource/reference code -  http://zetcode.com/db/mysqlperl/queries/
my $sth = $dbh->prepare("SELECT * FROM csvimport LIMIT 5");
$sth->execute();

print "Insertion Validation:\n";
my $row;
while ($row = $sth->fetchrow_arrayref()) {
	    print "@$row[0] @$row[1] @$row[2]\n";
}
print "\n";
print "Insertion validated and I am ready for my final interview. \n";
print "Will Quantix provide me with stock options and a decent health plan? \n"; 
print "I get sick sometimes and typically require 4 mental health days per month.\n";
$sth->finish();
$dbh->disconnect();



