#import <UIKit/UIKit.h>

%hook TVSBluetoothManager

- (id)delegate {

    %log;
    return %orig;

}

%end

%hook BTDevicePicker

-(void)show { %log; %orig; }
-(void)setDelegate:(id)arg1  { %log; %orig; }
-(void)dealloc { %log; %orig; }
-(void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2  { %log; %orig; }
-(long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2  { %log; long long r = %orig; HBLogDebug(@" = %lld", r); return r; }
-(id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)delegate { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)applicationWillResignActive:(id)arg1  { %log; %orig; }
-(void)alertView:(id)arg1 clickedButtonAtIndex:(long long)arg2  { %log; %orig; }
-(void)dismissAnimated:(BOOL)arg1  { %log; %orig; }
-(void)powerChanged:(id)arg1  { %log; %orig; }
-(void)deviceDiscoveryStoppedHandler:(id)arg1  { %log; %orig; }
-(void)deviceFoundHandler:(id)arg1  { %log; %orig; }
-(void)deviceLostHandler:(id)arg1  { %log; %orig; }
-(void)deviceNameChangedHandler:(id)arg1  { %log; %orig; }
-(void)authenticationRequestHandler:(id)arg1  { %log; %orig; }
-(void)devicePairedHandler:(id)arg1  { %log; %orig; }
-(void)deviceConnectionCompleteHandler:(id)arg1  { %log; %orig; }
-(void)checkAttachTimeout { %log; %orig; }
-(void)showInternal { %log; %orig; }
-(void)cleanupPairing { %log; %orig; }
-(void)_btSSPConfirmationHandler:(id)arg1  { %log; %orig; }
-(void)_btSSPNumericComparisonHandler:(id)arg1  { %log; %orig; }
-(void)_btSSPPasskeyDisplayHandler:(id)arg1  { %log; %orig; }
-(id)initWithTitle:(id)arg1 service:(unsigned)arg2 discoveryNameFilter:(id)arg3  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)alertSheetDismissed:(id)arg1  { %log; %orig; }
-(void)startScanning { %log; %orig; }
%end
%hook TVSettingsBluetoothFacade
+ (long long)numberOfConnectedDevices { %log; long long r = %orig; HBLogDebug(@" = %lld", r); return r; }
+ (long long)numberOfConnectedRemotes { %log; long long r = %orig; HBLogDebug(@" = %lld", r); return r; }
+ (void)updateDevice:(id)arg1 { %log; %orig; }
+ (void)unpairDevice:(id)arg1 { %log; %orig; }
+ (void)disconnectDevice:(id)arg1 { %log; %orig; }
+ (void)connectDevice:(id)arg1 { %log; %orig; }
+ (id)deviceStatusFormatterForDeviceType:(long long)arg1 showConnectedState:(_Bool)arg2 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setConnectedDevices:(NSArray *)connectedDevices { %log; %orig; }
- (NSArray *)connectedDevices { %log; NSArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setOtherDevices:(NSArray *)otherDevices { %log; %orig; }
- (NSArray *)otherDevices { %log; NSArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setMyDevices:(NSArray *)myDevices { %log; %orig; }
- (NSArray *)myDevices { %log; NSArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setRemotes:(NSArray *)remotes { %log; %orig; }
- (NSArray *)remotes { %log; NSArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)_deviceSortDescriptors { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setFilterDeviceScan:(_Bool )filterDeviceScan { %log; %orig; }
- (_Bool )filterDeviceScan { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)stopScanning { %log; %orig; }
- (void)startScanning { %log; %orig; }
- (void)_managerDidUpdate:(id)arg1 { %log; %orig; }
- (void)_updateConnectedDevicesWithSet:(id)arg1 { %log; %orig; }
- (void)_updateOtherDevicesWithSet:(id)arg1 { %log; %orig; }
- (void)_updateMyDevicesWithSet:(id)arg1 { %log; %orig; }
- (void)_updateRemotesWithSet:(id)arg1 { %log; %orig; }
- (void)_willEnterForeground:(id)arg1 { %log; %orig; }
- (void)_didEnterBackground:(id)arg1 { %log; %orig; }
- (void)dealloc { %log; %orig; }
- (id)init { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
%hook TVSettingsBluetoothInfoViewController

@class TVSBluetoothDevice;

- (void)setBluetoothDevice:(id)bluetoothDevice { %log; %orig; }
- (id)bluetoothDevice { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)_updateDevice:(id)arg1 { %log; %orig; }
- (void)_findInfoForAccessory:(id)arg1 { %log; %orig; }
- (void)_connectDevice:(id)arg1 { %log; %orig; }
- (void)_unpairDevice:(id)arg1 { %log; %orig; }
- (void)_disconnectDevice:(id)arg1 { %log; %orig; }
- (id)loadSettingGroups { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
%hook TVSettingsBluetoothViewController
- (void)setErrorAlert:(UIAlertController *)errorAlert { %log; %orig; }
- (UIAlertController *)errorAlert { %log; UIAlertController * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)_devicePairingAction:(id)arg1 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)_postAlertWithErrorCode:(long long)arg1 forDevice:(id)arg2 { %log; %orig; }
- (void)_connectDevice:(id)arg1 { %log; %orig; }
- (void)deviceInfoDidUpdate:(id)arg1 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 didCompleteDeviceDisconnection:(id)arg2 error:(id)arg3 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 didCompleteDeviceConnection:(id)arg2 error:(id)arg3 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 didRejectPairingPINForDevice:(id)arg2 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 didAcceptPairingPINForDevice:(id)arg2 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 presentPairingPIN:(long long)arg2 forDevice:(id)arg3 { %log; %orig; }
- (void)digitEntryViewControllerDidCancel:(id)arg1 { %log; %orig; }
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)loadSettingGroups { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)viewDidLoad { %log; %orig; }
- (void)dealloc { %log; %orig; }
- (id)initWithStyle:(long long)arg1 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)debugDescription { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
//- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
%hook TVPeripheralAgentService
+ (id)sharedInstance { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setDeviceEnforcementAgent:(id)deviceEnforcementAgent { %log; %orig; }
- (id)deviceEnforcementAgent { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setBluetoothRemotePairingAgent:(id)bluetoothRemotePairingAgent { %log; %orig; }
- (id)bluetoothRemotePairingAgent { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setBulletin:(id)bulletin { %log; %orig; }
- (id)bulletin { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setBulletinService:(id )bulletinService { %log; %orig; }
- (id )bulletinService { %log; id  r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)bulletinService:(id)arg1 didDismissBulletin:(id)arg2 withReason:(unsigned long long)arg3 { %log; %orig; }
- (void)_presentPeripheralHUD:(long long)arg1 { %log; %orig; }
- (void)_startListeningForExternalDeviceConnection { %log; %orig; }
- (void)_enforcementAgentWillDisconnectDeviceNotification:(id)arg1 { %log; %orig; }
- (void)_bluetoothRemotePowerSourceLimitedSourceNotification:(id)arg1 { %log; %orig; }
- (void)_checkBatteryLevelForRemote:(id)arg1 { %log; %orig; }
- (void)_bluetoothRemoteDidDetectUserPresenceNotification:(id)arg1 { %log; %orig; }
- (void)_bluetoothRemoteDidDisconnectNotification:(id)arg1 { %log; %orig; }
- (void)_bluetoothRemoteDidConnectNotification:(id)arg1 { %log; %orig; }
- (void)_dismissPairingAgent { %log; %orig; }
- (void)pairingAgentDidTimeout:(id)arg1 { %log; %orig; }
- (void)pairingAgentDidPairRemote:(id)arg1 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 didCompleteDeviceDisconnection:(id)arg2 error:(id)arg3 { %log; %orig; }
- (void)bluetoothManager:(id)arg1 didCompleteDeviceConnection:(id)arg2 error:(id)arg3 { %log; %orig; }
- (void)start { %log; %orig; }
- (void)dealloc { %log; %orig; }
- (NSString *)debugDescription { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
%end

%hook TVPABluetoothRemotePairingManager

+ (id)sharedInstance { %log; return %orig; }
- (void)pairingAgent:(id)arg1 peerDidRequestPairing:(id)arg2 type:(long long)arg3 passkey:(id)arg4 { %log;  %orig; }
- (NSString *)description{ %log; return %orig; }



%end

%hook CBPairingAgent
-(void)handlePairingMessage:(unsigned short)arg1 args:(id)arg2  { %log; %orig; }
-(id)initWithParentManager:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)updateRegistration { %log; %orig; }
-(void)setParentManager:(id)arg1  { %log; %orig; }
-(id)parentManager { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)pairPeer:(id)arg1 options:(id)arg2  { %log; %orig; }
-(void)handlePairingRequested:(id)arg1  { %log; %orig; }
-(void)handlePairingCompleted:(id)arg1  { %log; %orig; }
-(void)handleUnpaired:(id)arg1  { %log; %orig; }
-(void)pairPeer:(id)arg1  { %log; %orig; }
-(void)pairPeer:(id)arg1 useMITM:(BOOL)arg2  { %log; %orig; }
-(void)respondToPairingRequest:(id)arg1 type:(long long)arg2 accept:(BOOL)arg3 data:(id)arg4  { %log; %orig; }
-(void)setUseOOBMode:(BOOL)arg1  { %log; %orig; }
-(id)retrieveOOBDataForPeer:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setOOBPairingEnabled:(BOOL)arg1 forPeer:(id)arg2  { %log; %orig; }
-(BOOL)useOOBMode { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(id)delegate { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setDelegate:(id)arg1  { %log; %orig; }
-(void)dealloc { %log; %orig; }
-(void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void*)arg4  { %log; %orig; }
-(BOOL)isPeerPaired:(id)arg1  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(void)unpairPeer:(id)arg1  { %log; %orig; }
-(BOOL)isPeerCloudPaired:(id)arg1  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(id)retrievePairedPeers { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
%end


%hook CBPeripheralManager
+(long long)authorizationStatus { %log; long long r = %orig; HBLogDebug(@" = %lld", r); return r; }
-(void)handleRestoringState:(id)arg1  { %log; %orig; }
-(void)handleConnectionParametersUpdated:(id)arg1  { %log; %orig; }
-(void)handleAdvertisingAddressChanged:(id)arg1  { %log; %orig; }
-(void)handleMsg:(unsigned short)arg1 args:(id)arg2  { %log; %orig; }

-(void)handleReadyForUpdates:(id)arg1  { %log; %orig; }
-(id)peerWithInfo:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(BOOL)isMsgAllowedWhenOff:(unsigned short)arg1  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(BOOL)isMsgAllowedAlways:(unsigned short)arg1  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(void)handleL2CAPChannelOpened:(id)arg1  { %log; %orig; }
-(void)handleL2CAPChannelClosed:(id)arg1  { %log; %orig; }
-(id)l2capChannelForPeer:(id)arg1 withPsm:(unsigned short)arg2  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)removeAllL2CAPChannels { %log; %orig; }
-(NSHashTable *)l2capChannels { %log; NSHashTable * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)centralWithInfo:(id)arg1  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)forEachCentral:(id)arg1  { %log; %orig; }
-(void)respondToTransaction:(id)arg1 value:(id)arg2 attributeID:(id)arg3 result:(long long)arg4  { %log; %orig; }

-(NSNumber *)multipleAdvertisingSupported { %log; NSNumber * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setMultipleAdvertisingSupported:(NSNumber *)arg1  { %log; %orig; }
-(void)respondToRequest:(id)arg1 withResult:(long long)arg2  { %log; %orig; }
-(void)handleServiceAdded:(id)arg1  { %log; %orig; }

-(void)handleGetAttributeValue:(id)arg1  { %log; %orig; }

-(void)handleSetAttributeValues:(id)arg1  { %log; %orig; }
/*

-(void)handleNotificationAdded:(id)arg1  { %log; %orig; }
-(void)handleNotificationRemoved:(id)arg1  { %log; %orig; }
-(void)handleAdvertisingStarted:(id)arg1  { %log; %orig; }
-(void)handleAdvertisingStopped:(id)arg1  { %log; %orig; }
-(void)handleSolicitedServicesFound:(id)arg1  { %log; %orig; }
-(void)handleL2CAPChannelPublished:(id)arg1  { %log; %orig; }
-(void)handleL2CAPChannelUnpublished:(id)arg1  { %log; %orig; }
-(void)setDesiredConnectionLatency:(long long)arg1 forCentral:(id)arg2  { %log; %orig; }
-(void)removeAllServices { %log; %orig; }
-(BOOL)updateValue:(id)arg1 forCharacteristic:(id)arg2 onSubscribedCentrals:(id)arg3  { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(BOOL)supportsMultipleAdvertising { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(NSMapTable *)centrals { %log; NSMapTable * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(NSMutableDictionary *)characteristicIDs { %log; NSMutableDictionary * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(BOOL)readyForUpdates { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(BOOL)waitingForReady { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(id)init { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(id)delegate { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)setDelegate:(id)arg1  { %log; %orig; }
-(void)dealloc { %log; %orig; }
-(void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void*)arg4  { %log; %orig; }
-(void)publishL2CAPChannelWithEncryption:(BOOL)arg1  { %log; %orig; }
-(void)publishL2CAPChannel:(unsigned short)arg1 requiresEncryption:(BOOL)arg2 options:(id)arg3  { %log; %orig; }
-(void)unpublishL2CAPChannel:(unsigned short)arg1  { %log; %orig; }
-(void)startAdvertising:(id)arg1  { %log; %orig; }
-(BOOL)isAdvertising { %log; BOOL r = %orig; HBLogDebug(@" = %d", r); return r; }
-(void)setIsAdvertising:(BOOL)arg1  { %log; %orig; }
-(void)removeService:(id)arg1  { %log; %orig; }
-(NSMutableArray *)services { %log; NSMutableArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)stopAdvertising { %log; %orig; }
-(id)initWithDelegate:(id)arg1 queue:(id)arg2  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
-(NSLock *)updateLock { %log; NSLock * r = %orig; HBLogDebug(@" = %@", r); return r; }
-(void)addService:(id)arg1  { %log; %orig; }
-(id)initWithDelegate:(id)arg1 queue:(id)arg2 options:(id)arg3  { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }

*/
%end
