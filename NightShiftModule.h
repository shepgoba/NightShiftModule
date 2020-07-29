#import "NightShiftModuleBackgroundViewController.h"
#import "NightShiftModuleContentViewController.h"

#import <ControlCenterUIKit/CCUIContentModule.h>

extern CGFloat whitePointIntensityValueForModuleValue(CGFloat moduleValue);
extern CGFloat moduleValueForWhitePointIntensityValue(CGFloat whitePointIntensityValue);

typedef struct {
	int hour;
	int minute;
} AnonymousStruct3;

typedef struct {
	AnonymousStruct3 fromTime;
	AnonymousStruct3 toTime;
} AnonymousStruct2;

typedef struct {
	BOOL field1;
	BOOL field2;
	BOOL field3;
	int field4;
	AnonymousStruct2 field5;
	unsigned long long field6;
	BOOL field7;
} AnonymousStruct;


@interface CBBlueLightClient : NSObject
-(BOOL)setStrength:(float)arg1 commit:(BOOL)arg2 ;
-(BOOL)setStrength:(float)arg1 withPeriod:(float)arg2 commit:(BOOL)arg3 ;
-(BOOL)getStrength:(float *)arg1 ;
-(BOOL)setEnabled:(BOOL)cum;
-(BOOL)getBlueLightStatus:(AnonymousStruct *)arg1 ;
-(void)setStatusNotificationBlock:(/*^block*/id)arg1 ;
@end

@interface CBClient : NSObject
@property (readonly) CBBlueLightClient *blueLightClient;
@end

@interface NightShiftModule : NSObject <CCUIContentModule> {
	BOOL _ignoreUpdates;
	BOOL _invertPercententageEnabled;
	CBClient *_client;
}
@property (nonatomic, retain) NightShiftModuleContentViewController<CCUIContentModuleContentViewController> *contentViewController;
@property (nonatomic, retain) NightShiftModuleBackgroundViewController *backgroundViewController;
-(void)applyState;
-(void)toggleEnabled;
-(void)updateEnabled;
@end
