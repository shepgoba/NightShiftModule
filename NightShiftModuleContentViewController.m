#import "NightShiftModuleContentViewController.h"

#import "NightShiftModule.h"
#import <ControlCenterUIKit/CCUIModuleSliderView.h>
#import <ControlCenterUIKit/CCUIButtonModuleView.h>
  
#if defined __cplusplus
extern "C" {
#endif

CGFloat CCUISliderExpandedContentModuleHeight();
CGFloat CCUISliderExpandedContentModuleWidth();

CGFloat CCUIExpandedModuleContinuousCornerRadius();
CGFloat CCUICompactModuleContinuousCornerRadius();

#if defined __cplusplus
};
#endif

@interface UIView (Private)
@property (setter=_setContinuousCornerRadius:, nonatomic) CGFloat _continuousCornerRadius;
@end

@interface CCUIModuleSliderView (iOS12)
@property (assign,nonatomic) CGFloat continuousSliderCornerRadius;
@end

@interface CCUIContinuousSliderView : CCUIModuleSliderView //not actually a subclass of CCUIModuleSliderView, this is just to make it compile
@end

__attribute__((always_inline))
inline UIColor *UIColorMake(float r, float g, float b, float a) {
	return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/255.f];
}



@implementation NightShiftModuleContentViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	UIImage *glyph = [UIImage imageNamed:@"Icon_" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
	self.glyphImage = glyph;
	self.selectedGlyphColor = UIColorMake(227, 182, 20, 255);

	return self;
}

- (CGFloat)preferredExpandedContentHeight {
	return CCUISliderExpandedContentModuleHeight();
}

- (CGFloat)preferredExpandedContentWidth {
	return CCUISliderExpandedContentModuleWidth();
}

- (void)viewDidLoad {
	[super viewDidLoad];

	if (NSClassFromString(@"CCUIContinuousSliderView")) {
		self.sliderView = [[NSClassFromString(@"CCUIContinuousSliderView") alloc] initWithFrame:self.view.bounds];
	} else {
		self.sliderView = [[CCUIModuleSliderView alloc] initWithFrame:self.view.bounds];
	}

	self.sliderView.glyphVisible = YES;
	[self.sliderView addTarget:self action:@selector(_sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];

	[self.view addSubview:self.sliderView];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];

	CGFloat cornerRadius = 0;

	if (self.expanded) {
		self.buttonView.alpha = 0.0;
		self.sliderView.alpha = 1.0;
		cornerRadius = CCUIExpandedModuleContinuousCornerRadius();
	} else {
		self.sliderView.alpha = 0.0;
		self.buttonView.alpha = 1.0;
		cornerRadius = CCUICompactModuleContinuousCornerRadius();
	}

	self.sliderView._continuousCornerRadius = cornerRadius;

	if ([self.sliderView respondsToSelector:@selector(setContinuousSliderCornerRadius:)]) {
		self.sliderView.continuousSliderCornerRadius = cornerRadius;
	}

	self.sliderView.frame = self.view.bounds;
}

//Dirty fix for layout bugs when long pressing, actually not so dirty because apple uses the same fix... for all of their expandable modules...
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

	self.buttonView.enabled = !self.expanded;

	[coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext>context) {
		[self.view setNeedsLayout];
		[self.view layoutIfNeeded];
	} completion:nil];
}

- (void)buttonTapped:(id)arg1 forEvent:(id)arg2 {
	BOOL newState = ![self isSelected];
	[self setSelected:newState];

	[self.module toggleEnabled];
}

- (void)_sliderValueDidChange:(id)sender {
	[self.module applyState];
}

- (BOOL)isGroupRenderingRequired {
	return self.sliderView.isGroupRenderingRequired;
}

- (CALayer *)punchOutRootLayer {
	return self.sliderView.punchOutRootLayer;
}

- (BOOL)_canShowWhileLocked {
	return YES;
}
@end
