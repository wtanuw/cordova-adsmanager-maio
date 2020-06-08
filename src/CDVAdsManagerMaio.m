
// maio から発行されるメディアIDに差し替えてください。
// NSString * const MEDIA_EID = @"m930e10957e5ff326efc142612c560b86"; // Interstitial Ad (Media ID)
// // NSString * const MEDIA_EID = @"m71f98992e35cdb7c2320997ab8fe3c89" // Video Ad (Media ID)
// NSString * const ZONE_EID1 = @"za865d86d7f0df710a5499fa58cff2cad" // Interstitial Ad (Zone ID)
// NSString * const ZONE_EID2 = @"zc1fdb68b07f3548122476c24139690a1" // Video Ad (Zone ID)
// NSString * const ZONE_EID3 = @"za865d86d7f0df710a5499fa58cff2cad" // Interstitial Ad (Zone ID)


NSString * const Video_MEDIA_EID = @"m33acff8be05f17909e2acec2e4659a37"; // Video Ad (Media ID)
NSString * const Video_ZONE_EID2 = @"z98aad627fa659dd23ef0f7b3b7d1cee8"; // Video Ad (Zone ID)

 NSString * const Int_MEDIA_EID = @"m8032b791f852c97bfa93574494aaca47"; // Interstitial Ad (Media ID)
NSString * const Int_ZONE_EID1 = @"z2a285eff718d97be0e6717063c98d098"; // Interstitial Ad (Zone ID)

#import "CDVAdsManager.h"
#import <Maio/Maio.h>

@interface CDVAdsManager()<MaioDelegate>

//@property (assign) GADAdSize adSize;
//@property (nonatomic, retain) NSDictionary* adExtras;
//@property (nonatomic, retain) NSMutableDictionary* mediations;
//
//@property (nonatomic, retain) NSString* mGender;
//@property (nonatomic, retain) NSArray* mLocation;
//@property (nonatomic, retain) NSString* mForChild;
//@property (nonatomic, retain) NSString* mContentURL;
//
//@property (nonatomic, retain) NSDictionary* mCustomTargeting;
//@property (nonatomic, retain) NSArray* mExclude;
//
//@property (nonatomic, retain) NSString* rewardVideoAdId;
//
//- (GADAdSize)__AdSizeFromString:(NSString *)str;
//- (GADRequest*) __buildAdRequest:(BOOL)forBanner forDFP:(BOOL)fordfp;
//- (NSString *) __getAdMobDeviceId;

@end

@implementation CDVAdsManager
/*
adsManagerExport.initMaioAds = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "AdsManager", "initMaioAd", []);
};

adsManagerExport.showMaioInterstitial = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "AdsManager", "showMaioInterstitialAd", []);
};

adsManagerExport.showMaioRewardVideo = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "AdsManager", "showMaioRewardVideoAd", []);
};
*/
- (void)initMaioAd:(NSString*)adId
{
    // Sets SDK to test mode. Comment out when it is time to release your app.
    [Maio setAdTestMode: YES];

    // Start maio SDK initilization.
    // Change MAIO_MEDIA_ID to media ID from Maio's Dashboard.
    [Maio startWithMediaId: Video_MEDIA_EID delegate: self];
}
- (void)showMaioInterstitialAd:(NSString*)adId
{
    if([Maio canShow]) {
        [Maio startWithNonDefaultMediaId:Int_MEDIA_EID delegate:self];
        [Maio showAtZoneId:Int_ZONE_EID1 vc:[self getViewController]];
    } else {
        [self maioDidFail:Int_ZONE_EID1 reason:MaioFailReasonUnknown];
    }
}
- (void)showMaioRewardVideoAd:(NSString*)adId
{
    if([Maio canShow]) {
        [Maio startWithNonDefaultMediaId:Video_MEDIA_EID delegate:self];
        [Maio showAtZoneId:Video_ZONE_EID2 vc:[self getViewController]];
    } else {
        [self maioDidFail:Video_ZONE_EID2 reason:MaioFailReasonUnknown];
    }
}


