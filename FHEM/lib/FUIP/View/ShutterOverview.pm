package FUIP::View::ShutterOverview;

use strict;
use warnings;

    use lib::FUIP::View;
	use parent -norequire, 'FUIP::View';


	sub getHTML($){
		my ($self) = @_;
		my $device = $self->{device};
		my (undef,$height) = $self->dimensions();
		my $result = '
			<table style="width:100%;height:'.$height.'px !important;"><tr><td>
			<div data-type="symbol" data-device="'.$device.'" data-get="'.$self->{readingLevel}.'"
                    data-icons=\'["oa-fts_shutter_100","oa-fts_shutter_90",
								"oa-fts_shutter_80","oa-fts_shutter_70","oa-fts_shutter_60","oa-fts_shutter_50",
								"oa-fts_shutter_40","oa-fts_shutter_30","oa-fts_shutter_20","oa-fts_shutter_10","oa-fts_window_2w"]\'
					data-states=\'[';			
		for (my $i=0; $i <= 10; $i++) {
			$result .= "," if($i);
			use integer;
			$result .= '"'.($self->{minLevel} + ($self->{maxLevel} - $self->{minLevel}) * $i / 10).'"';
		};	
		$result .= ']\' 
					data-colors=\'["#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A","#2A2A2A"]\' 
					data-background-colors=\'["#aa6900","#aa6900","#aa6900","#aa6900","#aa6900","#aa6900","#aa6900","#aa6900","#aa6900","#aa6900","#aa6900"]\' 
					data-background-icons=\'["fa-square","fa-square","fa-square","fa-square","fa-square","fa-square","fa-square","fa-square","fa-square","fa-square","fa-square"]\'>
			</div>
			</td></tr>';
		if($self->{label}) {
			$result .= '<tr><td class="fuip-color">'.$self->{label}.'</td></tr>';
		};	
		$result .= '</table>';	
		return $result;
	};

	
	sub dimensions($;$$){
		my $self = shift;
		# we ignore any settings
		my $height = 70;
		$height += 10 if($self->{label});
		return (70, $height);
	};	
	
	
	sub getStructure($) {
	# class method
	# returns general structure of the view without instance values
	my ($class) = @_;
	return [
		{ id => "class", type => "class", value => $class },
		{ id => "device", type => "device" },
		{ id => "title", type => "text", default => { type => "field", value => "device"} },
		{ id => "label", type => "text", default => { type => "field", value => "title"} },
		{ id => "readingLevel", type => "reading", refdevice => "device", default => { type => "const", value => "level"}},
		{ id => "minLevel", type => "text", default => { type => "const", value => "0" } },
		{ id => "maxLevel", type => "text", default => { type => "const", value => "100" } },
		{ id => "popup", type => "dialog", default=> { type => "const", value => "inactive"} }	
		];
};

# register me as selectable
$FUIP::View::selectableViews{"FUIP::View::ShutterOverview"}{title} = "Shutter (overview)"; 
	
1;	