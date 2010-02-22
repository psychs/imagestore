#import <UIKit/UIKit.h>

int main(int argc, char* argv[])
{
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
