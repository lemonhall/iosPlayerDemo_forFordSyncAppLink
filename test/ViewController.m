//
//  ViewController.m
//  test
//
//  Created by lemonhall on 13-12-26.
//  Copyright (c) 2013年 lemonhall. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    musicIsPlaying = NO;
    NSError *error;
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Sail" withExtension:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
    audioPlayer.delegate = self;
    audioPlayer.volume = 0.5;
    //[audioPlayer prepareToPlay];
    pBar.progress = 0;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimerTick:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTimerTick:(id)sender {
    if (![audioPlayer isPlaying]) {
        return;
    }
    
    NSTimeInterval totalTime = [audioPlayer duration];
    NSTimeInterval currentTime = [audioPlayer currentTime];
    CGFloat progress = currentTime / totalTime;
    pBar.progress = progress;
}

- (IBAction)play:(id)sender {
    if (musicIsPlaying) {
        //pause music
        [sender setTitle:@"pause" forState:UIControlStateNormal];
        musicIsPlaying = NO;
        [audioPlayer pause];
        NSLog(@"audioPlayer pause");
    }
    else {
        //play music
        [sender setTitle:@"playing" forState:UIControlStateNormal];
        musicIsPlaying = YES;
        [audioPlayer play];
        NSLog(@"audioPlayer play");
        //NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"Sail" withExtension:@"jpg"];
        UIImage *image = [UIImage imageNamed: @"Sail.jpg"];
        [imgTitle setImage:(image)];
//        
//        NSString *urlAsString = @"http://www.douban.com"; NSURL *url = [NSURL URLWithString:urlAsString];
//        NSURLRequest *urlRequest = [NSURLRequest
//                                    requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
//        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response,
//                                                                                            NSData *data, NSError *error) {
//            if ([data length] >0 && error == nil){
//                NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"HTML = %@", html); }
//            else if ([data length] == 0 && error == nil){
//                NSLog(@"Nothing was downloaded."); }
//            else if (error != nil){
//                NSLog(@"Error happened = %@", error); }
//        }];
        
        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"www.douban.com" customHeaderFields:nil];
        MKNetworkOperation *op = [engine operationWithPath:@"/" params:nil httpMethod:@"GET" ssl:NO];
        [op addCompletionHandler:^(MKNetworkOperation *operation) {
            NSLog(@"[operation responseData]-->>%@", [operation responseString]);
        }errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
            NSLog(@"MKNetwork request error : %@", [err localizedDescription]);
        }];  
        [engine enqueueOperation:op];
    }
}

@end
