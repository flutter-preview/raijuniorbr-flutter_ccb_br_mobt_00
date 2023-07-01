/*
GlobalVars

CONSTANTS and Global Variables for this project

*/
const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';
const routeTokenActivate = '/token_activate';
const routeTokenGenerator = '/token_generator';
const routeQRView = '/token/qrViewCCB';
const routeShowAlert = '/common/show_alert';

String tokenCCB = '';
int tokenPeriod = 30;
