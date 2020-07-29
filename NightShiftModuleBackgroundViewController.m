#import "NightShiftModuleBackgroundViewController.h"

#import "NightShiftModule.h"


@implementation NightShiftModuleBackgroundViewController

- (instancetype)init {
	return [self initWithNibName:nil bundle:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	UIImage *glyph = [UIImage imageNamed:@"Icon_" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];

	self.glyphImage = glyph;//[glyph imageWithColor:UIColor.yellowColor];
	return self;
}

- (BOOL)_canShowWhileLocked {
	return YES;
}
@end
