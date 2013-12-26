//
//  ViewController.h
//  test
//
//  Created by lemonhall on 13-12-26.
//  Copyright (c) 2013年 lemonhall. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate>
{
    BOOL musicIsPlaying;
    AVAudioPlayer *audioPlayer;
    __weak IBOutlet UIProgressView *pBar;
    __weak IBOutlet UIImageView *imgTitle;

}



@end
