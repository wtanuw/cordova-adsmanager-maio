
#import "PluginAdapterDelegate.h"
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>

@protocol CDVAdsManagerPluginAdapterDelegate <NSObject>

- (UIView*) getView;

- (UIViewController*) getViewController;

- (void) fireEvent:(NSString*)obj event:(NSString*)eventName withData:(NSString*)jsonStr;

- (void) sendPluginResult:(CDVPluginResult*)result to:(NSString*)callbackId;

@end

@interface CDVAdsManagerPluginExt : CDVPlugin <CDVAdsManagerPluginAdapterDelegate>

@property(nonatomic, retain) id<CDVAdsManagerPluginAdapterDelegate> adapter;

- (UIView*) getView;
- (UIViewController*) getViewController;
- (void) fireEvent:(NSString *)obj event:(NSString *)eventName withData:(NSString *)jsonStr;
- (void) sendPluginResult:(CDVPluginResult *)result to:(NSString *)callbackId;

@end

@interface CDVAdsManagerGenericAdPlugin : CDVAdsManagerPluginExt

- (void) getAdSettings:(CDVInvokedUrlCommand *)command;
- (void) setOptions:(CDVInvokedUrlCommand *)command;

- (void)createBanner:(CDVInvokedUrlCommand *)command;
- (void)showBanner:(CDVInvokedUrlCommand *)command;
- (void)showBannerAtXY:(CDVInvokedUrlCommand *)command;
- (void)hideBanner:(CDVInvokedUrlCommand *)command;
- (void)removeBanner:(CDVInvokedUrlCommand *)command;

- (void)prepareInterstitial:(CDVInvokedUrlCommand *)command;
- (void)showInterstitial:(CDVInvokedUrlCommand *)command;
- (void)removeInterstitial:(CDVInvokedUrlCommand *)command;
- (void)isInterstitialReady:(CDVInvokedUrlCommand*)command;

- (void) prepareRewardVideoAd:(CDVInvokedUrlCommand *)command;
- (void) showRewardVideoAd:(CDVInvokedUrlCommand *)command;

- (void) fireAdEvent:(NSString*)event withType:(NSString*)adType;
- (void) fireAdErrorEvent:(NSString*)event withCode:(int)errCode withMsg:(NSString*)errMsg withType:(NSString*)adType;

@end

@interface CDVAdsManager : CDVAdsManagerGenericAdPlugin

- (void)initMaioAd:(CDVInvokedUrlCommand*)command;
- (void)showMaioInterstitialAd:(CDVInvokedUrlCommand*)command;
- (void)showMaioRewardVideoAd:(CDVInvokedUrlCommand*)command;

@end
