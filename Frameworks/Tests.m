#import <XCTest/XCTest.h>

@import GCDWebServer;

#pragma clang diagnostic ignored "-Weverything"  // Prevent "messaging to unqualified id" warnings

@interface Tests : XCTestCase
@end

@implementation Tests

- (void)testWebServer {
    GCDWebServer* server = [[GCDWebServer alloc] init];
    XCTAssertNotNil(server);
}

- (void)testDAVServer {
    GCDWebDAVServer* server = [[GCDWebDAVServer alloc] init];
    XCTAssertNotNil(server);
}

- (void)testWebUploader {
    GCDWebUploader* server = [[GCDWebUploader alloc] initWithUploadDirectory:@"test"];
    XCTAssertNotNil(server);
}

- (void)testWebUploaderWithNotNilCustomBundle {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* bundlePath = [bundle pathForResource:@"GCDWebUploader" ofType:@"bundle"];
    if (bundlePath == nil) {
        return nil;
    }
    NSBundle *customBundle = [NSBundle bundleWithPath:bundlePath];
    GCDWebUploader* server = [[GCDWebUploader alloc] initWithUploadDirectory:@"test" customHTMLBundle: customBundle];
    XCTAssertNotNil(server);
}

- (void)testPaths {
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@""), @"");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"/foo/"), @"/foo");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"foo/bar"), @"foo/bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"foo//bar"), @"foo/bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"foo/bar//"), @"foo/bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"foo/./bar"), @"foo/bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"foo/bar/."), @"foo/bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"foo/../bar"), @"bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"/foo/../bar"), @"/bar");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"/foo/.."), @"/");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"/.."), @"/");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"."), @"");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@".."), @"");
    XCTAssertEqualObjects(GCDWebServerNormalizePath(@"../.."), @"");
}

@end
