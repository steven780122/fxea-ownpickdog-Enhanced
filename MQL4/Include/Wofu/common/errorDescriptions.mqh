#ifdef __MQL4__
   #include <stderror.mqh>
   #include <stdlib.mqh>
#endif 
#ifdef __MQL5__
   #include <StdLibErr.mqh>
   #include <migration4to5/errorDescription.mqh>
   //#import "stdlib.ex5"
   //   string ErrorDescription(int error_code);
   //#import
#endif  
/*
#import "kernel32.dll"
   int GetLastError(void);
#import
*/