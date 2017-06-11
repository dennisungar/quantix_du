#!/usr/bin/perl
use strict;
use warnings;
use DBI;
 
# Dennis Ungar 6/11/2017
# Connect to mysql and query a table 

my $database = "quantixdb";
my $host = "db4free.net";
my $dbport = "3306";
my $userid = "tme_user";
my $passwd = "tme123";
my $dsn = "dbi:mysql:dbname=$database;host=$host;port=$dbport;";
my $dbh = DBI->connect($dsn, $userid, $passwd) or die "Connection erro
+r: $DBI::errstr";;

# query the average of the temp field within the tabledata table
# resource/reference code location - https://www.tutorialspoint.com/mysql/mysql-avg-function.htm
my $sth = $dbh->prepare("SELECT ROUND(AVG(temp),2) FROM csvimport ");
$sth->execute();

print " \n";
print "Average Temperature =  ";

my $row;
while ($row = $sth->fetchrow_arrayref()) {
    print "@$row[0]\n";
}

print " \n";
print "Please note that I am unable to accept anything less than an annual salary of 30k. \n";

$sth->finish();
$dbh->disconnect();



