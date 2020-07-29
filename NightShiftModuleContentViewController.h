#import <ControlCenterUIKit/CCUIButtonModuleViewController.h>

@class NightShiftModule, CCUIModuleSliderView;

@interface NightShiftModuleContentViewController : CCUIButtonModuleViewController
@property (nonatomic, weak) NightShiftModule *module;
@property (nonatomic) CCUIModuleSliderView *sliderView;
@end
