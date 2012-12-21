//
//  ViewController.h
//  ColourClock
//
//  Created by Ben Gordon on 12/20/12.
//  Copyright (c) 2012 Ben Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

enum ClockType {
    ClockTypeMilitary = 0,
    ClockTypeHex = 1,
    ClockTypeRGB = 2
};

@interface ViewController : UIViewController {
    
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *appearanceType;
    
    enum ClockType currentType;
}


- (IBAction)changeClockType:(id)sender;

@end