// Press button to show ad.
- (IBAction) onOpenAd : (id) sender {
    // If canShow equals YES a video ad will be displayed.
    if([Maio canShow]) {
        [Maio showWithViewController:[self getViewController]];
    }
}

/**
 *  全てのゾーンの広告表示準備が完了したら呼ばれます。
 */
- (void)maioDidInitialize
{
    
}

/**
 *  広告の配信可能状態が変更されたら呼ばれます。
 *
 *  @param zoneId   広告の配信可能状態が変更されたゾーンの識別子
 *  @param newValue 変更後のゾーンの状態。YES なら配信可能
 */
- (void)maioDidChangeCanShow:(NSString *)zoneId newValue:(BOOL)newValue
{
    
}

/**
 *  広告が再生される直前に呼ばれます。
 *  最初の再生開始の直前にのみ呼ばれ、リプレイ再生の直前には呼ばれません。
 *
 *  @param zoneId  広告が表示されるゾーンの識別子
 */
- (void)maioWillStartAd:(NSString *)zoneId
{
    
}

/**
 *  広告の再生が終了したら呼ばれます。
 *  最初の再生終了時にのみ呼ばれ、リプレイ再生の終了時には呼ばれません。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 *  @param playtime 動画の再生時間（秒）
 *  @param skipped  動画がスキップされていたら YES、それ以外なら NO
 *  @param rewardParam  ゾーンがリワード型に設定されている場合、予め管理画面にて設定してある任意の文字列パラメータが渡されます。それ以外の場合は nil
 */
 // Called when video finished playing.
 // ”skipped” equals ”NO” means the user did not watch the add all the way till the end.
 //  Use this delegate to give the user reward for watching the video.
 - (void) maioDidFinishAd: (NSString *) zoneId
                 playtime: (NSInteger) playtime
                  skipped: (BOOL) skipped
              rewardParam: (NSString *) rewardParam {
//     if ([zoneId isEqualToString:Int_ZONE_EID1]) {
//         [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_INTERSTITIAL];
//     } else if ([zoneId isEqualToString:Video_ZONE_EID2]) {
//         [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_REWARDVIDEO];
//     }
 }

/**
 *  広告がクリックされ、ストアや外部リンクへ遷移した時に呼ばれます。
 *
 *  @param zoneId  広告がクリックされたゾーンの識別子
 */
- (void)maioDidClickAd:(NSString *)zoneId
{
    if ([zoneId isEqualToString:Int_ZONE_EID1]) {
        [self fireAdEvent:EVENT_AD_LEAVEAPP withType:ADTYPE_INTERSTITIAL];
    } else if ([zoneId isEqualToString:Video_ZONE_EID2]) {
        [self fireAdEvent:EVENT_AD_LEAVEAPP withType:ADTYPE_REWARDVIDEO];
    }
}

/**
 *  広告が閉じられた際に呼ばれます。
 *
 *  @param zoneId  広告が閉じられたゾーンの識別子
 */
- (void)maioDidCloseAd:(NSString *)zoneId
{
    if ([zoneId isEqualToString:Int_ZONE_EID1]) {
        [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_INTERSTITIAL];
    } else if ([zoneId isEqualToString:Video_ZONE_EID2]) {
        [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_REWARDVIDEO];
    }
}

/**
 *  SDK でエラーが生じた際に呼ばれます。
 *
 *  @param zoneId  エラーに関連するゾーンの識別子
 *  @param reason   エラーの理由を示す列挙値
 */
- (void)maioDidFail:(NSString *)zoneId reason:(MaioFailReason)reason
{
    if ([zoneId isEqualToString:Int_ZONE_EID1]) {
        [self fireAdEvent:EVENT_AD_FAILLOAD withType:ADTYPE_INTERSTITIAL];
    } else if ([zoneId isEqualToString:Video_ZONE_EID2]) {
        [self fireAdEvent:EVENT_AD_FAILLOAD withType:ADTYPE_REWARDVIDEO];
    }
}


