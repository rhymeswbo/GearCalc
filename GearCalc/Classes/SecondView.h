//
//  SecondView.h
//  GearCalc
//
//  Created by giovannirey on 1/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView * cadencePicker;
	UILabel * gearStd;
	UILabel * kph;
	UILabel * mps;
	UILabel * mph;
	UILabel * f200t;
	UILabel * f250t;
	UILabel * f333t;
	UILabel * f1000t;
	UILabel * f4000t;
	UILabel * f16000t;
	
	NSInteger cadence;

}

@property (nonatomic, retain) IBOutlet UIPickerView * cadencePicker;
@property (nonatomic, retain) IBOutlet 	UILabel * gearStd;
@property (nonatomic, retain) IBOutlet 	UILabel * kph;
@property (nonatomic, retain) IBOutlet 	UILabel * mps;
@property (nonatomic, retain) IBOutlet 	UILabel * mph;
@property (nonatomic, retain) IBOutlet 	UILabel * f200t;
@property (nonatomic, retain) IBOutlet 	UILabel * f250t;
@property (nonatomic, retain) IBOutlet 	UILabel * f1000t;
@property (nonatomic, retain) IBOutlet 	UILabel * f4000t;
@property (nonatomic, retain) IBOutlet 	UILabel * f333t;
@property (nonatomic, retain) IBOutlet 	UILabel * f16000t;

@end
