//
//  Common.h
//  NumberClassificationTest
//
//  Created by Inc.MelonS on 2015. 11. 5..
//  Copyright © 2015년 MelonS. All rights reserved.
//

#ifndef Common_h
#define Common_h

// Generates a random float between 0 and 1
static float randFloat()
{
    return (float)arc4random() / UINT_MAX ;
}

// Generates a random float between imin and imax
static float getRandFloat( float imin, float imax )
{
    return imin + (imax-imin)*randFloat() ;
}

static int getRandInt( int low, int high ) // low ~ high ex)0,3 -> 0,1,2,3
{
    high += 1;
    return low + arc4random() % (high-low) ; // Do not talk to me
    // about "modulo bias" unless you're writing a casino generator
    // or if the "range" between high and low is around 1 million.
}

#endif /* Common_h */
