# -*- mode: sh -*-

vcsh status 2>/dev/null | perl -ne '
BEGIN
{
    my $repo = "";
}

if ($_ =~ /^\S+:/)
{
    $repo = $_;
    next;
}

if (/^$/)
{
    $repo = "";
    next;
}
if ($repo ne "")
{
    print $repo;
}
$repo = "";
print;
'
