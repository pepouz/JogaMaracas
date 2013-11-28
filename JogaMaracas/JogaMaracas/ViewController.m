//
//  ViewController.m
//  JogaMaracas
//
//  Created by MiniPier on 28/11/2013.
//  Copyright (c) 2013 MiniPier. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	sounds = [[NSMutableArray alloc] initWithObjects:@"sound_1",
			  @"sound_2",
			  @"sound_3",
			  @"sound_4", nil];
	
	UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
	[picker setDataSource: self];
	[picker setDelegate: self];
	picker.showsSelectionIndicator = YES;
	[self.view addSubview:picker];
	
	self.motionManager = [[CMMotionManager alloc] init];
	self.motionManager.accelerometerUpdateInterval = 1;
	
	if ([self.motionManager isAccelerometerAvailable]) {
		NSOperationQueue *queue = [[NSOperationQueue alloc] init];
		[self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
			dispatch_async(dispatch_get_main_queue(), ^{
				if (![audioPlayer isPlaying]) {
					NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundSelected ofType:@"mp3"]];
					NSError *error;
					audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
					audioPlayer.numberOfLoops = -1;
					if (audioPlayer == nil) {
						NSLog(@"%@", [error description]);
					} else {
						[audioPlayer prepareToPlay];
						[audioPlayer play];
					}
				}
				self.xAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.x];
				self.yAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.y];
				self.zAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.z];
			});
		}];
	} else {
		NSLog(@"not active");
	}
}


#pragma mark -
#pragma UIPicker

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return sounds[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
	soundSelected = [NSString stringWithFormat:@"%@", sounds[(row)]];
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [sounds count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark -
#pragma Motion
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
	NSLog(@"%d", event.type);
	
	if (motion != UIEventSubtypeMotionShake)
		return;
	NSLog(@"BEGAN SHAKE");
	
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (motion != UIEventSubtypeMotionShake)
		return;
	NSLog(@"STOP SHAKE");
	[audioPlayer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
