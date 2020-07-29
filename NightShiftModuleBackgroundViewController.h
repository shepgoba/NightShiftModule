@interface CCUISliderModuleBackgroundViewController : UIViewController
- (void)setGlyphImage:(id)arg1;
- (void)setGlyphPackageDescription:(id)arg1;
- (void)setGlyphState:(id)arg1;
@end

@class NightShiftModule;

@interface NightShiftModuleBackgroundViewController : CCUISliderModuleBackgroundViewController
@property (nonatomic, weak) NightShiftModule *module;
@end
