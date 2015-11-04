//
//  ViewController.m
//  NumberClassificationTest
//
//  Created by Inc.MelonS on 2015. 11. 4..
//  Copyright © 2015년 MelonS. All rights reserved.
//

#import "ViewController.h"

#import "MLPNeuralNet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Use the designated initialiser to pass the network configuration and weights to the model.
    // Note: You do not need to specify the biased units (+1 above) in the configuration.
    
    NSArray *netConfig = @[@3, @1];
    double wts[] = {-30, 20, 20, 20};
    NSData *weights = [NSData dataWithBytes:wts length:sizeof(wts)];
    
    MLPNeuralNet *model = [[MLPNeuralNet alloc] initWithLayerConfig:netConfig
                                                            weights:weights
                                                         outputMode:MLPClassification];
    
    // Predict output of the model for new sample
    double sample[] = {1, 1, 0};
    NSData * vector = [NSData dataWithBytes:sample length:sizeof(sample)];
    NSMutableData * prediction = [NSMutableData dataWithLength:sizeof(double)];
    
    [model predictByFeatureVector:vector intoPredictionVector:prediction];
    
    double * assessment = (double *)prediction.bytes;
    NSLog(@"Model assessment is %f", assessment[0]);
    
    NSLog(@"D-%@",[model description]);
    
    // 진행사항 : 3-1 network 실행테스트만 해봄
    // TODO 1
    // 앞으로 할것 이상태에서 http://destiny738.tistory.com/m/post/455 참고하여
    // 2-1 network 에서 가중치 학습으로 로직추가하기
    // TODO 2
    // 1이 완료된다면 sample 경우의수를 전부다 컨테이너에 넣고 루프를 수행할때마다 선택해서 수행하게 변경하기
    // TODO 3
    // 여기에서는 아 몰랑 자야겠다.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
