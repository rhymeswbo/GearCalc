//
//  SecondViewController.m
//  GearCalc
//
//  Created by giovannirey on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecondView.h"
#import "GearCalcAppDelegate.h"


@implementation SecondView
@synthesize cadencePicker;

@synthesize gearStd;
@synthesize kph;
@synthesize mps;
@synthesize mph;
@synthesize f200t;
@synthesize f250t;
@synthesize f333t;
@synthesize f1000t;
@synthesize f4000t;
@synthesize f16000t;

NSMutableArray* cadenceArray; 
GearCalcAppDelegate *delegate;


#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString*)stringWithFormat:(NSString *)format array:(NSArray*) arguments;
{
    char *argList = (char *)malloc(sizeof(NSString *) * [arguments count]);
    [arguments getObjects:(id *)argList];
    NSString* result = [[[NSString alloc] initWithFormat:format arguments:argList] autorelease];
    free(argList);
    return result;
}



- (NSString*) formatTime: (float) seconds{
	int secs = (int) seconds;
	double millis = seconds - secs; 
	int mins = ((int) secs/60) % 60;
	secs = secs %60;
	NSString* text = [NSString stringWithFormat:@"%d:%02d.%02d",mins,secs,(int)(100*millis) ];
	
	////NSLog(@"  string formated ::   %@",text);
	return text;
}

-(void) updateCalcs {
	
	//my reference point for all calcs is 47x14 = 90.6std,  88.9 actual @23mm, 7079.97rollout 279.447

	float kph_ = delegate.gear/88.9 * cadence/150.26 * 64;
	float mps_ = kph_ * 10/36;
	gearStd.text = [NSString stringWithFormat:@"%02.2f",delegate.gearStd];
	kph.text = [NSString stringWithFormat:@"%02.2f",kph_];
	mps.text = [NSString stringWithFormat:@"%02.2f",mps_];
	mph.text = [NSString stringWithFormat:@"%02.2f",kph_ /1.6];
	f200t.text = [NSString stringWithFormat:@"%02.2f",200/mps_];
	f250t.text = [NSString stringWithFormat:@"%02.2f",250/mps_];
	f333t.text = [NSString stringWithFormat:@"%02.2f",333/mps_];
	
	
	f1000t.text = [self formatTime:1000/mps_];
	f4000t.text = [self formatTime:4000/mps_];
	f16000t.text = [self formatTime:16000/mps_];
		
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(component == 0) cadence = [[cadenceArray objectAtIndex:row] intValue];
	[self updateCalcs];
	
}





#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	if ( component == 0 )
	{
		returnStr = [NSString stringWithFormat:@"%@ rpm",[cadenceArray objectAtIndex:row]];
	}

	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
	
	if (component == 0)
		componentWidth = 100.0;	// first column size is wider to hold names
	else if (component == 1)
		componentWidth = 90.0;	// second column is narrower to show numbers
	else 
		componentWidth = 90.0;
	
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	NSInteger depth;
	if (component == 0)
		depth = cadenceArray.count;	// first column size is wider to hold names

	return depth;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:@"SecondView" bundle:nil];
	
	if (self) {
        // Custom initialization
    }
    return self;
}


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void) viewDidAppear:(BOOL)animated {
	[self updateCalcs];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"loading gear picker view");
	
	
	delegate = (GearCalcAppDelegate *)[[UIApplication sharedApplication] delegate];

	
	cadenceArray = [[NSMutableArray alloc] init];
	cadence = 110;
	
	for(int i=50; i<300 ; i++){
		[cadenceArray addObject:[NSNumber numberWithInt: i]];
	}
	
	
	
	[cadencePicker selectRow: cadence-50 inComponent:0 animated:YES]; 

	
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[ gearStd release];
	[ kph release];
	[ mps release];
	[ mph release];
	[ f200t release];
	[ f250t release];
	[ f333t release];
	[ f1000t release];
	[ f4000t release];
	[ f16000t release];
	[cadenceArray release];
	[cadencePicker release];
    [super dealloc];
}

@end
