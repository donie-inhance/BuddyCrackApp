/*------------------------------------------------------------------------------
 *
 *  ChirpNotifications.h
 *
 *  NSNotification identifiers generated by the Chirp SDK.
 *
 *  This file is part of the Chirp SDK for iOS.
 *  For full information on usage and licensing, see http://chirp.io/
 *
 *  Copyright © 2011-2016, Asio Ltd.
 *  All rights reserved.
 *
 *----------------------------------------------------------------------------*/


/**----------------------------------------------------------------------------*
 * Property keys passed when receiving a notification from the Chirp SDK.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationIdentifierKey                 @"io.chirp.property.identifier"


/**----------------------------------------------------------------------------*
 * Audio notifications: Hear.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationAudioHearStarted             @"io.chirp.audio.hear.started"
#define ChirpNotificationAudioHearComplete            @"io.chirp.audio.hear.complete"
#define ChirpNotificationAudioHearFailed              @"io.chirp.audio.hear.failed"

/**----------------------------------------------------------------------------*
 * Audio notifications: Say.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationAudioSayStarted              @"io.chirp.audio.say.started"
#define ChirpNotificationAudioSayComplete             @"io.chirp.audio.say.complete"
#define ChirpNotificationAudioSayFailed               @"io.chirp.audio.say.failed"

/**----------------------------------------------------------------------------*
 * Audio notifications: State change.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationAudioStateChanged            @"io.chirp.audio.state.changed"
#define ChirpNotificationAudioStateKey                @"io.chirp.audio.state.key"

/**----------------------------------------------------------------------------*
 * Audio notifications: Streaming change.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationStreamingStateChanged        @"io.chirp.streaming.state.changed"
#define ChirpNotificationStreamingStateKey            @"io.chirp.streaming.state.key"


/**----------------------------------------------------------------------------*
 * Audio notifications: Volume change.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationSystemAudioVolumeChanged     @"io.chirp.audio.volume.changed"

/*----------------------------------------------------------------------------*
 * Authentication notifications.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationAuthenticationStateChanged   @"io.chirp.authentication.state.changed"
#define ChirpNotificationAuthenticationStateKey       @"io.chirp.authentication.state.key"

/*----------------------------------------------------------------------------*
 * Network notifications.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationNetworkReachable             @"io.chirp.network.reachability.reachable"
#define ChirpNotificationNetworkUnreachable           @"io.chirp.network.reachability.unreachable"

/*----------------------------------------------------------------------------*
 * Network notifications: Create chirp.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationCreateChirpStarted           @"io.chirp.api.chirp.create.started"
#define ChirpNotificationCreateChirpComplete          @"io.chirp.api.chirp.create.complete"
#define ChirpNotificationCreateChirpFailed            @"io.chirp.api.chirp.create.failed"

/*----------------------------------------------------------------------------*
 * Network notifications: Get chirp.
 *----------------------------------------------------------------------------*/
#define ChirpNotificationGetChirpStarted              @"io.chirp.api.chirp.get.started"
#define ChirpNotificationGetChirpComplete             @"io.chirp.api.chirp.get.complete"
#define ChirpNotificationGetChirpFailed               @"io.chirp.api.chirp.get.failed"
