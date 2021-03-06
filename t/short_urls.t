### tantek's new base 60

use Test::More qw(no_plan);

use DateTime;
use POSIX qw(ceil floor);

unshift @INC, ".";

use TinWhistle;

# structure

# content types
# - b blog post
# - t text or tweet
# - p photo

# sexigesimal days value
# - SSS

# post number
# - n

my @data = (
    {   short       => 't45v2',
        post_type   => 't',
        sss         => '45v',
        post_num    => '2',
        long_as_ord => '2010/146/t2',
        long_as_ymd => '2010/05/26/t2',
        year        => '2010',
        month       => '05',
        day         => '26',
    },
    {   short       => 't0942',
        post_type   => 't',
        sss         => '094',
        post_num    => '2',
        long_as_ord => '1971/180/t2',
        long_as_ymd => '1971/06/29/t2',
        year        => '1971',
        month       => '06',
        day         => '29',
    },
    {   short       => 't0012',
        post_type   => 't',
        sss         => '001',
        post_num    => '2',
        long_as_ord => '1970/002/t2',
        long_as_ymd => '1970/01/02/t2',
        year        => '1970',
        month       => '01',
        day         => '02',
    },
    {   short       => 'b45v3',
        post_type   => 'b',
        sss         => '45v',
        post_num    => '3',
        long_as_ord => '2010/146/b3',
        long_as_ymd => '2010/05/26/b3',
        year        => '2010',
        month       => '05',
        day         => '26',
    },
    {   short       => 'b0943',
        post_type   => 'b',
        sss         => '094',
        post_num    => '3',
        long_as_ord => '1971/180/b3',
        long_as_ymd => '1971/06/29/b3',
        year        => '1971',
        month       => '06',
        day         => '29',
    },
    {   short       => 'b0013',
        post_type   => 'b',
        sss         => '001',
        post_num    => '3',
        long_as_ord => '1970/002/b3',
        long_as_ymd => '1970/01/02/b3',
        year        => '1970',
        month       => '01',
        day         => '02',
    },
    {   short       => 'p45v12',
        post_type   => 'p',
        sss         => '45v',
        post_num    => '12',
        long_as_ord => '2010/146/p12',
        long_as_ymd => '2010/05/26/p12',
        year        => '2010',
        month       => '05',
        day         => '26',
    },
    {   short       => 'p09412',
        post_type   => 'p',
        sss         => '094',
        post_num    => '12',
        long_as_ord => '1971/180/p12',
        long_as_ymd => '1971/06/29/p12',
        year        => '1971',
        month       => '06',
        day         => '29',
    },
    {   short       => 'p00112',
        post_type   => 'p',
        sss         => '001',
        post_num    => '12',
        long_as_ord => '1970/002/p12',
        long_as_ymd => '1970/01/02/p12',
        year        => '1970',
        month       => '01',
        day         => '02',
    },
);

for my $dd (@data) {
    my $short_url = $dd->{short};
    my $d         = parse_short_url($short_url);

    is( $d->{post_type}, $dd->{post_type},
        'parse_short_url returns correct post type (' . $dd->{post_type} . ') for ' . $short_url );
    is( $d->{sss}, $dd->{sss},
        'parse_short_url returns correct sexagesimal days (' . $dd->{sss} . ') for ' . $short_url );
    is( $d->{post_num}, $dd->{post_num},
        'parse_short_url returns correct post number (' . $dd->{post_num} . ') for ' . $short_url );
    is( short_to_long_as_ord($short_url),
        $dd->{long_as_ord},
        'short_to_long_as_ord returns correct value (' . $dd->{long_as_ord} . ') for ' . $short_url );
    is( short_to_long_as_ymd($short_url),
        $dd->{long_as_ymd},
        'short_to_long_as_ymd returns correct value (' . $dd->{long_as_ymd} . ') for ' . $short_url );
    my $dt = DateTime->new(
        year  => $dd->{year},
        month => $dd->{month},
        day   => $dd->{day},
    );
    my $new_short_url = make_short_from_data( $dt, $d->{post_type}, $d->{post_num} );
    is( $new_short_url, $short_url,
              'make_short_from_data returns correct value ('
            . $short_url
            . ') for '
            . $dt . ', '
            . $d->{post_type} . ', '
            . $d->{post_num} );
    $new_short_url = make_short_from_url( $dd->{long_as_ord} );
    is( $new_short_url, $short_url,
        'make_short_from_url returns correct value (' . $short_url . ') for ' . $dd->{long_as_ord} );
    $new_short_url = make_short_from_url( $dd->{long_as_ymd} );
    is( $new_short_url, $short_url,
        'make_short_from_url returns correct value (' . $short_url . ') for ' . $dd->{long_as_ymd} );

}
