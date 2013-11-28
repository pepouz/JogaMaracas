//
//  ViewController.h
//  JogaMaracas
//
//  Created by MiniPier on 28/11/2013.
//  Copyright (c) 2013 MiniPier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
	
	AVAudioPlayer	*audioPlayer;
	
	NSMutableArray	*sounds;
	NSString		*soundSelected;
	
}

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) IBOutlet UILabel *xAxis;
@property (nonatomic, strong) IBOutlet UILabel *yAxis;
@property (nonatomic, strong) IBOutlet UILabel *zAxis;

@end
