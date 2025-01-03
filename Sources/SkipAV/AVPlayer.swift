// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import Foundation
import AVFoundation
#if SKIP
import android.content.Context
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
#endif

public class AVURLAsset {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
}

public struct AVPlayerItem {
    let url: URL

    public init(url: URL) {
        self.url = url
    }
    
    public init(asset: AVURLAsset) {
        self.url = asset.url
    }

    #if SKIP
    var mediaItem: MediaItem {
        MediaItem.fromUri(url.absoluteString)
    }
    #endif
}

public class AVQueuePlayer: AVPlayer { }

public class AVPlayerLooper: AVPlayer {
    
//    #if SKIP
//    override func prepare(_ ctx: Context) {
//        super.prepare(ctx)
//        mediaPlayer?.repeatMode = Player.REPEAT_MODE_ALL
//        mediaPlayer?.playWhenReady = true
//    }
//    #endif
    
    public init(player: AVQueuePlayer, templateItem: AVPlayerItem) {
        super.init(playerItem: templateItem)
        self.playerItems.append(templateItem)
    }
}

public class AVPlayer {
    // MediaSession
    var playerItems: [AVPlayerItem] = [] {
        didSet {
            print("playerItems didSet - oldCount = \(oldValue.count), newCount = \(playerItems.count)")
        }
    }
    #if SKIP
    var mediaPlayer: Player? = nil
    #endif

    public init() {
    }

    #if SKIP
    deinit {
        mediaPlayer?.release()
    }
    #endif

    public init(playerItem: AVPlayerItem?) {
        print("AVPLAYER INIT CALLED")
        if let playerItem = playerItem {
            print("AVPLAYER INIT - ADDING PLAYER ITEM")
            playerItems.append(playerItem)
            print("AVPLAYER INIT - playerItems.count = \(playerItems.count)")
        }
    }

    public convenience init(url: URL) {
        self.init(playerItem: AVPlayerItem(url: url))
    }

    #if SKIP
    func prepare(_ ctx: Context) {
        print("PREPARE - CALLED ")
        guard mediaPlayer == nil else {
            print("PREPARE - mediaPlayer was nil ")
            return
        }
        print("PREPARE - PAST GUARD")
        let mediaPlayer = ExoPlayer.Builder(ctx).build()
        //let mediaSession = MediaSession.Builder(ctx, mediaPlayer).build()
        self.mediaPlayer = mediaPlayer
        mediaPlayer.repeatMode = Player.REPEAT_MODE_ALL
        print("PREPARE - playerItems count = \(self.playerItems.count)")
        for item in self.playerItems {
            print("ADDING MEDIA ITEM")
            mediaPlayer.addMediaItem(item.mediaItem)
        }
        mediaPlayer.prepare()
        mediaPlayer.playWhenReady = true
        print("PREPARE - DONE")
    }
    #endif

    public func play() {
        #if SKIP
        let _ = mediaPlayer?.play()
        #endif
    }

    public func pause() {
        #if SKIP
        let _ = mediaPlayer?.pause()
        #endif
    }

    public func seek(to time: CMTime) {
        #if SKIP
        // mediaPlayer?.seek(time.timeToSeekTime) // TODO: CMTime
        #endif
    }
}