//- (void)pluginInitialize
//{
//    [super pluginInitialize];
//
//    self.adSize = [self __AdSizeFromString:@"SMART_BANNER"];
//    self.mediations = [[NSMutableDictionary alloc] init];
//
//    self.mGender = nil;
//    self.mLocation = nil;
//    self.mForChild = nil;
//    self.mContentURL = nil;
//
//    self.mCustomTargeting = nil;
//    self.mExclude = nil;
//
//    self.rewardVideoAdId = nil;
//}
//
//- (NSString*) __getProductShortName { return @"AdMob"; }
//
//- (NSString*) __getTestBannerId {
//    return TEST_BANNER_ID;
//}
//- (NSString*) __getTestInterstitialId {
//    return TEST_INTERSTITIALID;
//}
//- (NSString*) __getTestRewardVideoId {
//  return TEST_REWARDVIDEOID;
//}
//
//- (void) parseOptions:(NSDictionary *)options
//{
//    [super parseOptions:options];
//
//    NSString* str = [options objectForKey:OPT_AD_SIZE];
//    if(str) self.adSize = [self __AdSizeFromString:str];
//    self.adExtras = [options objectForKey:OPT_AD_EXTRAS];
//    if(self.mediations) {
//        // TODO: if mediation need code in, add here
//    }
//    NSArray* arr = [options objectForKey:OPT_LOCATION];
//    if(arr != nil) {
//        self.mLocation = arr;
//    }
//    NSString* n = [options objectForKey:OPT_FORCHILD];
//    if(n != nil) {
//        self.mForChild = n;
//    }
//    str = [options objectForKey:OPT_CONTENTURL];
//    if(str != nil){
//        self.mContentURL = str;
//    }
//    str = [options objectForKey:OPT_GENDER];
//    if(str != nil){
//        self.mGender = str;
//    }
//    NSDictionary* dict = [options objectForKey:OPT_CUSTOMTARGETING];
//    if(dict != nil) {
//        self.mCustomTargeting = dict;
//    }
//    arr = [options objectForKey:OPT_EXCLUDE];
//    if(arr != nil) {
//        self.mExclude = arr;
//    }
//}
//
//- (UIView*) __createAdView:(NSString*)adId {
//
//    if(GADAdSizeEqualToSize(self.adSize, kGADAdSizeInvalid)) {
//        self.adSize = GADAdSizeFromCGSize( CGSizeMake(self.adWidth, self.adHeight) );
//    }
//    if(GADAdSizeEqualToSize(self.adSize, kGADAdSizeInvalid)) {
//        self.adSize = [self __isLandscape] ? kGADAdSizeSmartBannerLandscape : kGADAdSizeSmartBannerPortrait;
//    }
//
//    // safety check to avoid crash if adId is empty
//    if(adId==nil || [adId length]==0) adId = TEST_BANNER_ID;
//
//    GADBannerView* ad = nil;
//    if(* [adId UTF8String] == '/') {
//        ad = [[DFPBannerView alloc] initWithAdSize:self.adSize];
//    } else {
//        ad = [[GADBannerView alloc] initWithAdSize:self.adSize];
//    }
//
//    ad.rootViewController = [self getViewController];
//    ad.delegate = self;
//    ad.adUnitID = adId;
//
//    return ad;
//}
//
//- (GADRequest*) __buildAdRequest:(BOOL)forBanner forDFP:(BOOL)fordfp
//{
//    GADRequest *request = nil;
//
//    if(fordfp) {
//        DFPRequest * req = [DFPRequest request];
//        if(self.mCustomTargeting) {
//            req.customTargeting = self.mCustomTargeting;
//        }
//        if(self.mExclude) {
//            req.categoryExclusions = self.mExclude;
//        }
//        request = req;
//
//    } else {
//        request = [GADRequest request];
//    }
//    if (self.isTesting) {
//        NSString* deviceId = [self __getAdMobDeviceId];
//        request.testDevices = [NSArray arrayWithObjects:deviceId, kGADSimulatorID, nil];
//        NSLog(@"request.testDevices: %@, <Google> tips handled", deviceId);
//    }
//    if(self.mLocation) {
//        double lat = [[self.mLocation objectAtIndex:0] doubleValue];
//        double lng = [[self.mLocation objectAtIndex:1] doubleValue];
//        [request setLocationWithLatitude:lat longitude:lng accuracy:kCLLocationAccuracyBest];
//    }
//    if(self.mForChild) {
//        BOOL forChild = NO;
//        if( [self.mForChild caseInsensitiveCompare:@"yes"] == NSOrderedSame ) forChild = YES;
//        else if( [self.mForChild intValue] != 0 ) forChild = YES;
//        [request tagForChildDirectedTreatment:forChild];
//    }
//    if(self.mContentURL) {
//        request.contentURL = self.mContentURL;
//    }
//    if (self.adExtras) {
//        GADExtras *extras = [[GADExtras alloc] init];
//        NSMutableDictionary *modifiedExtrasDict = [[NSMutableDictionary alloc] initWithDictionary:self.adExtras];
//        [modifiedExtrasDict removeObjectForKey:@"cordova"];
//        [modifiedExtrasDict setValue:@"1" forKey:@"cordova"];
//        extras.additionalParameters = modifiedExtrasDict;
//        [request registerAdNetworkExtras:extras];
//    }
//    [self.mediations enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        AdMobMediation* adMed = (AdMobMediation*) obj;
//        if(adMed) {
//            [adMed joinAdRequest:request];
//        }
//    }];
//    return request;
//}
//
//- (GADAdSize)__AdSizeFromString:(NSString *)str
//{
//    if ([str isEqualToString:@"BANNER"]) {
//        return kGADAdSizeBanner;
//    } else if ([str isEqualToString:@"SMART_BANNER"]) {
//        // Have to choose the right Smart Banner constant according to orientation.
//        if([self __isLandscape]) {
//            return kGADAdSizeSmartBannerLandscape;
//        }
//        else {
//            return kGADAdSizeSmartBannerPortrait;
//        }
//    } else if ([str isEqualToString:@"MEDIUM_RECTANGLE"]) {
//        return kGADAdSizeMediumRectangle;
//    } else if ([str isEqualToString:@"FULL_BANNER"]) {
//        return kGADAdSizeFullBanner;
//    } else if ([str isEqualToString:@"LEADERBOARD"]) {
//        return kGADAdSizeLeaderboard;
//    } else if ([str isEqualToString:@"SKYSCRAPER"]) {
//        return kGADAdSizeSkyscraper;
//    } else if ([str isEqualToString:@"LARGE_BANNER"]) {
//        return kGADAdSizeLargeBanner;
//    } else {
//        return kGADAdSizeInvalid;
//    }
//}
//
//- (NSString *) __getAdMobDeviceId
//{
//    NSUUID* adid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
//    return [self md5:adid.UUIDString];
//}
//
//- (void) __showBanner:(int) position atX:(int)x atY:(int)y
//{
//    GADBannerView* ad = (GADBannerView*) self.banner;
//    if([self __isLandscape]) {
//        if(GADAdSizeEqualToSize(ad.adSize, kGADAdSizeSmartBannerPortrait)) {
//            if(self.isTesting) NSLog(@"change smart banner to landscape mode");
//            ad.adSize = kGADAdSizeSmartBannerLandscape;
//        }
//    } else {
//        if(GADAdSizeEqualToSize(ad.adSize, kGADAdSizeSmartBannerLandscape)) {
//            if(self.isTesting) NSLog(@"change smart banner to portrait mode");
//            ad.adSize = kGADAdSizeSmartBannerPortrait;
//        }
//    }
//
//    [super __showBanner:position atX:x atY:y];
//}
//
//- (int) __getAdViewWidth:(UIView*)view {
//    return view.frame.size.width;
//}
//
//- (int) __getAdViewHeight:(UIView*)view {
//    return view.frame.size.height;
//}
//
//- (void) __loadAdView:(UIView*)view {
//    if(! view) return;
//
//    if([view class] == [DFPBannerView class]) {
//        DFPBannerView* ad = (DFPBannerView*) view;
//        [ad loadRequest:[self __buildAdRequest:true forDFP:true]];
//
//    } else if([view class] == [GADBannerView class]) {
//        GADBannerView* ad = (GADBannerView*) view;
//        [ad loadRequest:[self __buildAdRequest:true forDFP:false]];
//    }
//}
//
//- (void) __pauseAdView:(UIView*)view {
//}
//
//- (void) __resumeAdView:(UIView*)view {
//}
//
//- (void) __destroyAdView:(UIView*)view {
//    if(! view) return;
//    [view removeFromSuperview];
//
//    if([view class] == [DFPBannerView class]) {
//        DFPBannerView* ad = (DFPBannerView*) view;
//        ad.delegate = nil;
//    } else if([view class] == [GADBannerView class]) {
//        GADBannerView* ad = (GADBannerView*) view;
//        ad.delegate = nil;
//    }
//}
//
//- (NSObject*) __createInterstitial:(NSString*)adId {
//    self.interstitialReady = false;
//    // safety check to avoid crash if adId is empty
//    if(adId==nil || [adId length]==0) adId = TEST_INTERSTITIALID;
//
//    GADInterstitial* ad = nil;
//    if(* [adId UTF8String] == '/') {
//        ad = [[DFPInterstitial alloc] initWithAdUnitID:adId];
//    } else {
//        ad = [[GADInterstitial alloc] initWithAdUnitID:adId];
//    }
//    ad.delegate = self;
//    return ad;
//}
//
//- (void) __loadInterstitial:(NSObject*)interstitial {
//    if([interstitial class] == [DFPInterstitial class]) {
//        DFPInterstitial* ad = (DFPInterstitial*) interstitial;
//        [ad loadRequest:[self __buildAdRequest:true forDFP:true]];
//
//    } else if([interstitial class] == [GADInterstitial class]) {
//        GADInterstitial* ad = (GADInterstitial*) interstitial;
//        if(ad) {
//            [ad loadRequest:[self __buildAdRequest:false forDFP:false]];
//        }
//    }
//}
//
//- (void) __showInterstitial:(NSObject*)interstitial {
//    GADInterstitial* ad = (GADInterstitial*) interstitial;
//    if(ad && ad.isReady) {
//        [ad presentFromRootViewController:[self getViewController]];
//    }
//}
//
//- (void) __destroyInterstitial:(NSObject*)interstitial {
//    GADInterstitial* ad = (GADInterstitial*) interstitial;
//    if(ad) {
//        ad.delegate = nil;
//    }
//}
//
//- (NSObject*) __prepareRewardVideoAd:(NSString*)adId {
//    [GADRewardBasedVideoAd sharedInstance].delegate = self;
//    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
//                                           withAdUnitID:adId];
//    return nil;
//}
//
//- (BOOL) __showRewardVideoAd:(NSObject*)rewardvideo {
//    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
//        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:[self getViewController]];
//        return true;
//    }
//    return false;
//}
//
//#pragma mark GADBannerViewDelegate implementation
//
///**
// * document.addEventListener('onAdLoaded', function(data));
// * document.addEventListener('onAdFailLoad', function(data));
// * document.addEventListener('onAdPresent', function(data));
// * document.addEventListener('onAdDismiss', function(data));
// * document.addEventListener('onAdLeaveApp', function(data));
// */
//- (void)adViewDidReceiveAd:(GADBannerView *)adView {
//    if((! self.bannerVisible) && self.autoShowBanner) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self __showBanner:self.adPosition atX:self.posX atY:self.posY];
//        });
//    }
//    [self fireAdEvent:EVENT_AD_LOADED withType:ADTYPE_BANNER];
//}
//
//- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
//    [self fireAdErrorEvent:EVENT_AD_FAILLOAD withCode:(int)error.code withMsg:[error localizedDescription] withType:ADTYPE_BANNER];
//}
//
//- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
//    [self fireAdEvent:EVENT_AD_LEAVEAPP withType:ADTYPE_BANNER];
//}
//
//- (void)adViewWillPresentScreen:(GADBannerView *)adView {
//    [self fireAdEvent:EVENT_AD_PRESENT withType:ADTYPE_BANNER];
//}
//
//- (void)adViewDidDismissScreen:(GADBannerView *)adView {
//    [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_BANNER];
//}
//
///**
// * document.addEventListener('onAdLoaded', function(data));
// * document.addEventListener('onAdFailLoad', function(data));
// * document.addEventListener('onAdPresent', function(data));
// * document.addEventListener('onAdDismiss', function(data));
// * document.addEventListener('onAdLeaveApp', function(data));
// */
//- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
//    [self fireAdErrorEvent:EVENT_AD_FAILLOAD withCode:(int)error.code withMsg:[error localizedDescription] withType:ADTYPE_INTERSTITIAL];
//}
//
//- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
//    self.interstitialReady = true;
//    if (self.interstitial && self.autoShowInterstitial) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self __showInterstitial:self.interstitial];
//        });
//    }
//    [self fireAdEvent:EVENT_AD_LOADED withType:ADTYPE_INTERSTITIAL];
//}
//
//- (void)interstitialWillPresentScreen:(GADInterstitial *)interstitial {
//    [self fireAdEvent:EVENT_AD_PRESENT withType:ADTYPE_INTERSTITIAL];
//}
//
//- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
//    [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_INTERSTITIAL];
//
//    if(self.interstitial) {
//        [self __destroyInterstitial:self.interstitial];
//        self.interstitial = nil;
//    }
//}
//
//- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
//    [self fireAdEvent:EVENT_AD_LEAVEAPP withType:ADTYPE_INTERSTITIAL];
//}
//
//#pragma mark GADRewardBasedVideoAdDelegate
//
///**
// * document.addEventListener('onAdLoaded', function(data));
// * document.addEventListener('onAdFailLoad', function(data));
// * document.addEventListener('onAdPresent', function(data)); // data.rewardType, data.rewardAmount
// * document.addEventListener('onAdDismiss', function(data));
// * document.addEventListener('onAdLeaveApp', function(data));
// */
//
//- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
//   didRewardUserWithReward:(GADAdReward *)reward {
//    NSString* obj = [self __getProductShortName];
//    NSString* json = [NSString stringWithFormat:@"{'adNetwork':'%@','adType':'%@','adEvent':'%@','rewardType':'%@','rewardAmount':%lf}",
//                      obj, ADTYPE_REWARDVIDEO, EVENT_AD_PRESENT, reward.type, [reward.amount doubleValue]];
//    [self fireEvent:obj event:EVENT_AD_PRESENT withData:json];
//}
//
//- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
//    [self fireAdEvent:EVENT_AD_LOADED withType:ADTYPE_REWARDVIDEO];
//}
//
//- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
//    [self fireAdEvent:EVENT_AD_WILLPRESENT withType:ADTYPE_REWARDVIDEO];
//}
//
//- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
//    [self fireAdEvent:EVENT_AD_WILLPRESENT withType:ADTYPE_REWARDVIDEO];
//}
//
//- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
//    [self fireAdEvent:EVENT_AD_DISMISS withType:ADTYPE_REWARDVIDEO];
//}
//
//- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
//    [self fireAdEvent:EVENT_AD_LEAVEAPP withType:ADTYPE_REWARDVIDEO];
//}
//
//- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
//    didFailToLoadWithError:(NSError *)error {
//    [self fireAdErrorEvent:EVENT_AD_FAILLOAD withCode:(int)error.code withMsg:[error localizedDescription] withType:ADTYPE_REWARDVIDEO];
//}

@end
