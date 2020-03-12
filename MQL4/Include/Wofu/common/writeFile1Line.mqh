#include <Wofu\\common\\logger.mqh>
bool writeFile1Line(string FullFileName,string writeString)
{
   ResetLastError();
   int file_handle=FileOpen(FullFileName,FILE_WRITE|FILE_BIN);
   if(file_handle!=INVALID_HANDLE)
     {
         FileWriteString(file_handle,writeString);
         FileClose(file_handle);
         return true;
     }
   else
     { logger(LOG_DEBUG,__FUNCTION__+":Failed to open "+FullFileName+" file, Error code ="+(string)GetLastError());}
   return false;

}

bool writeFile1Line(string FullFileName,uchar& writeString[])
{
   ResetLastError();
   int file_handle=FileOpen(FullFileName,FILE_WRITE|FILE_BIN);
   if(file_handle!=INVALID_HANDLE)
     {
         FileWriteArray(file_handle,writeString);
         FileClose(file_handle);
         return true;
     }
   else
     { logger(LOG_DEBUG,__FUNCTION__+":Failed to open "+FullFileName+" file, Error code ="+(string)GetLastError());}
   return false;

}
