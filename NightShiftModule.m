#import "NightShiftModule.h"


#import <ControlCenterUIKit/CCUIModuleSliderView.h>
#import <ControlCenterUI/CCUIModuleInstance.h>
#import <ControlCenterUI/CCUIModuleInstanceManager.h>

#import <objc/runtime.h>

@interface CCUIModuleInstanceManager (CCSupport)
- (CCUIModuleInstance*)instanceForModuleIdentifier:(NSString*)moduleIdentifier;
@end

#define kNightShiftIntensityMin 0.0
#define kNightShiftIntensityMax 1.0

float clamp(float val, float min, float max) {
	if (val < min)
		return min;
	else if (val > max)
		return max;
	else
		return val;
}

@implementation NightShiftModule
- (instancetype)init {
	self = [super init];

	_contentViewController = [[NightShiftModuleContentViewController alloc] init];
	_contentViewController.module = self;

	_backgroundViewController = [[NightShiftModuleBackgroundViewController alloc] init];
	_backgroundViewController.module = self;

	// setup brightness client
    _client = [[objc_getClass("CBClient") alloc] init];

	[self updateEnabled];

	//  set slider value to current blue light level
	float blueLightLevel;
	[_client.blueLightClient getStrength:&blueLightLevel];
	_contentViewController.sliderView.value = blueLightLevel;

	[_client.blueLightClient setStatusNotificationBlock: ^(void){
		[self updateEnabled];
	}];

	return self;
}

- (UIViewController *)contentViewController {
	return _contentViewController;
}

- (UIViewController *)backgroundViewController {
	return _backgroundViewController;
}

-(void)toggleEnabled {
	AnonymousStruct result;
	[_client.blueLightClient getBlueLightStatus: &result];
	[_client.blueLightClient setEnabled: !result.field2];
}

-(void)updateEnabled {
	dispatch_async(dispatch_get_main_queue(), ^{
		AnonymousStruct result;
		[_client.blueLightClient getBlueLightStatus: &result];
		[_contentViewController setSelected: result.field2];
	});
}

-(void)applyState {
	float newBlueLightLevel = clamp(_contentViewController.sliderView.value, kNightShiftIntensityMin, kNightShiftIntensityMax);
	[_client.blueLightClient setStrength:newBlueLightLevel withPeriod:0.0 commit:YES];
}
@end
