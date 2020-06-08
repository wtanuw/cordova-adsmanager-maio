cordova.define("cordova-plugin-adsmanager.AdsManager", function(require, exports, module) {
var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var adsManagerExport = {};

adsManagerExport.initMaioAds = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "AdsManager", "initMaioAd", []);
};

adsManagerExport.showMaioInterstitial = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "AdsManager", "showMaioInterstitialAd", []);
};

adsManagerExport.showMaioRewardVideo = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "AdsManager", "showMaioRewardVideoAd", []);
};

module.exports = adsManagerExport;
});
