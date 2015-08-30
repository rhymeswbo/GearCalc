//
//  FirstViewController.m
//  GearCalc
//
//  Created by giovannirey on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirstView.h"
#import "GearCalcAppDelegate.h"


@implementation FirstView
@synthesize gearPicker,tireWidthArray,chainRingArray,cogArray,gearLabelStd,gearLabelAct,rollOut,rollOutM;


float gearstd = 0;
float gearact = 0;
GearCalcAppDelegate *delegate;


#pragma mark -
#pragma mark UIPickerViewDelegate

-(void) updateCalcs {

	//my reference point for all calcs is 47x14 = 90.6std,  88.9 actual @23mm, 7079.97rollout 279.447
	gearstd =((90.6*ring/47) * 14/cog);
	gearact= (((88.9*ring/47) * 14/cog) * ( (673.1 - 2*23 + 2*tire)/673.1 ) );
	

	gearLabelStd.text = [NSString stringWithFormat:@"%03.2f",gearstd];
	gearLabelAct.text = [NSString stringWithFormat:@"%03.2f",gearact];
	rollOut.text = [NSString stringWithFormat:@"%05.2f",(279.447 * gearact/88.9)];
	rollOutM.text = [NSString stringWithFormat:@"%05.2f",(7097.97 * gearact/88.9)];
	
	delegate.gear = gearact;
	delegate.gearStd = gearstd;

	NSLog(@"updating calcs %f  %f",gearstd, gearact);
	
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(component == 0) tire = [[tireWidthArray objectAtIndex:row] intValue];
	else if (component == 1) ring = [[chainRingArray objectAtIndex:row] intValue];
	else if (component == 2) cog = [[cogArray objectAtIndex:row] intValue];
	
	NSLog(@"inputs == %@",[NSString stringWithFormat:@"%dmm - %dt - %dt",tire,ring,cog]  );
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
		returnStr = [NSString stringWithFormat:@"%dmm",[[tireWidthArray objectAtIndex:row]intValue]];
	}
	else if (component == 1 )
	{
		returnStr = [NSString stringWithFormat:@"%dt",[[chainRingArray objectAtIndex:row]intValue]];
	}
	else if (component == 2 )
	{
		returnStr = [NSString stringWithFormat:@"%dt",[[cogArray objectAtIndex:row]intValue]];
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
		depth = tireWidthArray.count;	// first column size is wider to hold names
	else if (component == 1)
		depth = chainRingArray.count;	// second column is narrower to show numbers
	else 
		depth = cogArray.count;
	
	return depth;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:@"firstView" bundle:nil];
	
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
-(void) viewDidAppear:(BOOL)animated {
	gearLabelStd.text = [NSString stringWithFormat:@"%03.2f",gearstd];
	gearLabelAct.text = [NSString stringWithFormat:@"%03.2f",gearact];
	rollOut.text = [NSString stringWithFormat:@"%05.2f",(279.447 * gearact/88.9)];
	rollOutM.text = [NSString stringWithFormat:@"%05.2f",(7097.97 * gearact/88.9)];
	
	[self updateCalcs];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"loading gear picker view");
	
	
	delegate = (GearCalcAppDelegate *)[[UIApplication sharedApplication] delegate];

	ring = 47;
	cog = 14;
	tire = 23;


	//gearLabelStd.text = @"0";
	//gearLabelAct.text = @"0";
	//rollOut.text = @"0";
	//rollOutM.text = @"0";

	gearLabelStd.text = [NSString stringWithFormat:@"%03.2f",gearstd];
	gearLabelAct.text = [NSString stringWithFormat:@"%03.2f",gearact];
	rollOut.text = [NSString stringWithFormat:@"%05.2f",(279.447 * gearact/88.9)];
	rollOutM.text = [NSString stringWithFormat:@"%05.2f",(7097.97 * gearact/88.9)];
	
	
	chainRingArray = [[NSMutableArray alloc] init];
	cogArray = [[NSMutableArray alloc] init];
	tireWidthArray = [[NSMutableArray alloc] init];

	for(int i=32; i<57 ; i++){
		[chainRingArray addObject:[NSNumber numberWithInt: i]];
	}
	for(int i=11; i<30 ; i++){
		[cogArray addObject:[NSNumber numberWithInt: i]];
	}
	for(int i=18; i<32 ; i++){
		[tireWidthArray addObject:[NSNumber numberWithInt: i]];
	}
	
	
	[gearPicker selectRow: tire-18 inComponent:0 animated:YES]; //tire
	[gearPicker selectRow: ring-32 inComponent:1 animated:YES]; //ring
	[gearPicker selectRow: cog-11 inComponent:2 animated:YES]; //cog
	
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
	[gearLabelStd release];
	[gearLabelAct release];
	[rollOut release];
	[rollOutM release];
	
	[chainRingArray release];
	[cogArray release];
	[tireWidthArray release];
	[gearPicker release];
    [super dealloc];
}

@end
