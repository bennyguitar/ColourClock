//
//  ViewController.m
//  ColourClock
//
//  Created by Ben Gordon on 12/20/12.
//  Copyright (c) 2012 Ben Gordon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    currentType = ClockTypeMilitary;
    [self changeColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Change Colors

-(void)changeColor {
    // Set up date formatters for hour, min, seconds.
    // Then create strings from the current date.
    NSDateFormatter *formatHour = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatMin = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatSec = [[NSDateFormatter alloc] init];
    [formatHour setDateFormat:@"HH"];
    [formatMin setDateFormat:@"mm"];
    [formatSec setDateFormat:@"ss"];
    NSString *hour = [formatHour stringFromDate:[NSDate date]];
    NSString *minute = [formatMin stringFromDate:[NSDate date]];
    NSString *second = [formatSec stringFromDate:[NSDate date]];
    
    
    // Create floats of the time value.
    float hourFloat = [hour floatValue] * 255.0f / 23.0f;
    float minFloat = [minute floatValue] * 255.0f / 59.0f;
    float secFloat = [second floatValue] * 255.0f / 59.0f;
    
    
    // Create unsigned ints for Hex translation
    int32_t hourint = hourFloat + 0.5;
    int32_t minint = minFloat + 0.5;
    int32_t secint = secFloat + 0.5;
    
    
    // Change text color so it's readable.
    if (hourFloat > 200 && minFloat > 200 && secFloat > 200) {
        timeLabel.textColor = [UIColor darkGrayColor];
        appearanceType.textColor = [UIColor darkGrayColor];
    }
    else {
        timeLabel.textColor = [UIColor whiteColor];
        appearanceType.textColor = [UIColor whiteColor];
    }
    
    
    // Set Labels
    if (currentType == ClockTypeMilitary) {
        appearanceType.text = @"MILITARY TIME";
        timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
    }
    else if (currentType == ClockTypeHex) {
        appearanceType.text = @"HEX COLOR CODE";
        timeLabel.text = [NSString stringWithFormat:@"#%02X%02X%02X",hourint,minint,secint];
    }
    else {
        appearanceType.text = @"RGB VALUES";
        timeLabel.text = [NSString stringWithFormat:@"%.0f:%.0f:%.0f", hourFloat, minFloat, secFloat];
    }
    
    
    // Finally, change image to the right color
    self.view.backgroundColor = [UIColor colorWithRed:(hourFloat/255.0f) green:(minFloat/255.0f) blue:(secFloat/255.0f) alpha:1.0];
    
    // And do it all over again, every .05 seconds so it's more accurate
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:0.05];
}




#pragma mark - Change Clock Type

- (IBAction)changeClockType:(id)sender {
    currentType++;
    
    if (currentType > ClockTypeRGB) {
        currentType = ClockTypeMilitary;
    }
}

@end
