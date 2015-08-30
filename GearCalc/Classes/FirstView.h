//
//  FirstViewController.h
//  GearCalc
//
//  Created by giovannirey on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	IBOutlet UIPickerView * gearPicker;

	
	IBOutlet UILabel * gearLabelStd;
	IBOutlet UILabel * gearLabelAct;
	IBOutlet UILabel * rollOut;
	IBOutlet UILabel * rollOutM;


	
	NSMutableArray* chainRingArray; 
	NSMutableArray* cogArray;
	NSMutableArray* tireWidthArray;
	
	NSInteger cog;
	NSInteger ring;
	NSInteger tire;
	
	
	
	
	
}

@property (nonatomic, retain)IBOutlet UIPickerView * gearPicker;

@property (nonatomic, retain)IBOutlet NSMutableArray* chainRingArray; 
@property (nonatomic, retain)IBOutlet NSMutableArray* cogArray;
@property (nonatomic, retain)IBOutlet NSMutableArray* tireWidthArray;

@property (nonatomic, retain)IBOutlet UILabel * gearLabelStd;
@property (nonatomic, retain)IBOutlet UILabel * gearLabelAct;
@property (nonatomic, retain)IBOutlet UILabel * rollOut;
@property (nonatomic, retain)IBOutlet UILabel * rollOutM;


@end
