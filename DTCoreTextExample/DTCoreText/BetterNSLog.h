/////////////////////////////////////////////////////////////////////////////////////
//                                                                                 //
//  The MIT License (MIT)                                                          //
//                                                                                 //
//  Copyright (c) 2014 Matteo Pacini                                               //
//                                                                                 //
//  Permission is hereby granted, free of charge, to any person obtaining a copy   //
//  of this software and associated documentation files (the "Software"), to deal  //
//  in the Software without restriction, including without limitation the rights   //
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      //
//  copies of the Software, and to permit persons to whom the Software is          //
//  furnished to do so, subject to the following conditions:                       //
//                                                                                 //
//  The above copyright notice and this permission notice shall be included in     //
//  all copies or substantial portions of the Software.                            //
//                                                                                 //
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     //
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       //
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    //
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         //
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  //
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN      //
//  THE SOFTWARE.                                                                  //
//                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////

#ifndef BETTER_NSLOG_H
#define BETTER_NSLOG_H

  #import <Foundation/Foundation.h>

  #import <asl.h>

  ///////////////
  // Utilities //
  ///////////////
  
  #define THIS_APP [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

  #define THIS_FILE [(@"" __FILE__) lastPathComponent]

  ////////////
  // _NSLOG //
  ////////////

  //Do-while?
  //https://stackoverflow.com/questions/1067226/c-multi-line-macro-do-while0-vs-scope-block

  #define _NSLog(fmt,...) {                                             \
    do                                                                  \
    {                                                                   \
      NSString *str = [NSString stringWithFormat:fmt, ##__VA_ARGS__];   \
      printf("%s\n",[str UTF8String]);                                  \
      asl_log(NULL, NULL, ASL_LEVEL_NOTICE, "%s", [str UTF8String]);    \
    }                                                                   \
    while (0);                                                          \
  }
    
  /////////////////////
  // NSLog Shadowing //
  /////////////////////
  
  #define NSLog(fmt, ...) _NSLog((@"[%@ %@:%d] %s " fmt), THIS_APP, THIS_FILE, __LINE__, __FUNCTION__, ##__VA_ARGS__)

  //////////
  // DLog //
  //////////
  
  #ifdef DEBUG
      #define DLog(fmt, ...) _NSLog((@"[%@][%@:%d][%s] " fmt),    \
                    THIS_APP,                                     \
                    THIS_FILE,                                    \
                    __LINE__,                                     \
                    __FUNCTION__,                                 \
                    ##__VA_ARGS__)        
  #else
    #define DLog(...)
  #endif
                                         
            
#endif